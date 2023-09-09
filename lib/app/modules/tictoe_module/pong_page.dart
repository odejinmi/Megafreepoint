import 'dart:io';

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';

class Pong extends StatefulWidget {
  @override
  _PongState createState() => _PongState();
}

class _PongState extends State<Pong> {
  double ballX = 0.5;
  double ballY = 0.5;
  double ballXSpeed = 0.007;
  double ballYSpeed = 0.007;
  double paddle1Y = 0.4;
  double paddle2Y = 0.4;
  double paddleHeight = 0.2;
  bool isGameStarted = false;
  int player1Score = 0;
  int player2Score = 0;

  void startGame() {
    isGameStarted = true;
    ballX = 0.5;
    ballY = 0.5;
    ballXSpeed = 0.020;
    ballYSpeed = 0.013;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      setState(() {
        ballX += ballXSpeed;
        ballY += ballYSpeed;
        // Check for collisions with top and bottom walls
        if (ballY <= 0 || ballY >= 1) {
          ballYSpeed *= -1;
        }
        // Check for collisions with paddles
        if (ballX <= 0 || ballX >= 1) {
          if ((ballX <= 0 && ballY >= paddle1Y && ballY <= paddle1Y + paddleHeight) ||
              (ballX >= 1 && ballY >= paddle2Y && ballY <= paddle2Y + paddleHeight)) {
            ballXSpeed *= -1;
          } else {
            // Ball missed a paddle
            if (ballX <= 0) {
              player2Score++;
            } else {
              player1Score++;
            }
            isGameStarted = false;
            timer.cancel();
          }
        }
      });
    });
  }

  void movePaddle(double deltaY) {
    setState(() {
      paddle1Y += deltaY;
      if (paddle1Y < 0) {
        paddle1Y = 0;
      }
      if (paddle1Y + paddleHeight > 1) {
        paddle1Y = 1 - paddleHeight;
      }

      paddle2Y += deltaY;
      if (paddle2Y < 0) {
        paddle2Y = 0;
      }
      if (paddle2Y + paddleHeight > 1) {
        paddle2Y = 1 - paddleHeight;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pong Game'),
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) => movePaddle(details.delta.dy / MediaQuery.of(context).size.height),
        onTap: () {
          if (!isGameStarted) {
            startGame();
          }
        },
        child: Center(
          child: Stack(
            children: [
              Container(
                color: Colors.black,
              ),
              Positioned(
                left: ballX * MediaQuery.of(context).size.width,
                top: ballY * MediaQuery.of(context).size.height,
                child: Container(
                  width: 20,
                  height: 20,
                  color: Colors.white,
                ),
              ),
              Positioned(
                left: 10,
                top: paddle1Y * MediaQuery.of(context).size.height,
                child: Container(
                  width: 10,
                  height: paddleHeight * MediaQuery.of(context).size.height,
                  color: Colors.white,
                ),
              ),
              Positioned(
                right: 10,
                top: paddle2Y * MediaQuery.of(context).size.height,
                child: Container(
                  width: 10,
                  height: paddleHeight * MediaQuery.of(context).size.height,
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  'Player 1: $player1Score',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: Text(
                  'Player 2: $player2Score',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              if (!isGameStarted)
                Center(
                  child: Text(
                    'Tap to Start',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}