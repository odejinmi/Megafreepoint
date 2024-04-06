import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megafreepoint/app/components/custom_alert_dialog.dart';
import 'package:megafreepoint/app/data/provider/Globalvariable.dart';

import '../../provider/adsProvider.dart';

class BrickBreaker extends StatefulWidget {
  @override
  _BrickBreakerState createState() => _BrickBreakerState();
}

class _BrickBreakerState extends State<BrickBreaker> {
  double paddleX = 0.4;
  double ballX = 0.5;
  double ballY = 0.8;
  double ballRadius = 0.02;
  double ballXSpeed = 0.008;
  double ballYSpeed = 0.008;
  double brickWidth = 0.1;
  double brickHeight = 0.04;
  List<Brick> bricks = [];
  int score = 0;
  int lives = 3;
  bool isGameOver = false;
  Random random = Random();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () async {
      CustomAlertDialogloader(
        title: "How Points are Earned!!",
        message:
            "You earned points on every 5 hundredth score. And you have 4 miss attempts.",
        negativeBtnText: "Start Game",
        onNegativePressed: () {
          startGame();
        },
      );
    });
  }

  void startGame() {
    setState(() {
      isGameOver = false;
      lives = 3;
      score = 0;
    });
    const duration = Duration(milliseconds: 10);
    bricks = [];
    for (double y = 0.1; y < 0.4; y += brickHeight + 0.01) {
      for (double x = 0; x < 1; x += brickWidth + 0.01) {
        bricks.add(Brick(x, y));
      }
    }
    Timer.periodic(duration, (timer) {
      if (isGameOver) {
        timer.cancel();
      } else {
        updateGame();
      }
    });
  }

  void updateGame() {
    setState(() {
      ballX += ballXSpeed;
      ballY -= ballYSpeed;
      if (ballX - ballRadius <= 0 || ballX + ballRadius >= 1) {
        ballXSpeed *= -1;
      }
      if (ballY - ballRadius <= 0) {
        ballYSpeed *= -1;
      }
      if (ballY + ballRadius >= 1) {
        loseLife();
      }
      if (ballY + ballRadius >= 0.9) {
        if (ballX >= paddleX && ballX <= paddleX + 0.2) {
          ballYSpeed *= -1;
          score += 10;
        }
      }
      for (int i = 0; i < bricks.length; i++) {
        if (ballCollidesWithBrick(bricks[i])) {
          bricks.removeAt(i);
          i--;
          score += 5;

          var cPoint = score / 500;

          if (cPoint == 1 || cPoint == 2 || cPoint == 3 || cPoint == 4) {
            addpoint();
          }
        }
      }
      if (bricks.isEmpty) {
        winGame();
      }
    });
  }

  void loseLife() {
    setState(() {
      lives -= 1;
      ballX = 0.5;
      ballY = 0.8;
      ballXSpeed = 0.008;
      ballYSpeed = 0.008;
      paddleX = 0.4;
      if (lives == 0) {
        gameOver();
      }
    });
  }

  void winGame() {
    setState(() {
      isGameOver = true;
    });
  }

  void gameOver() {
    setState(() {
      isGameOver = true;
    });

    Get.find<AdsProvider>().showreawardads(() {});
  }

  bool ballCollidesWithBrick(Brick brick) {
    double brickLeft = brick.x;
    double brickRight = brick.x + brickWidth;
    double brickTop = brick.y;
    double brickBottom = brick.y + brickHeight;

    if (ballX + ballRadius >= brickLeft &&
        ballX - ballRadius <= brickRight &&
        ballY + ballRadius >= brickTop &&
        ballY - ballRadius <= brickBottom) {
      if (ballX < brickLeft || ballX > brickRight) {
        ballXSpeed *= -1;
      } else {
        ballYSpeed *= -1;
      }
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brick Breaker Game'),
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (!isGameOver) {
            setState(() {
              paddleX += details.delta.dx / MediaQuery.of(context).size.width;
              paddleX = paddleX.clamp(0, 0.8);
            });
          }
        },
        child: Stack(
          children: [
            Container(
              color: Colors.black,
            ),
            for (var brick in bricks)
              Positioned(
                left: brick.x * MediaQuery.of(context).size.width,
                top: brick.y * MediaQuery.of(context).size.height,
                child: Container(
                  width: brickWidth * MediaQuery.of(context).size.width,
                  height: brickHeight * MediaQuery.of(context).size.height,
                  color: Colors.blue,
                ),
              ),
            Positioned(
              left: paddleX * MediaQuery.of(context).size.width,
              bottom: 3,
              child: Container(
                width: 0.2 * MediaQuery.of(context).size.width,
                height: 0.02 * MediaQuery.of(context).size.height,
                color: Colors.green,
              ),
            ),
            Positioned(
              left: ballX * MediaQuery.of(context).size.width,
              top: ballY * MediaQuery.of(context).size.height,
              child: Container(
                width: 2 * ballRadius * MediaQuery.of(context).size.width,
                height: 2 * ballRadius * MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            if (isGameOver)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Game Over',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      'Score: $score',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(9),
                          child: Text(
                            'Start Again',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          )),
                      onTap: () {
                        startGame();
                      },
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Brick {
  final double x;
  final double y;

  Brick(this.x, this.y);
}
