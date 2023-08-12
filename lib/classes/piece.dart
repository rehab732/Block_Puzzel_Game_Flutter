import 'package:flutter/material.dart';
import 'package:puzzle/constants/lenght.dart';
import 'package:puzzle/constants/values.dart';
import 'package:puzzle/screens/game_board.dart';
import '../constants/colors.dart';
import '../constants/directions.dart';

class Piece {
  Teromino type;
  Piece({required this.type});

  List<int> positions = [];
  Color get color {
    return tercolor[type] ?? Colors.white;
  }

  void inizalizePiece() {
    switch (type) {
      case Teromino.L:
        positions = [-26, -16, -6, -5];
        break;
      case Teromino.J:
        positions = [-25, -15, -5, -6];
        break;
      case Teromino.I:
        positions = [-4, -5, -6, -7];
        break;
      case Teromino.O:
        positions = [-15, -16, -5, -6];
        break;
      case Teromino.S:
        positions = [-15, -14, -6, -5];
        break;
      case Teromino.Z:
        positions = [-17, -16, -6, -5];
        break;

      case Teromino.T:
        positions = [-26, -16, -6, -15];
        break;
      default:
    }
  }

  void movePiece(Directions direction) {
    switch (direction) {
      case Directions.down:
        for (var i = 0; i < positions.length; i++) {
          positions[i] += rowlenght;
        }
        break;
      case Directions.left:
        for (var i = 0; i < positions.length; i++) {
          positions[i] -= 1;
        }
        break;
      case Directions.right:
        for (var i = 0; i < positions.length; i++) {
          positions[i] += 1;
        }
        break;
      default:
    }
  }

  int rotateState = 1;
  void rotatePiece() {
    List<int> newPosition = [];
    switch (type) {
      case Teromino.L:
        switch (rotateState) {
          case 0:
            newPosition = [
              positions[1] - rowlenght,
              positions[1],
              positions[1] + rowlenght,
              positions[1] + rowlenght + 1
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              positions[1] - 1,
              positions[1],
              positions[1] + 1,
              positions[1] + rowlenght - 1
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              positions[1] + rowlenght,
              positions[1],
              positions[1] - rowlenght,
              positions[1] - rowlenght - 1
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              positions[1] - rowlenght + 1,
              positions[1],
              positions[1] + 1,
              positions[1] - 1
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
      case Teromino.J:
        switch (rotateState) {
          case 0:
            newPosition = [
              positions[1] - rowlenght - 1,
              positions[1],
              positions[1] + rowlenght,
              positions[1] + rowlenght - 1
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              positions[1] - rowlenght - 1,
              positions[1],
              positions[1] - 1,
              positions[1] + 1
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              positions[1] + rowlenght,
              positions[1],
              positions[1] - rowlenght,
              positions[1] - rowlenght - 1
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              positions[1] + 1,
              positions[1],
              positions[1] - 1,
              positions[1] + rowlenght + 1
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
        case Teromino.I:
        switch (rotateState) {
          case 0:
            newPosition = [
              positions[1]  - 1,
              positions[1],
              positions[1] + 1,
              positions[1] + 2
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              positions[1] - rowlenght,
              positions[1],
              positions[1] +rowlenght,
              positions[1] + 2*rowlenght
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              positions[1] + 1,
              positions[1],
              positions[1] - 1,
              positions[1] - 2
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              positions[1] + rowlenght,
              positions[1],
              positions[1] - rowlenght,
              positions[1] -2*rowlenght 
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;

        case Teromino.S:
        switch (rotateState) {
          case 0:
            newPosition = [
              positions[1] ,
              positions[1]+1,
              positions[1] + rowlenght-1,
              positions[1] + rowlenght
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              positions[0]-rowlenght,
              positions[0] ,
              positions[0] +1 ,
              positions[0] + rowlenght+1
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              positions[1] ,
              positions[1]+1,
              positions[1] + rowlenght-1,
              positions[1] + rowlenght 
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              positions[0] - rowlenght,
              positions[0],
              positions[0] + 1,
              positions[0] + rowlenght + 1
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
case Teromino.Z:
        switch (rotateState) {
          case 0:
            newPosition = [
              positions[0] + rowlenght - 2,
              positions[1],
              positions[2] + rowlenght-1,
              positions[3] + 1
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              positions[0] - rowlenght +2,
              positions[1],
              positions[2] -rowlenght+ 1,
              positions[3] -1
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
                positions[0] + rowlenght -2,
              positions[1],
              positions[2] +rowlenght- 1,
              positions[3] +1
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
                positions[0] - rowlenght +2,
              positions[1],
              positions[2] -rowlenght+ 1,
              positions[3] -1
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
        case Teromino.T:
        switch (rotateState) {
          case 0:
            newPosition = [
              positions[2] - rowlenght ,
              positions[2],
              positions[2] + 1,
              positions[2] + rowlenght 
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              positions[1] - 1,
              positions[1],
              positions[1] + 1,
              positions[1] + rowlenght
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              positions[1] - rowlenght,
              positions[1]-1,
              positions[1] ,
              positions[1] +rowlenght
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              positions[2] -rowlenght,
              positions[2]-1,
              positions[2] - 1,
              positions[2] + 1
            ];
            if (pieceValidPosition(newPosition)) {
              positions = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
      default:
    }
  }

  bool validPosition(int posi) {
    int row = (posi / rowlenght).floor();
    int col = posi % rowlenght;
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  bool pieceValidPosition(List<int> piecePosition) {
    bool firstCol = false;
    bool lastCol = false;
    for (int pos in piecePosition) {
      if (!validPosition(pos)) {
        return false;
      }
      int col = pos % rowlenght;
      if (col == 0) {
        firstCol = true;
      }
      if (col == rowlenght - 1) {
        lastCol = true;
      }
    }
    return !(firstCol && lastCol);
  }
}
