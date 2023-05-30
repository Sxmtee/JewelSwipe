import 'package:flutter/material.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_model.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_piece.dart';
import 'package:provider/provider.dart';

class BlockItemPreview extends StatelessWidget {
  final CompoundPiece piece;
  final int index;
  final double size;
  const BlockItemPreview({
    super.key,
    required this.piece,
    required this.size,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<JewelModel>(
      builder: (context, game, child) {
        return SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                  piece.occupations.length,
                  (y) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        piece.occupations[y].length,
                        (x) {
                          return Container(
                            width: size,
                            height: size,
                            decoration: piece.occupations[x][y] == true &&
                                    !game.doesFit(piece.occupations, x, y)
                                ? const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          "assets/images/Game Over Block.png"),
                                    ),
                                  )
                                : piece.occupations[y][x] == true
                                    ? const BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                            "assets/images/ice block model (2).png",
                                          ),
                                        ),
                                      )
                                    : const BoxDecoration(),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
