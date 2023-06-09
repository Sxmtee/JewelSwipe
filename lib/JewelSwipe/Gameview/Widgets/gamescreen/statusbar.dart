import 'dart:async';

import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_model.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_preferences.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/sizes.dart';
import 'package:provider/provider.dart';

class StatusBar extends StatefulWidget {
  const StatusBar({super.key});

  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  int? bestScore = JewelPreferences.getHighScore();
  int prevScore = 0;

  @override
  Widget build(BuildContext context) {
    Sizes().init(context);
    return Consumer<JewelModel>(
      builder: (context, game, child) {
        if (prevScore != game.score) {
          Timer(const Duration(milliseconds: 1500), () {
            prevScore = game.score;
          },);
        }
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
            children: [
              Column(
                children: [
                  Text(
                    "Score",
                    style: GoogleFonts.allison(
                      letterSpacing: 2,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Countup(
                    begin: prevScore.toDouble(),
                    end: (game.score).toDouble(),
                    duration: const Duration(seconds: 1),
                    style: GoogleFonts.allison(
                      letterSpacing: 2,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    Text(
                      "Best",
                      style: GoogleFonts.almendraSc(
                        letterSpacing: 2,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$bestScore",
                      style: GoogleFonts.allison(
                        color: const Color(0XFFf09102),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
