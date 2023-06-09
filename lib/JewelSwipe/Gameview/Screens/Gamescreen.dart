import 'package:flutter/material.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_dimension.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/sizes.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/gamescreen/blockdrag_target.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/gamescreen/main_block_grid.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/gamescreen/next_item_list.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/gamescreen/statusbar.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    Sizes().init(context);
    final itemSize = Sizes.screenWidth * 0.9 / Dimensions.gridSize;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/mainBg.jpg"),
            ),
          ),
          height: Sizes.screenHeight,
          child: Column(
            children: [
              const StatusBar(),
              const SizedBox(height: 30),
              const BlockGrid(),
              Column(
                children: List.generate(
                  2,
                  (y) => Row(
                    children: List.generate(
                      Dimensions.gridSize,
                      (x) => Expanded(
                        child: SizedBox(
                          width: itemSize,
                          height: itemSize,
                          child: BlockDragTarget(
                            currX: x,
                            currY: Dimensions.gridSize + y,
                            itemSize: itemSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Flexible(child: NextItemList()),
            ],
          ),
        ),
      ),
    );
  }
}
