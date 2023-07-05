import 'dart:convert';

import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jewelswipe/JewelSwipe/Ad/interstitial_ad.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_preferences.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Screens/Gamescreen.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Screens/Homescreen.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Screens/Leaderboard.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/gamebutton.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/sizes.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_device_identifier/mobile_device_identifier.dart';

class GameOver extends StatefulWidget {
  final int score;
  final int highscore;
  const GameOver({
    super.key,
    required this.score,
    required this.highscore,
  });

  @override
  State<GameOver> createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  goBack() {
    var route = MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    );
    Navigator.push(context, route);
  }

  Future<void> post() async {
    final uri = Uri.parse("http://cbtportal.linkskool.com/api/post_score.php");
    Map<String, dynamic> postData = {};
    final deviceId = await MobileDeviceIdentifier().getDeviceId();
    postData["score"] = JewelPreferences.getHighScore();
    postData["username"] = JewelPreferences.getNickname() ?? "";
    postData["avatar"] = 0;
    postData["device_id"] = deviceId;
    postData["mode"] = 1;
    postData["game_type"] = "JewelSwipe";
    await http.post(
      uri,
      body: jsonEncode(postData),
    );
  }

  void showAd() async {
    interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        interstitialAd = null;
        pageAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        pageAd();
      },
    );
    interstitialAd?.show();
  }

  @override
  Widget build(BuildContext context) {
    Sizes().init(context);
    return WillPopScope(
      onWillPop: () async {
        goBack();
        return false;
      },
      child: Scaffold(
        body: Container(
          height: Sizes.screenHeight,
          width: Sizes.screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/mainBg.jpg"),
            ),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: Sizes.sHeight * 35,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Gameoverboard.png"),
                      ),
                    ),
                  ),
                  Positioned(
                    left: Sizes.sWidth * 25,
                    bottom: Sizes.sHeight * 3,
                    child: Container(
                      height: Sizes.sHeight * 5,
                      width: Sizes.sWidth * 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/GameOverText.png"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Sizes.sHeight * 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "SCORE:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: Sizes.sWidth * 4,
                      ),
                      Container(
                        height: Sizes.sHeight * 8,
                        width: Sizes.sWidth * 32,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              "assets/images/GameoverPanel.png",
                            ),
                          ),
                        ),
                        child: Center(
                          child: Countup(
                            begin: 0,
                            end: (widget.score).toDouble(),
                            duration: const Duration(seconds: 1),
                            style: const TextStyle(
                              color: Colors.white,
                              letterSpacing: 1,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Sizes.sWidth * 30,
                      ),
                      GameButton(
                        width: Sizes.sWidth * 25,
                        height: Sizes.sHeight * 8,
                        onPressed: () {
                          var route = MaterialPageRoute(
                            builder: (context) => const GameScreen(),
                          );
                          Navigator.pushReplacement(context, route);
                        },
                        assetName: "assets/images/play.png",
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Sizes.sWidth * 7,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "BESTSCORE:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: Sizes.sWidth * 4,
                      ),
                      Container(
                        height: Sizes.sHeight * 8,
                        width: Sizes.sWidth * 32,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              "assets/images/GameoverPanel.png",
                            ),
                          ),
                        ),
                        child: Center(
                          child: Countup(
                            begin: 0,
                            end: (widget.highscore).toDouble(),
                            duration: const Duration(seconds: 1),
                            style: const TextStyle(
                              color: Colors.white,
                              letterSpacing: 1,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Sizes.sWidth * 30,
                      ),
                      GameButton(
                        width: Sizes.sWidth * 25,
                        height: Sizes.sHeight * 8,
                        onPressed: () {
                          var route = MaterialPageRoute(
                            builder: (context) => const LeaderBoard(),
                          );
                          Navigator.push(context, route);
                        },
                        assetName: "assets/images/leaderboard.png",
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
