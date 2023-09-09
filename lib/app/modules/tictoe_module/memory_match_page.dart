import 'dart:io';

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';

class MemoryMatch extends StatefulWidget {
  @override
  _MemoryMatchState createState() => _MemoryMatchState();
}

class _MemoryMatchState extends State<MemoryMatch> {
  List<String> cards = [
    '🐱', '🐱', '🐶', '🐶', '🐻', '🐻', '🐰', '🐰', '🐼', '🐼', '🐨', '🐨', '🐯', '🐯', '🦁', '🦁'
  ];
  List<bool> cardFlips=[];
  int prevCardIndex=0;
  int pairsFound=0;
  int attempts=0;
  bool isGameOver=false;

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    cards.shuffle();
    cardFlips = List.generate(cards.length, (index) => false);
    prevCardIndex = -1;
    pairsFound = 0;
    attempts = 0;
    isGameOver = false;
  }

  void flipCard(int index) {
    if (!isGameOver && !cardFlips[index]) {
      setState(() {
        cardFlips[index] = true;
        if (prevCardIndex == -1) {
          prevCardIndex = index;
        } else {
          // Check if the two flipped cards match
          if (cards[index] != cards[prevCardIndex]) {
            Future.delayed(Duration(seconds: 1), () {
              // If not a match, flip them back over after a delay
              setState(() {
                cardFlips[index] = false;
                cardFlips[prevCardIndex] = false;
                prevCardIndex = -1;
              });
            });
          } else {
            // If they match, keep them face-up
            pairsFound++;
            prevCardIndex = -1;
          }
          attempts++;
        }
        if (pairsFound == cards.length ~/ 2) {
          // All pairs have been found
          isGameOver = true;
        }
      });
    }
  }

  void restartGame() {
    setState(() {
      initializeGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Match Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Attempts: $attempts',
              style: TextStyle(fontSize: 24),
            ),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => flipCard(index),
                  child: Card(
                    color: cardFlips[index] ? Colors.white : Colors.blue,
                    elevation: 4,
                    margin: EdgeInsets.all(4),
                    child: Center(
                      child: Text(
                        cardFlips[index] ? cards[index] : '',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            if (isGameOver)
              ElevatedButton(
                onPressed: restartGame,
                child: Text('Restart Game'),
              ),
          ],
        ),
      ),
    );
  }
}