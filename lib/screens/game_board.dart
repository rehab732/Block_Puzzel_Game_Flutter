import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:puzzle/classes/piece.dart';
import 'package:puzzle/constants/values.dart';
import 'package:puzzle/widgets/pixel.dart';

import '../constants/directions.dart';
import '../constants/lenght.dart';

List<List<Teromino?>> gameBoard = List.generate(
    collenght,
    (i) => List.generate(
          rowlenght,
          (j) => null,
        ),
        );

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece current = Piece(type: Teromino.L);

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    current.inizalizePiece();
    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  void gameLoop(Duration framRate) {
    Timer.periodic(framRate, (timer) {
      setState(() {
        checkLanding();
        current.movePiece(Directions.down);
      });
    });
  }

  bool checkCollision(Directions directions) {
    for (int i = 0; i < current.positions.length; i++) {
      int row = (current.positions[i] / rowlenght).floor();
      int columm = current.positions[i] % rowlenght;
      if (directions == Directions.left) {
        columm -= 1;
      } else if (directions == Directions.right) {
        columm += 1;
      } else if (directions == Directions.down) {
        row += 1;
      }

      if (row >= collenght || columm < 0 || columm >= rowlenght) {
        return true;
      }
    }
    return false;
  }

  void checkLanding() {
    if (checkCollision(Directions.down)) {
      for (int i = 0; i < current.positions.length; i++) {
        int row = (current.positions[i] / rowlenght).floor();
        int columm = current.positions[i] % rowlenght;
        if (row >= 0 && columm >= 0) {
          gameBoard[row][columm] = current.type;
        }
      }

      createNewPiece();
    }
  }

  void createNewPiece() {
    //create random Teromino
    Random random = Random();
    Teromino randomType =
        Teromino.values[random.nextInt(Teromino.values.length)];

    current = Piece(type: randomType);
    current.inizalizePiece();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: GridView.builder(
            itemCount: rowlenght * collenght,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: rowlenght,
            ),
            itemBuilder: (context, index) {
              int row = (index / rowlenght).floor();
              int columm = index % rowlenght;
              if (current.positions.contains(index)) {
                return Pixel(
                  color: Colors.red,
                  child: index.toString(),
                );
              } else if (gameBoard[row][columm] != null) {
                return Pixel(color: Colors.pink, child: '');
              } else {
                return Pixel(
                  color: Colors.grey[900]!,
                  child: index.toString(),
                );
              }
            }));
  }
}
