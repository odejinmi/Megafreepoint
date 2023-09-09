import 'dart:io';

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';

class Game2048 extends StatefulWidget {
  @override
  _Game2048State createState() => _Game2048State();
}

class _Game2048State extends State<Game2048> {
  final int gridSize = 4;
  List<List<int>> board=[];
  Random random = Random();
  bool isGameOver = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    board = List.generate(gridSize, (row) => List<int>.filled(gridSize, 0));
    addRandomTile();
    addRandomTile();
  }

  void addRandomTile() {
    List<int> emptyCells = [];
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        if (board[row][col] == 0) {
          emptyCells.add(row * gridSize + col);
        }
      }
    }
    if (emptyCells.isEmpty) return;

    int randomIndex = random.nextInt(emptyCells.length);
    int randomCell = emptyCells[randomIndex];
    int row = randomCell ~/ gridSize;
    int col = randomCell % gridSize;

    board[row][col] = (random.nextInt(2) + 1) * 2; // Either 2 or 4
  }

  void swipeLeft() {
    if (isGameOver) return;

    bool hasChanged = false;

    for (int row = 0; row < gridSize; row++) {
      List<int> newRow = [];
      for (int col = 0; col < gridSize; col++) {
        if (board[row][col] != 0) {
          newRow.add(board[row][col]);
        }
      }

      for (int i = 0; i < newRow.length - 1; i++) {
        if (newRow[i] == newRow[i + 1]) {
          newRow[i] *= 2;
          newRow[i + 1] = 0;
          hasChanged = true;
        }
      }

      newRow.removeWhere((cell) => cell == 0);
      newRow.addAll(List<int>.filled(gridSize - newRow.length, 0));
      if (board[row] != newRow) {
        hasChanged = true;
        board[row] = newRow;
      }
    }

    if (hasChanged) {
      addRandomTile();
      checkGameOver();
    }
  }

  void swipeRight() {
    if (isGameOver) return;

    rotateBoard(2);
    swipeLeft();
    rotateBoard(2);
  }

  void swipeUp() {
    if (isGameOver) return;

    rotateBoard(1);
    swipeLeft();
    rotateBoard(3);
  }

  void swipeDown() {
    if (isGameOver) return;

    rotateBoard(3);
    swipeLeft();
    rotateBoard(1);
  }

  void rotateBoard(int times) {
    for (int i = 0; i < times; i++) {
      List<List<int>> newBoard = List.generate(gridSize, (row) => List<int>.filled(gridSize, 0));
      for (int row = 0; row < gridSize; row++) {
        for (int col = 0; col < gridSize; col++) {
          newBoard[col][gridSize - row - 1] = board[row][col];
        }
      }
      board = newBoard;
    }
  }

  void checkGameOver() {
    bool isFull = true;
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        if (board[row][col] == 0) {
          isFull = false;
          break;
        }
      }
    }

    bool canMove = false;
    if (!isFull) {
      canMove = true;
    } else {
      for (int row = 0; row < gridSize; row++) {
        for (int col = 0; col < gridSize - 1; col++) {
          if (board[row][col] == board[row][col + 1]) {
            canMove = true;
            break;
          }
        }
      }
      for (int col = 0; col < gridSize; col++) {
        for (int row = 0; row < gridSize - 1; row++) {
          if (board[row][col] == board[row + 1][col]) {
            canMove = true;
            break;
          }
        }
      }
    }

    if (!canMove) {
      setState(() {
        isGameOver = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2048'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Swipe to merge tiles and reach 2048!',
              style: TextStyle(fontSize: 18),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridSize,
              childAspectRatio: 1.0,
            ),
            itemCount: gridSize * gridSize,
            itemBuilder: (BuildContext context, int index) {
              int row = index ~/ gridSize;
              int col = index % gridSize;
              int value = board[row][col];
              // Color? tileColor = Colors.grey[300];
              Color? tileColor = value == 0 ? Colors.grey[300] : Colors.primaries[value.floor() % 9];
              return Container(
                margin: EdgeInsets.all(4),
                color: tileColor,
                child: Center(
                  child: value == 0 ? null : Text(
                    '$value',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
          if (isGameOver)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Game Over! Tap to restart.',
                style: TextStyle(fontSize: 18),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isGameOver) {
            setState(() {
              isGameOver = false;
            });
            startGame();
          }
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}