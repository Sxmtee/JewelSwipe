import 'package:flutter/material.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_data.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_dimension.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_model.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/nextitemlist/block_item_preview.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/nextitemlist/empty_item_preview.dart';
import 'package:provider/provider.dart';

class NextItemList extends StatefulWidget {
  const NextItemList({super.key});

  @override
  State<NextItemList> createState() => _NextItemListState();
}

class _NextItemListState extends State<NextItemList> {
  bool isPressed = false;
  int btnPressed = -1;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final itemSize = (size.width * 0.95) / Dimensions.gridSize;

    return Container(
      padding: const EdgeInsets.only(bottom: 35),
      height: size.height / 5,
      width: size.width,
      child: Consumer<JewelModel>(
        builder: (context, game, child) {
          final piece = game.nextPieces[0];
          return Draggable<DragData>(
            onDragStarted: () {
              // game.pick();
            },
            data: DragData(piece),
            childWhenDragging: const EmptyItemPreview(),
            dragAnchorStrategy: (draggable, context, position) {
              return Offset(50, itemSize * 4);
            },
            feedback: Transform.scale(
              scale: 1.25,
              child: BlockItemPreview(
                piece: piece,
                size: 30,
                // index: 0,
              ),
            ),
            child: Container(
              color: Colors.transparent,
              height: 100,
              width: 100,
              child: BlockItemPreview(
                piece: piece,
                size: 20,
                // index: 0,
              ),
            ),
            onDragCompleted: () {
              // game.drop();
            },
          );
          ;
        },
      ),
    );
  }
}
