import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:puzzle/classes/piece.dart';
import 'package:puzzle/constants/values.dart';
import 'package:puzzle/widgets/pixel.dart';

import '../constants/colors.dart';
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
  int currentScore = 0;
  bool gameOver = false;
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
        clearLines();
        checkLanding();
        if (gameOver == true) {
          timer.cancel();
          showGameDialog();
        }
        current.movePiece(Directions.down);
      });
    });
  }

  void showGameDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title:const Text("GAME OVER"),
              content: Text("Your Score is : $currentScore"),
              actions: [
                TextButton(
                    onPressed: () {
                      resetGame();
                      Navigator.pop(context);
                    },
                    child:const Text("Reset Game"))
              ],
            ));
  }

  void resetGame() {
    gameBoard = List.generate(
      collenght,
      (i) => List.generate(
        rowlenght,
        (j) => null,
      ),
    );

    gameOver = false;
    currentScore = 0;
    createNewPiece();
    startGame();
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
        int row = (current.positions[i]/ rowlenght).floor();
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
    if (isGameOver()) {
      gameOver = true;
    }
  }

  void moveLeft() {
    if (!checkCollision(Directions.left)) {
      setState(() {
        current.movePiece(Directions.left);
      });
    }
  }

  void rotatePiece() {
    setState(() {
      current.rotatePiece();
    });
  }

  void moveRight() {
    if (!checkCollision(Directions.right)) {
      setState(() {
        current.movePiece(Directions.right);
      });
    }
  }

  void clearLines() {
    for (int row = collenght - 1; row >= 0; row--) {
      bool rowIsFull = true;
      for (int col = 0; col < rowlenght; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }
      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        gameBoard[0] == List.generate(row, (index) => null);
        currentScore++;
      }
    }
  }

  bool isGameOver() {
    for (int col = 0; col < rowlenght; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
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
                        color: current.color,
                        
                      );
                    } else if (gameBoard[row][columm] != null) {
                      final Teromino? terType = gameBoard[row][columm];

                      return Pixel(color: tercolor[terType]!);
                    } else {
                      return Pixel(
                        color: Colors.grey[900]!,
                      );
                    }
                  }),
            ),
            Text(
              'Score $currentScore',
              style:const TextStyle(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0, top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: moveLeft,
                      color: Colors.white,
                      icon: const Icon(Icons.arrow_back_ios)),
                  IconButton(
                      onPressed: rotatePiece,
                      color: Colors.white,
                      icon: const Icon(Icons.rotate_right)),
                  IconButton(
                      onPressed: moveRight,
                      color: Colors.white,
                      icon: const Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ],
        ),
        );
  }
}

