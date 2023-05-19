// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_model.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/gamebutton.dart';
import 'package:provider/provider.dart';

class StatusBar extends StatefulWidget {
  const StatusBar({super.key});

  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  // int? bestScore = FrostyPreferences.getHighScore();
  // int prevScore = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var sizeHeight = size.height;
    var sizeWidth = size.width;
    return Consumer<JewelModel>(
      builder: (context, game, child) {
        // if (prevScore != game.score) {
        //   Timer(const Duration(milliseconds: 1500), () {
        //     prevScore = game.score;
        //   });
        // }
        return Container(
          padding: EdgeInsets.only(top: sizeHeight / 15),
          height: sizeHeight / 8,
          width: sizeWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GameButton(
                height: sizeHeight / 16,
                width: sizeWidth / 7.2,
                onPressed: () {
                  game.reset();
                },
                assetName: "assets/images/icey.png",
              ),
              // Container(
              //   width: sizeWidth / 5.14,
              //   height: sizeHeight / 20,
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(12),
              //     color: const Color(0XFF005785),
              //   ),
              //   child: Text(
              //     "$bestScore",
              //     style: const TextStyle(
              //       fontFamily: "Poppins",
              //       color: Colors.white70,
              //     ),
              //   ),
              // ),
              // Container(
              //   width: sizeWidth / 5.14,
              //   height: sizeHeight / 20,
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(12),
              //     color: const Color(0XFF005785),
              //   ),
              //   child: Countup(
              //     begin: prevScore.toDouble(),
              //     end: (game.score).toDouble(),
              //     duration: const Duration(seconds: 1),
              //     style: const TextStyle(
              //       fontFamily: "Poppins",
              //       color: Colors.white70,
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
