import 'dart:io';

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';

/// GetX Template Generator - fb.com/htngu.99
///
class FruitNinja extends StatefulWidget {
  @override
  _FruitNinjaState createState() => _FruitNinjaState();
}

class _FruitNinjaState extends State<FruitNinja> {
  List<Fruit> fruits=[];
  List<Bomb> bombs=[];
  int score=0;
  Random random=new Random();

  @override
  void initState() {
    super.initState();
    fruits = [];
    bombs = [];
    score = 0;
    random = Random();
    startGame();
  }

  void startGame() {
    const duration = Duration(milliseconds: 1000);
    Timer.periodic(duration, (timer) {
      addFruit();
      addBomb();
    });
  }

  void addFruit() {
    setState(() {
      final type = FruitType.values[random.nextInt(FruitType.values.length)];
      final fruit = Fruit(type);
      fruits.add(fruit);
    });
  }

  void addBomb() {
    setState(() {
      final bomb = Bomb();
      bombs.add(bomb);
    });
  }

  void sliceFruit(Fruit fruit) {
    setState(() {
      fruit.isSliced = true;
      if (fruit.type != FruitType.bomb) {
        score += 1;
      }
    });
  }

  void gameOver() {
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
                setState(() {
                  fruits.clear();
                  bombs.clear();
                  score = 0;
                });
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Fruit Ninja Clone'),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          for (var fruit in fruits) {
            if (!fruit.isSliced && fruit.isSlicedWith(details.globalPosition)) {
              sliceFruit(fruit);
            }
          }
          for (var bomb in bombs) {
            if (bomb.isTouchedWith(details.globalPosition)) {
              gameOver();
            }
          }
        },
        child: Stack(
          children: [
            Container(
              color: Colors.blue,
            ),
            for (var fruit in fruits)
              if (!fruit.isSliced)
                Positioned(
                  left: fruit.position.dx,
                  top: fruit.position.dy,
                  child: fruitWidget(fruit.type),
                ),
            for (var bomb in bombs)
              Positioned(
                left: bomb.position.dx,
                top: bomb.position.dy,
                child: bombWidget(),
              ),
          ],
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

  Widget fruitWidget(FruitType type) {
    switch (type) {
      case FruitType.apple:
        return Image.asset('assets/Images/success.jpg', width: 60, height: 60);
      case FruitType.orange:
        return Image.asset('assets/Images/success.jpg', width: 60, height: 60);
      case FruitType.banana:
        return Image.asset('assets/Images/success.jpg', width: 60, height: 60);
      default:
        return Container();
    }
  }

  Widget bombWidget() {
    return Image.asset('assets/Images/wrong.jpg', width: 60, height: 60);
  }
}

enum FruitType { apple, orange, banana, bomb }

class Fruit {
  final FruitType type;
  final Offset position;
  bool isSliced = false;

  Fruit(this.type)
      : position = Offset(
    Random().nextDouble() * 300 + 20,
    Random().nextDouble() * 500 + 100,
  );

  bool isSlicedWith(Offset globalPosition) {
    return Rect.fromCenter(
      center: position,
      width: 60,
      height: 60,
    ).contains(globalPosition);
  }
}

class Bomb {
  final Offset position;

  Bomb()
      : position = Offset(
    Random().nextDouble() * 300 + 20,
    Random().nextDouble() * 500 + 100,
  );

  bool isTouchedWith(Offset globalPosition) {
    return Rect.fromCenter(
      center: position,
      width: 60,
      height: 60,
    ).contains(globalPosition);
  }
}