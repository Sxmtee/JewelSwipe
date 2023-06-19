import 'package:flutter/material.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_model.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_piece.dart';
import 'package:provider/provider.dart';

class BlockItemPreview extends StatelessWidget {
  final CompoundPiece piece;
  // final int index;
  final double size;
  const BlockItemPreview({
    super.key,
    required this.piece,
    required this.size,
    // required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<JewelModel>(
      builder: (context, game, child) {
        return Stack(
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
                          decoration: piece.occupations[y][x] == true
                              // && !game.doesFit(piece.occupations)
                              //     ? const BoxDecoration(
                              //         image: DecorationImage(
                              //           fit: BoxFit.fill,
                              //           image: AssetImage(
                              //             "assets/images/Game Over Block.png",
                              //           ),
                              //         ),
                              //       )
                              //     : piece.occupations[y][x] == true
                              ? BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                      piece.subpiece.pieceType.path,
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
        );
      },
    );
  }
}
