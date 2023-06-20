import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_dimension.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_model.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/sizes.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/gamescreen/blockdrag_target.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/gamescreen/pseudogrid.dart';
import 'package:provider/provider.dart';

class BlockGrid extends StatefulWidget {
  const BlockGrid({super.key});

  @override
  State<BlockGrid> createState() => _BlockGridState();
}

class _BlockGridState extends State<BlockGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim;
  double offset = 9;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reset();
            }
          });
    _anim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    Sizes().init(context);
    final itemSize = (Sizes.screenWidth * 0.95) / Dimensions.gridSize;

    return Consumer<JewelModel>(
      builder: (context, game, child) => GestureDetector(
        onPanStart: (details) {
          // dev.log("moved", name: "slide1");
          debugPrint("slide1");
          final box = context.findRenderObject() as RenderBox;
          game.panEnd =
              game.panStart = box.globalToLocal(details.globalPosition);
        },
        onPanUpdate: (details) {
          // dev.log("moved", name: "slide2");
          debugPrint("slide2");
          final box = context.findRenderObject() as RenderBox;
          game.panEnd = box.globalToLocal(details.globalPosition);
          game.slidePiece(itemSize);
        },
        // onPanEnd: (details) {
        //   game.isSliding = false;
        // },
        child: SizedBox(
          height: Sizes.screenWidth,
          child: Stack(
            children: [
              Positioned(
                left: offset,
                top: offset,
                child: const PseudoGrid(),
              ),
              Positioned.fill(
                left: 0,
                top: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/grid.png"),
                    ),
                  ),
                ),
              ),
              ...List.generate(
                Dimensions.gridSize,
                (y) {
                  return game.getRow(y).map((x) {
                    if (game.row != null && !_controller.isAnimating) {
                      _controller.forward();
                      // game.dissolve();
                    }

                    return AnimatedBuilder(
                      animation: _anim,
                      builder: (context, child) => Positioned(
                        top: offset +
                            y * itemSize +
                            ((game.row != null && game.row!.contains(y))
                                ? _anim.value * Sizes.screenWidth * pow(-1, x)
                                : 0),
                        left: offset +
                            x * itemSize -
                            ((game.row != null && game.row!.contains(y))
                                ? _anim.value * Sizes.screenWidth * pow(-1, y)
                                : 0),
                        child: Transform.rotate(
                          angle: (game.row != null && game.row!.contains(y))
                              ? _anim.value * pi
                              : 0,
                          child: BlockDragTarget(
                            currX: x,
                            currY: y,
                            itemSize: itemSize * game.getPieceLength(x, y),
                          ),
                        ),
                      ),
                    );
                  }).toList();
                },
              ).expand((elem) => elem).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
