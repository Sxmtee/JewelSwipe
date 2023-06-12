import 'package:flutter/material.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/sizes.dart';

class EmptyItemPreview extends StatelessWidget {
  const EmptyItemPreview({super.key});

  @override
  Widget build(BuildContext context) {
    Sizes().init(context);
    return SizedBox(
      width: Sizes.sWidth * 30,
      height: Sizes.sHeight * 25,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/nextpiece.png"),
          ),
        ),
      ),
    );
  }
}
