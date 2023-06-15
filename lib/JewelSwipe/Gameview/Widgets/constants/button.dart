import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onpressed;
  final Widget child;
  final double width;
  final double height;
  const Button(
      {super.key,
      required this.child,
      required this.onpressed,
      this.height = 60,
      this.width = 150});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/nextpiece.png"),
        ),
      ),
      child: Center(
        child: MaterialButton(
          textColor: const Color(0XFF005785),
          onPressed: onpressed,
          child: child,
        ),
      ),
    );
  }
}
