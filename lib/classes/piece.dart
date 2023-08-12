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
