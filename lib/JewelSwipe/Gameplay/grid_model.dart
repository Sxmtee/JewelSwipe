import 'dart:math';

import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_dimension.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_piece.dart';

enum GridState { CLEAR, SET, COMPLETED, OCCUPIED }

class Grid {
  final List<GridState> _grid;
  Map<int, Piece> _piecesTypes;

  Grid()
      : _grid = List<GridState>.filled(
            Dimensions.gridSize * Dimensions.gridSize, GridState.CLEAR),
        _piecesTypes = {};

  Grid.copy(Grid other)
      : _grid = other._grid,
        _piecesTypes = other._piecesTypes;

  bool notInGrid(int x, int y) {
    return x < 0 ||
        x >= Dimensions.gridSize ||
        y < 0 ||
        y >= Dimensions.gridSize;
  }

  int transformX(int x, int y) {
    var xPrime = Dimensions.gridSize, pos = 0;

    for (var i = 0; i < Dimensions.gridSize; i++) {
      if (pos == x) {
        xPrime = i;
        break;
      }

      if (_grid[y * Dimensions.gridSize + i] == GridState.SET ||
          _grid[y * Dimensions.gridSize + i] == GridState.CLEAR ||
          _grid[y * Dimensions.gridSize + i] == GridState.COMPLETED) pos++;
    }
    return xPrime;
  }

  bool isSet(int x, int y, [transform = true]) {
    var xPrime = x;
    if (transform) xPrime = transformX(x, y);
    return _isState(xPrime, y, GridState.SET) ||
        _isState(xPrime, y, GridState.OCCUPIED) ||
        _isState(xPrime, y, GridState.COMPLETED);
  }

  bool isClear(int x, int y) {
    final xPrime = transformX(x, y);
    return _isState(xPrime, y, GridState.CLEAR);
  }

  bool isCompleted(int x, int y) {
    final xPrime = transformX(x, y);
    return _isState(xPrime, y, GridState.COMPLETED);
  }

  bool _isState(int x, int y, GridState state) {
    if (notInGrid(x, y)) throw {"Index out of range ${x}x ${y}y"};
    return _grid[y * Dimensions.gridSize + x] == state;
  }

  void setValue(Piece? piece, int x, int y, GridState value,
      [shouldClear = false, toRight = true]) {
    if (notInGrid(x, y)) throw {"Index out of range ${x}x ${y}y"};

    if (shouldClear) {
      final sign = toRight ? 1 : -1;
      final subpiece = _piecesTypes[y * Dimensions.gridSize + x - 1 * sign]!;
      var clearCount = subpiece.length;

      for (var i = -1 * sign; i < clearCount - 1 * sign; i++) {
        _grid[y * Dimensions.gridSize + x + i] = GridState.CLEAR;
      }

      for (var i = 1; i < clearCount; i++) {
        _grid[Dimensions.gridSize * y + x + i] = GridState.OCCUPIED;
      }
      _piecesTypes.remove(subpiece);
      _piecesTypes[Dimensions.gridSize * y + x] = subpiece;
    } else {
      assert(piece != null);
      _piecesTypes[Dimensions.gridSize * y + x] = piece!;
    }
    _grid[x + Dimensions.gridSize * y] = value;
  }

  void clearGrid() {
    _grid.fillRange(
        0, Dimensions.gridSize * Dimensions.gridSize, GridState.CLEAR);
    _piecesTypes = {};
  }

  void set(Piece piece, List<List<bool>> occupations, int x, int y,
      [GridState value = GridState.SET]) {
    final xPrime = transformX(x, y);
    Point? position = _calculateBestPosition(occupations, xPrime, y);
    if (position == null) return;

    setValues(
      piece,
      occupations,
      position.x.toInt(),
      position.y.toInt(),
      value,
    );
  }

  void setValues(Piece piece, List<List<bool>> occupations, int x, int y,
      [GridState value = GridState.SET]) {
    int currY = y;

    for (var row in occupations) {
      int currX = x;
      for (var element in row) {
        if (element) {
          setValue(piece, currX, currY, value);
        }
        currX++;
      }
      currY++;
    }
  }

  bool doesFit(CompoundPiece piece, int x, int y) {
    final xPrime = transformX(x, y);
    return _doesFit(piece.occupations, xPrime, y);
  }

