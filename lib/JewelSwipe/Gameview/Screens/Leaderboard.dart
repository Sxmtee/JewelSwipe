import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jewelswipe/JewelSwipe/Ad/banner_ad.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Screens/Homescreen.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/gamebutton.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/sizes.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/leaderboard/maintab.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    Sizes().init(context);
    final myBanner = getBanner();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: Sizes.screenWidth,
          height: Sizes.screenHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/mainBg.jpg"),
            ),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: Sizes.screenHeight / 16,
                      bottom: Sizes.sHeight * 5,
                    ),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/panel.png"),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GameButton(
                          onPressed: () {
                            var route = MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            );
                            Navigator.push(context, route);
                          },
                          assetName: "assets/images/back.png",
                        ),
                        SizedBox(
                          width: Sizes.sWidth * 15,
                        ),
                        const Text(
                          "LEADERBOARD",
                          style: TextStyle(
                            color: Color(0XFFf09102),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: const MainTab(),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: myBanner.size.width.toDouble(),
                  height: myBanner.size.height.toDouble(),
                  child: AdWidget(ad: myBanner),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
