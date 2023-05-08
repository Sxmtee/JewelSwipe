import 'package:flutter/material.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_dimension.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_model.dart';
import 'package:provider/provider.dart';

class Block extends StatelessWidget {
  final double itemSize;
  final int currX;
  final int currY;

  const Block(
      {super.key,
      required this.itemSize,
      required this.currX,
      required this.currY});

  @override
  Widget build(BuildContext context) {
    if (currY >= Dimensions.gridSize) {
      return const SizedBox.expand();
    }
    return Consumer<JewelModel>(
      builder: (context, game, child) {
        return SizedBox(
          width: itemSize,
          height: itemSize,
          child: DecoratedBox(
            decoration: game.isCompleted(currX, currY) &&
                    game.isSet(currX, currY)
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.amber,
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  )
                : game.gameIsOver && game.isSet(currX, currY)
                    ? const BoxDecoration(
                        color: Colors.green,
                      )
                    : game.isSet(currX, currY)
                        ? const BoxDecoration(color: Colors.grey)
                        : game.isPreview(currX, currY)
                            ? BoxDecoration(
                                color: Colors.blue.shade100.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                ),
                              )
                            : const BoxDecoration(color: Colors.transparent),
          ),
        );
      },
    );
  }
}