  bool _doesFit(List<List<bool>> occupations, int x, int y) {
    int currY = y;
    for (var row in occupations) {
      int currX = x;
      for (var element in row) {
        if (notInGrid(currX, currY) ||
            (isSet(currX, currY, false) && element == true)) {
          return false;
        }
        currX++;
      }
      currY++;
    }
    return true;
  }

  bool canBePlaced(List<List<bool>> occupations) {
    for (var j = 0; j < Dimensions.gridSize; j++) {
      for (var i = 0; i < Dimensions.gridSize; i++) {
        if (occupations[0][0] && isSet(i, j, false)) continue;
        var x = i, y = j, hasFit = true;
        for (var row in occupations) {
          for (var val in row) {
            if (val && (notInGrid(x, y) || isSet(x, y, false))) {
              hasFit = false;
              break;
            }
            x++;
          }
          if (!hasFit) break;
          x = i;
          y++;
        }
        if (hasFit) return true;
      }
    }
    return false;
  }

  Point? calculateBestPosition(CompoundPiece piece, int x, int y) {
    final xPrime = transformX(x, y);
    return _calculateBestPosition(piece.occupations, xPrime, y);
  }

  Point? _calculateBestPosition(List<List<bool>> occupations, int x, int y) {
    int sizeY = occupations.length;
    int sizeX = occupations
        .reduce((val, elem) => val.length > elem.length ? val : elem)
        .length;

    Point center = Point(x, y);
    Point? best;
    // int offsetY, offsetX;

    // switch (hori) {
    //   case Hori.one:
    //     offsetY = 0;
    //     break;
    //   case Hori.two:
    //     offsetY = 2;
    //     break;
    //   case Hori.three:
    //     offsetY = 3;
    //     break;
    //   default:
    //     offsetY = 0;
    // }

    // switch (verti) {
    //   case Verti.two:
    //     offsetX = 1;
    //     break;
    //   case Verti.three:
    //     offsetX = 3;
    //     break;
    //   case Verti.four:
    //     offsetX = 4;
    //     break;
    //   default:
    //     offsetX = 0;
    // }
    // int start = -offsetX + 1, end = sizeX - offsetX;
    // if (offsetX == 0) {
    //   start = -1;
    //   end = 1;
    // }

    for (int offY = -2; offY < sizeY; offY++) {
      for (int offX = -2; offX < sizeX; offX++) {
        if (_doesFit(occupations, x + offX, y + offY)) {
          Point current = Point(x + offX, y + offY);

          if (best == null ||
              center.squaredDistanceTo(best) >
                  center.squaredDistanceTo(current)) {
            best = current;

            if (center.squaredDistanceTo(best) < 1.0) {
              return best;
            }
          }
        }
      }
    }
    return best;
  }

  int getGridMinY() {
    var lastFilledRow = 0;

    for (var i = Dimensions.gridSize - 1; i >= 0; i--) {
      var isClear = true;

      for (var j = 0; j < Dimensions.gridSize; j++) {
        if (_grid[j + i * Dimensions.gridSize] == GridState.SET) {
          isClear = false;
          break;
        }
      }

      if (isClear) break;
      lastFilledRow = i;
    }

    return lastFilledRow;
  }

  void levitate() {
    final rand = Random();
    var curPos = 0;
    final lastElems = _grid.skip(Dimensions.gridSize).toList();
    lastElems.addAll(List.filled(Dimensions.gridSize, GridState.CLEAR));

    _piecesTypes = _piecesTypes.map((key, value) {
      key -= Dimensions.gridSize;
      return MapEntry(key, value);
    });

    while (true) {
      final randomLen = 1 + rand.nextInt(4);

      if (curPos + randomLen > Dimensions.gridSize) continue;
      final pieceType =
          PieceType.values[rand.nextInt(PieceType.values.length - 1)];
      lastElems[curPos + Dimensions.gridSize * (Dimensions.gridSize - 1)] =
          GridState.SET;
      _piecesTypes[curPos + Dimensions.gridSize * (Dimensions.gridSize - 1)] =
          Piece(pieceType, randomLen);

      if (randomLen > 1) {
        for (var i = curPos + 1; i < curPos + randomLen - 1; i++) {
          lastElems[i + Dimensions.gridSize * (Dimensions.gridSize - 1)] =
              GridState.OCCUPIED;
        }
      }
      curPos += randomLen;

      if (curPos >= Dimensions.gridSize) break;

      while (true) {
        final spacing = rand.nextInt(4);

        if (curPos + spacing > Dimensions.gridSize) continue;
        curPos += spacing;
        break;
      }

      if (curPos >= Dimensions.gridSize) break;
    }
    _grid.clear();
    _grid.addAll(lastElems);
  }

