import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Screens/Homescreen.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/sizes.dart';

class JewelScreen extends StatefulWidget {
  const JewelScreen({super.key});

  @override
  State<JewelScreen> createState() => _JewelScreenState();
}

class _JewelScreenState extends State<JewelScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 5),
      () {
        var route = MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
        Navigator.push(context, route);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Sizes().init(context);
    return Scaffold(
      body: Container(
        height: Sizes.screenHeight,
        width: Sizes.screenWidth,
        padding: EdgeInsets.only(
          top: Sizes.sHeight * 5,
          left: Sizes.sWidth / 12,
          right: Sizes.sWidth / 12,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/mainBg.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: Sizes.sHeight * 40,
              width: Sizes.sWidth * 70,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/swipelogo.png"),
                ),
              ),
            ),
            Container(
              height: Sizes.sHeight * 15,
              width: Sizes.sWidth * 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/jewel.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
