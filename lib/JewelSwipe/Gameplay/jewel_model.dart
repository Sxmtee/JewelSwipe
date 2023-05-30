import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/grid_model.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_dimension.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_piece.dart';

class JewelModel extends ChangeNotifier {
  late Grid _valueGrid;
  late Grid _previewGrid;
  late List<CompoundPiece> nextPieces;

  int score = 0;
  int scoreMultiplier = 1;
  bool gameIsOver = false;
  bool scoredLastInteraction = false;
  Map<String, List<int>> _setEntries = {};
  List<int>? get row => _setEntries['row'];
  Offset panStart = const Offset(0, 0);
  Offset panEnd = const Offset(0, 0);

  JewelModel() {
    nextPieces = generateNextPieces();
    _valueGrid = Grid();
    _previewGrid = Grid();
  }

  //random piece generator
  List<CompoundPiece> generateNextPieces() {
    List<CompoundPiece> elements = [];

    Random random = Random();
    for (int i = 0; i < 1;) {
      final subpiece =
          Piece(PieceType.values[random.nextInt(PieceType.values.length)], 1);
      final piece = CompoundPiece(
        subpiece,
        CompoundPiece.pieces[random.nextInt(CompoundPiece.pieces.length)],
      );
      if (elements.contains(piece)) continue;
      elements.add(piece);
      i++;
    }
    return elements;
  }

  slidePiece(double itemSize, CompoundPiece piece) {
    final initRow = panStart.dx ~/ itemSize;
    final col = panStart.dy ~/ itemSize;
    final dx = panEnd.dx - panStart.dx;
    final dy = panEnd.dy - panStart.dy;
    final slideCount = dx.abs() ~/ itemSize;

    if (dx.abs() == 0 || dy.abs() > itemSize) return;
    if (slideCount > 0) {
      final row = initRow + slideCount;
      _valueGrid.setValue(initRow, col, GridState.CLEAR);
      _valueGrid.set(piece, row, col);
    }
  }

  //setting the piece and score multiplier
  Future<bool> set(CompoundPiece piece, int x, int y, int index) async {
    nextPieces.removeAt(index);
    if (nextPieces.isEmpty) {
      nextPieces = generateNextPieces();
    }

    score += Dimensions.scoreForBlockSet * scoreMultiplier;
    _valueGrid.set(piece, x, y);
    notifyListeners();
    bool hasScoredLastInteraction = scoredLastInteraction;
    scoredLastInteraction = await clearIfSet();

    if (hasScoredLastInteraction && scoredLastInteraction) {
      scoreMultiplier++;
    } else {
      scoreMultiplier = 1;
    }
    _previewGrid.clearGrid();
    gameIsOver = isGameOver();
    notifyListeners();
    return scoredLastInteraction;
  }

  //preview before setting block tiles
  void setPreview(CompoundPiece piece, int currX, int currY) {
    _previewGrid.clearGrid();
    Point? position = _valueGrid.calculateBestPosition(piece, currX, currY);
    if (position == null) return;
    _previewGrid.setValues(
      piece.occupations,
      position.x.toInt(),
      position.y.toInt(),
    );

    notifyListeners();
  }

  // game over
  bool isGameOver() {
    for (final piece in nextPieces) {
      if (piece.occupations.isNotEmpty) {
        for (int y = 0; y < Dimensions.gridSize; y++) {
          for (int x = 0; x < Dimensions.gridSize; x++) {
            if (_valueGrid.doesFit(piece, x, y)) return false;
          }
        }
      }
    }
    return true;
  }

  //to clear the rows when they've aligned
  Future<bool> clearIfSet({bool editValueGrid = true}) async {
    bool wasCleared = false;
    Grid newValueGrid = Grid.copy(_valueGrid);

    bool isRowSet(int row) {
      for (int x = 0; x < Dimensions.gridSize; x++) {
        if (_valueGrid.isClear(x, row) &&
            (editValueGrid || _previewGrid.isClear(x, row))) {
          return false;
        }
      }
      return true;
    }

    for (int row = 0; row < Dimensions.gridSize; row++) {
      if (isRowSet(row)) {
        wasCleared = true;
        _previewGrid.setValues([
          [true, true, true, true, true, true, true, true, true]
        ], 0, row, GridState.COMPLETED);
        if (editValueGrid) {
          if (!_setEntries.containsKey('row')) _setEntries['row'] = [];
          _setEntries['row']!.add(row);
          Future.delayed(const Duration(seconds: 3), () {
            score += Dimensions.scoreForBlockCleared * scoreMultiplier;
            for (int x = 0; x < Dimensions.gridSize; x++) {
              newValueGrid.setValue(x, row, GridState.CLEAR);
            }
          });
        }
      }
    }

    if (_setEntries.containsKey('row')) {
      notifyListeners();
      await Future.delayed(const Duration(seconds: 3));
    }

    _valueGrid = newValueGrid;

    if (wasCleared && editValueGrid) {
      Timer(
        const Duration(seconds: 1),
        clearPreview,
      );
    }
    _setEntries = {};
    gameIsOver = isGameOver();
    return wasCleared;
  }

  void clearPreview() {
    _previewGrid.clearGrid();
    notifyListeners();
  }

  //calculating the best position to place the piece
  bool canPlaceFrom(CompoundPiece piece, int currX, int currY) {
    return _valueGrid.calculateBestPosition(piece, currX, currY) != null;
  }

  //reset all
  void reset() {
    score = 0;
    scoreMultiplier = 1;
    scoredLastInteraction = false;

    nextPieces = generateNextPieces();
    _valueGrid = Grid();
    _previewGrid = Grid();
    gameIsOver = false;
    notifyListeners();
  }

  bool doesFit(List<List<bool>> occupations, int x, int y) {
    return _valueGrid.canBePlaced(occupations);
  }

  bool isCompleted(int x, int y) {
    return _previewGrid.isCompleted(x, y);
  }

  bool isSet(int x, int y) {
    return _valueGrid.isSet(x, y);
  }

  bool isPreview(int x, int y) {
    return _previewGrid.isSet(x, y);
  }
}
