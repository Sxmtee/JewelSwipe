import 'package:flutter/material.dart';

class GameButton extends StatelessWidget {
  final String assetName;
  final double height;
  final VoidCallback onPressed;
  final double width;
  const GameButton({
    super.key,
    required this.assetName,
    this.height = 50,
    this.width = 50,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(assetName),
          ),
        ),
      ),
    );
  }
}
