import 'package:flutter/material.dart';
import 'package:puzzle/widgets/pixel.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  int rowlenght = 10;
  int collenght = 15;
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
          itemBuilder: (context, index) => Center(
                  child: Pixel(
                color: Colors.grey[900]!,
                child: index.toString(),
              ))),
    );
  }
}
