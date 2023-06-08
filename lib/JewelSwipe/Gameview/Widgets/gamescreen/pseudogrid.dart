import 'package:flutter/material.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_dimension.dart';

class PseudoGrid extends StatelessWidget {
  const PseudoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final itemSize = (width * 0.95) / Dimensions.gridSize;

    return Container(
      height: width,
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //     fit: BoxFit.fill,
      //     image: AssetImage("assets/images/water2.gif"),
      //   ),
      // ),
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
                      color: (by == 1 || bx == 1) && by != bx
                          ? Colors.blue.withOpacity(0.7)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0XFFa9e8f1),
                        width: 2,
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
                                      color: Colors.grey.shade300,
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