  void gravitate() {
    for (var i = _grid.length - Dimensions.gridSize; i >= 0; i--) {
      if (_grid[i] != GridState.SET) continue;
      final piece = _piecesTypes[i]!;
      final len = piece.length;
      int? emptyPos;

      for (var j = i + Dimensions.gridSize;
          j < _grid.length;
          j += Dimensions.gridSize) {
        if (_grid[j] == GridState.CLEAR) {
          if (len > 1) {
            var isBlocked = false;

            for (var k = 1; k < len; k++) {
              assert(j + k < Dimensions.gridSize * Dimensions.gridSize);

              if (_grid[j + k] != GridState.CLEAR) {
                isBlocked = true;
                break;
              }
            }

            if (isBlocked) break;
          }
          emptyPos = j;
          continue;
        }
        break;
      }

      if (emptyPos != null) {
        _grid[i] = GridState.CLEAR;
        _grid[emptyPos] = GridState.SET;

        for (var k = 1; k < len; k++) {
          _grid[i + k] = GridState.CLEAR;
          _grid[emptyPos + k] = GridState.OCCUPIED;
        }
        _piecesTypes.remove(piece);
        _piecesTypes[emptyPos] = piece;
      }
    }
  }

  bool canSlide(int oldCol, int row, bool isRight) {
    if (isRight &&
        _grid[row * Dimensions.gridSize + oldCol + 1] == GridState.CLEAR) {
      return true;
    } else if (!isRight &&
        _grid[row * Dimensions.gridSize + oldCol - 1] == GridState.CLEAR) {
      return true;
    } else {
      return false;
    }
  }

  int getWhereSet(int col, int row) {
    var pos = row * Dimensions.gridSize + col;

    if (_grid[pos] == GridState.SET) return col;
    var checkLeft = true, checkRight = true;

    for (var i = 0; i < 4; i++) {
      if (checkLeft) {
        checkLeft = _grid[pos - i] != GridState.CLEAR;
      }

      if (checkRight) {
        checkRight = _grid[pos + i] != GridState.CLEAR;
      }

      if (checkLeft && _grid[pos - i] == GridState.SET) {
        pos -= i;
        break;
      } else if (checkRight && _grid[pos - i] == GridState.SET) {
        pos += i;
        break;
      }
    }
    return pos % Dimensions.gridSize;
  }

  bool hasPieceAt(int col, int row) =>
      _grid[row * Dimensions.gridSize + col] == GridState.SET ||
      _grid[row * Dimensions.gridSize + col] == GridState.OCCUPIED;

  List<int> getRow(int row) {
    final copyRange = _grid.sublist(
        row * Dimensions.gridSize, (row + 1) * Dimensions.gridSize);
    var count = 0;

    for (var i = 0; i < copyRange.length; i++) {
      if (copyRange[i] == GridState.SET || copyRange[i] == GridState.CLEAR) {
        count++;
      }
    }
    return List.generate(count, (index) => index);
  }

  String getPieceDecor(int x, int y) {
    var pos = 0;

    for (var i = 0; i < Dimensions.gridSize; i++) {
      if (pos == x) {
        final piece = _piecesTypes[y * Dimensions.gridSize + i];
        return piece == null ? "" : piece.pieceType.path;
      }

      if (_grid[y * Dimensions.gridSize + i] == GridState.SET ||
          _grid[y * Dimensions.gridSize + i] == GridState.CLEAR) pos++;
    }
    return "";
  }

  int getPieceLength(int x, int y) {
    var pos = 0;

    for (var i = 0; i < Dimensions.gridSize; i++) {
      if (pos == x) {
        final piece = _piecesTypes[y * Dimensions.gridSize + i];
        return piece == null ? 1 : piece.length;
      }

      if (_grid[y * Dimensions.gridSize + i] == GridState.SET ||
          _grid[y * Dimensions.gridSize + i] == GridState.CLEAR) pos++;
    }
    return 1;
  }
}
