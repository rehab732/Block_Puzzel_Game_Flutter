import 'package:puzzle/constants/lenght.dart';
import 'package:puzzle/constants/values.dart';

import '../constants/directions.dart';

class Piece {
  Teromino type;
  Piece({required this.type});

  List<int> positions = [];
  void inizalizePiece() {
    switch (type) {
      case Teromino.L:
        positions = [4, 14, 24, 25];
        break;
      default:
    }
  }

  void movePiece(Directions direction) {
    switch (direction) {
      case Directions.down:
        for (var i = 0; i < positions.length; ++i) {
          positions[i] += rowlenght;
        }
        break;
        case Directions.left:
        for (var i = 0; i < positions.length; ++i) {
          positions[i] -= 1;
        }
        break;case Directions.right:
        for (var i = 0; i < positions.length; ++i) {
          positions[i] += 1;
        }
        break;
        default:
    }
  }
}
