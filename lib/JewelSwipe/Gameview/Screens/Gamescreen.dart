import 'package:flutter/material.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/gamescreen/main_block_grid.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/gamescreen/next_item_list.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var sizeHeight = size.height;
    return Scaffold(
      body: Container(
        height: sizeHeight,
        color: Colors.blue,
        child: const Column(
          children: [
            BlockGrid(),
            SizedBox(
              height: 10,
            ),
            NextItemList(),
          ],
        ),
      ),
    );
  }
}
