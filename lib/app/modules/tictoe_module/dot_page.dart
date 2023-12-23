import 'dart:io';

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';

class TapTheDot extends StatefulWidget {
  @override
  _TapTheDotState createState() => _TapTheDotState();
}

class _TapTheDotState extends State<TapTheDot> {
  double dotX = 50.0;
  double dotY = 50.0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    const duration = Duration(milliseconds: 500);
    Timer.periodic(duration, (_) {
      updateDotPosition();
    });
  }

  void updateDotPosition() {
    final random = Random();
    setState(() {
      dotX = random.nextDouble() * (MediaQuery.of(context).size.width - 50);
      dotY = random.nextDouble() * (MediaQuery.of(context).size.height - 50);
    });
  }

  void onTapDown(BuildContext context, TapDownDetails details) {
    final x = details.globalPosition.dx;
    final y = details.globalPosition.dy;
    if (x >= dotX && x <= dotX + 50 && y >= dotY && y <= dotY + 50) {
      setState(() {
        score++;
      });
      updateDotPosition();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tap the Dot Game'),
      ),
      body: GestureDetector(
        onTapDown: (details) => onTapDown(context, details),
        child: Center(
          child: Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                margin: EdgeInsets.only(left: dotX, top: dotY),
              ),
              Positioned(
                top: 20,
                left: 20,
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