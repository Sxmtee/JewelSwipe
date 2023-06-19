import 'package:flutter/material.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_data.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_dimension.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_model.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Screens/Homescreen.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/gamebutton.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/sizes.dart';
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
    Sizes().init(context);
    final itemSize = (Sizes.screenWidth * 0.95) / Dimensions.gridSize;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.sWidth * 5,
      ),
      height: Sizes.screenHeight / 5,
      width: Sizes.screenWidth,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/panel.png"),
        ),
      ),
      child: Consumer<JewelModel>(
        builder: (context, game, child) {
          final piece = game.nextPieces[0];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GameButton(
                width: 60,
                onPressed: () {
                  var route = MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  );
                  Navigator.push(context, route);
                },
                assetName: "assets/images/back.png",
              ),
              Draggable<DragData>(
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
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/nextpiece.png"),
                    ),
                  ),
                  width: Sizes.sWidth * 30,
                  child: BlockItemPreview(
                    piece: piece,
                    size: 10,
                  ),
                ),
                onDragCompleted: () {
                  // game.drop();
                },
              ),
              GameButton(
                width: 60,
                onPressed: () {
                  game.reset();
                },
                assetName: "assets/images/settings.png",
              ),
            ],
          );
        },
      ),
    );
  }
}
