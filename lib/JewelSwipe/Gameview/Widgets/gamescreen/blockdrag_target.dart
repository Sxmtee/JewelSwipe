import 'package:flutter/material.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_data.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_model.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/nextitemlist/block_piece.dart';
import 'package:provider/provider.dart';

class BlockDragTarget extends StatelessWidget {
  final int currX;
  final int currY;
  final double itemSize;
  const BlockDragTarget(
      {super.key,
      required this.currX,
      required this.currY,
      required this.itemSize});

  @override
  Widget build(BuildContext context) {
    return DragTarget<DragData>(
      onWillAccept: (data) {
        var game = context.read<JewelModel>();
        return game.canPlaceFrom(data!.piece, currX, currY - 2);
      },
      onLeave: (data) {
        context.read<JewelModel>().clearPreview();
      },
      onMove: (details) {
        var game = context.read<JewelModel>();
        game.setPreview(details.data.piece, currX, currY - 2);
      },
      onAccept: (data) async {
        var game = context.read<JewelModel>();
        game.clearPreview();
        await game.set(data.piece, currX, currY - 2, data.index);
        // if (game.gameIsOver) {
        //   game.gameOver();
        //   Future.delayed(const Duration(seconds: 2)).then(
        //     (value) {
        //       showDialog(
        //         barrierDismissible: false,
        //         context: context,
        //         builder: (context) => GameOverDialog(score: game.score),
        //       );
        //     },
        //   );
        // }
      },
      builder: (context, candidateData, rejectedData) {
        return Block(
          itemSize: itemSize,
          currX: currX,
          currY: currY,
        );
      },
    );
  }
}
