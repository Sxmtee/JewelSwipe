// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_model.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/gamebutton.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/sizes.dart';
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
    Sizes().init(context);
    return Consumer<JewelModel>(
      builder: (context, game, child) {
        // if (prevScore != game.score) {
        //   Timer(const Duration(milliseconds: 1500), () {
        //     prevScore = game.score;
        //   });
        // }
        return Container(
          padding: EdgeInsets.only(
            top: Sizes.screenHeight / 80,
            left: Sizes.screenWidth / 15,
            right: Sizes.screenWidth / 15,
          ),
          height: Sizes.sHeight * 12.5,
          width: Sizes.screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/statusboard.png"),
            ),
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Score",
                    style: GoogleFonts.allison(
                      // color: Colors.brown.shade900,
                      letterSpacing: 2,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "0",
                    style: GoogleFonts.allison(
                      // color: Colors.brown.shade900,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Best",
                      style: GoogleFonts.almendraSc(
                        // color: Colors.brown.shade900,
                        letterSpacing: 2,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "0",
                      style: GoogleFonts.allison(
                        // color: Colors.brown.shade900,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // GameButton(
              //   height: sizeHeight / 16,
              //   width: sizeWidth / 7.2,
              //   onPressed: () {
              //     game.reset();
              //   },
              //   assetName: "assets/images/icey.png",
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
