import 'package:flutter/material.dart';
import 'package:puzzle/classes/piece.dart';
import 'package:puzzle/constants/values.dart';
import 'package:puzzle/widgets/pixel.dart';

import '../constants/lenght.dart';

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
              if(current.positions.contains(index))
              {
                  return Pixel(
                color: Colors.red,
                child: index.toString(),
              );
              }else{
                  return Pixel(
                color: Colors.grey[900]!,
                child: index.toString(),
              );
              }
            
            }));
  }
}
