import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_dimension.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_model.dart';
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

  // bool isInRange(List<int>? blockX, List<int>? blockY, int x, int y) {
  //   if (blockX == null || blockY == null) return false;
  //   final len = blockX.length;
  //   for (int i = 0; i < len; i++) {
  //     final bx = blockX[i], by = blockY[i];
  //     if (x >= bx * Dimensions.blockSize &&
  //         x < (bx + 1) * Dimensions.blockSize) {
  //       if (y >= by * Dimensions.blockSize &&
  //           y < (by + 1) * Dimensions.blockSize) {
  //         return true;
  //       }
  //     }
  //   }
  //   return false;
  // }

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
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final itemSize = (width * 0.95) / Dimensions.gridSize;

    return Consumer<JewelModel>(
      builder: (context, game, child) => GestureDetector(
        onPanStart: (details) {
          final box = context.findRenderObject() as RenderBox;
          game.panEnd =
              game.panStart = box.globalToLocal(details.globalPosition);
        },
        onPanUpdate: (details) {
          final box = context.findRenderObject() as RenderBox;
          game.panEnd = box.globalToLocal(details.globalPosition);
          game.slidePiece(itemSize);
        },
        // onPanEnd: (details) {

        // },
        child: SizedBox(
          height: screenSize.width,
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
                  height: itemSize,
                  width: itemSize,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/shadowgrid2.png"),
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
                                ? _anim.value * width * pow(-1, x)
                                : 0),
                        left: offset +
                            x * itemSize -
                            ((game.row != null && game.row!.contains(y))
                                ? _anim.value * width * pow(-1, y)
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
