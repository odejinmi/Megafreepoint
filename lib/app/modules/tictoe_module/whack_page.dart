import 'dart:io';

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';

class WhackAMole extends StatefulWidget {
  @override
  _WhackAMoleState createState() => _WhackAMoleState();
}

class _WhackAMoleState extends State<WhackAMole> {
  List<bool> moles=[];
  int score=0;
  Random random=new Random();

  @override
  void initState() {
    super.initState();
    moles = List.generate(9, (index) => false);
    score = 0;
    random = Random();
    startGame();
  }

  void startGame() {
    const duration = Duration(seconds: 1);
    Timer.periodic(duration, (timer) {
      updateMoles();
    });
  }

  void updateMoles() {
    setState(() {
      moles = List.generate(9, (index) => random.nextBool());
    });
  }

  void whackMole(int index) {
    if (moles[index]) {
      setState(() {
        score += 1;
        moles[index] = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whack-a-Mole Game'),
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => whackMole(index),
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: moles[index] ? Colors.brown : Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: moles[index]
                      ? Icon(Icons.android, size: 40, color: Colors.black)
                      : null,
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Score: $score',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}