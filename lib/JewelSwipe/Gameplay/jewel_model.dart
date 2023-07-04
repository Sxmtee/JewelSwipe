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
  bool shouldWatchAd = false;
  bool isSliding = false;

  JewelModel() {
    nextPieces = generateNextPieces();
    _valueGrid = Grid();
    _previewGrid = Grid();
  }

  //random piece generator
  List<CompoundPiece> generateNextPieces() {
    List<CompoundPiece> elements = [];
    Random random = Random();

    for (int i = 0; i < 3;) {
      final subpiece = Piece(
          PieceType.values[random.nextInt(PieceType.values.length - 1)], 1);
      final piece = CompoundPiece(
        subpiece,
        CompoundPiece.pieces[random.nextInt(CompoundPiece.pieces.length)],
      );
      if (elements.any((elem) => elem.occupations == piece.occupations)) {
        continue;
      }
      elements.add(piece);
      i++;
    }
    return elements;
  }

  void slidePiece(double itemSize, [bool isRunning = false]) {
    if (!isRunning && isSliding) return;
    var initCol = panStart.dx ~/ itemSize;
    final row = panStart.dy ~/ itemSize;
    final dx = panEnd.dx - panStart.dx;
    final dy = panEnd.dy - panStart.dy;
    final slideCount = dx ~/ itemSize;

    if (dx.abs() == 0 || dy.abs() > itemSize) return;

    if (!_valueGrid.hasPieceAt(initCol, row)) return;
    initCol = _valueGrid.getWhereSet(initCol, row);

    if (slideCount.abs() > 0 &&
        _valueGrid.canSlide(initCol, row, slideCount > 0)) {
      final col = initCol + slideCount.sign;
      _valueGrid.setValue(null, col, row, GridState.SET, true, slideCount > 0);
      panStart = Offset(panStart.dx + slideCount.sign * itemSize, panStart.dy);
      notifyListeners();
      debugPrint("slide3");
      if (slideCount.abs() > 1) {
        if (!isSliding) isSliding = true;
        slidePiece(itemSize, true);
      } else if (isSliding) {
        isSliding = false;
      }
    }
  }

  List<int> getRow(int row) => _valueGrid.getRow(row);

  String getPieceDecor(int x, int y) => _valueGrid.getPieceDecor(x, y);

  void afterWatchAd() {
    shouldWatchAd = false;
    notifyListeners();
  }

  //setting the piece and score multiplier
  Future<bool> set(CompoundPiece piece, int x, int y) async {
    nextPieces.removeAt(0);

    if (nextPieces.isEmpty) {
      shouldWatchAd = true;
      nextPieces = generateNextPieces();
    }

    // score += Dimensions.scoreForBlockSet * scoreMultiplier;
    _valueGrid.set(piece.subpiece, piece.occupations, x, y);
    notifyListeners();
    bool hasScoredLastInteraction = scoredLastInteraction;
    scoredLastInteraction = await clearIfSet(piece: piece.subpiece);

    if (hasScoredLastInteraction && scoredLastInteraction) {
      scoreMultiplier++;
    } else {
      scoreMultiplier = 1;
    }
    _previewGrid.clearGrid();
    // await _valueGrid.gravitate(notifyListeners);
    // await Future.delayed(const Duration(milliseconds: 400));
    _valueGrid.levitate();
    // notifyListeners();
    // await Future.delayed(const Duration(milliseconds: 400));
    // await _valueGrid.gravitate(notifyListeners);

    // gameIsOver = isGameOver();

    // if (!gameIsOver) {
    //   _valueGrid.levitate();
    // }
    notifyListeners();
    return scoredLastInteraction;
  }

  void activateGravity() async {
    await Future.delayed(const Duration(milliseconds: 400));
    _valueGrid.gravitate(notifyListeners);
  }

  //preview before setting block tiles
  void setPreview(CompoundPiece piece, int currX, int currY) {
    _previewGrid.clearGrid();
    Point? position = _valueGrid.calculateBestPosition(piece, currX, currY);
    if (position == null) return;
    _previewGrid.setValues(
      piece.subpiece,
      piece.occupations,
      position.x.toInt(),
      position.y.toInt(),
    );
    clearIfSet(piece: piece.subpiece, editValueGrid: false);
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

  int getPieceLength(int x, int y) => _valueGrid.getPieceLength(x, y);

  //to clear the rows when they've aligned
  Future<bool> clearIfSet(
      {required Piece piece, bool editValueGrid = true}) async {
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
        _previewGrid.setValues(
            piece,
            [
              [true, true, true, true, true, true, true, true, true]
            ],
            0,
            row,
            GridState.COMPLETED);
        if (editValueGrid) {
          if (!_setEntries.containsKey('row')) _setEntries['row'] = [];
          _setEntries['row']!.add(row);
          Future.delayed(const Duration(seconds: 3), () {
            score += Dimensions.scoreForBlockCleared * scoreMultiplier;
            for (int x = 0; x < Dimensions.gridSize; x++) {
              newValueGrid.setValue(piece, x, row, GridState.CLEAR);
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

  bool doesFit(List<List<bool>> occupations) {
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
