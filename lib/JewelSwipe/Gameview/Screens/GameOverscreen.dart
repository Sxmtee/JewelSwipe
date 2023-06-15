import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jewelswipe/JewelSwipe/Ad/interstitial_ad.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_preferences.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Screens/Gamescreen.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Screens/Homescreen.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/sizes.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:http/http.dart' as http;

class GameOver extends StatefulWidget {
  const GameOver({super.key});

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
    String? deviceId = await PlatformDeviceId.getDeviceId;
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
              image: AssetImage("assets/images/mainBg.jpg"),
            ),
          ),
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  var route = MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  );
                  Navigator.push(context, route);
                },
                child: const Text("Go To Home"),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  var route = MaterialPageRoute(
                    builder: (context) => const GameScreen(),
                  );
                  Navigator.push(context, route);
                },
                child: const Text("Go To Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
