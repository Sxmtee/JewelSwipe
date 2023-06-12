import 'package:flutter/material.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_dimension.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/sizes.dart';

class PseudoGrid extends StatelessWidget {
  const PseudoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    Sizes().init(context);
    final itemSize = (Sizes.screenWidth * 0.95) / Dimensions.gridSize;

    return SizedBox(
      height: Sizes.screenWidth,
      child: Column(
        children: List.generate(
          Dimensions.blockCount,
          (by) {
            return Row(
              children: List.generate(
                Dimensions.blockCount,
                (bx) {
                  return DecoratedBox(
                    position: DecorationPosition.foreground,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: List.generate(
                        Dimensions.blockSize,
                        (y) {
                          return Row(
                            children: List.generate(
                              Dimensions.blockSize,
                              (x) {
                                return DecoratedBox(
                                  position: DecorationPosition.foreground,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: SizedBox(
                                    height: itemSize,
                                    width: itemSize,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
