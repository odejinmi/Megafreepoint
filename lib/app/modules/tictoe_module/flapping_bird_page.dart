import 'dart:io';

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';

class FlappyBird extends StatefulWidget {
  @override
  _FlappyBirdState createState() => _FlappyBirdState();
}

class _FlappyBirdState extends State<FlappyBird> {
  double birdY = 0;
  double birdYVelocity = 0;
  double gravity = 0.4;
  double jump = -7;
  bool isGameStarted = false;
  int score = 0;

  void startGame() {
    birdY = 0;
    birdYVelocity = 0;
    score = 0;
    isGameStarted = true;
    Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {
        birdYVelocity += gravity;
        birdY += birdYVelocity;
        if (birdY > 1) {
          birdY = 1;
          birdYVelocity = 0;
        }
      });
      if (!isGameStarted) {
        timer.cancel();
      }
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (isGameStarted) {
        setState(() {
          score++;
        });
      }
    });
  }

  void jumpBird() {
    setState(() {
      birdYVelocity = jump;
    });
  }

  void gameOver() {
    isGameStarted = false;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Your Score: $score'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                startGame();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isGameStarted) {
          startGame();
        } else {
          jumpBird();
        }
      },
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Image.asset('assets/Images/sky.jpg', fit: BoxFit.cover),
              AnimatedContainer(
                alignment: Alignment(0, birdY),
                duration: Duration(milliseconds: 30),
                child: Image.asset('assets/Images/bird.png'),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: Text(
                  'Score: $score',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}