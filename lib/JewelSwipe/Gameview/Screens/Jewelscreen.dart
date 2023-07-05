import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jewelswipe/JewelSwipe/Ad/app_cycle.dart';
import 'package:jewelswipe/JewelSwipe/Ad/appopen_ad.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Screens/Homescreen.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/sizes.dart';

class JewelScreen extends StatefulWidget {
  const JewelScreen({super.key});

  @override
  State<JewelScreen> createState() => _JewelScreenState();
}

class _JewelScreenState extends State<JewelScreen> {
  late AppLifecycleReactor appLifecycleReactor;

  @override
  void initState() {
    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    // WidgetsBinding.instance.addObserver(this);
    Timer(
      const Duration(seconds: 7),
      () {
        var route = MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
        Navigator.push(context, route);
      },
    );
    super.initState();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       break;
  //     case AppLifecycleState.inactive:
  //     case AppLifecycleState.detached:
  //     case AppLifecycleState.paused:
  //     case AppLifecycleState.hidden:
  //       pauseMusic();
  //       break;
  //   }
  // }

  // @override
  // void didChangeDependencies() {
  //   precacheImage(myImage, context);
  //   super.didChangeDependencies();
  // }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

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
            Stack(
              children: [
                Container(
                  height: Sizes.sHeight * 15,
                  width: Sizes.sWidth * 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/jewel.png"),
                    ),
                  ),
                ),
                Positioned(
                  left: Sizes.sWidth * 18,
                  bottom: Sizes.sHeight * 3,
                  child: Container(
                    height: Sizes.sHeight * 15,
                    width: Sizes.sWidth * 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/LIGHT.png"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Sizes.sHeight * 15,
            ),
            const SpinKitPouringHourGlass(
              size: 70,
              color: Colors.brown,
            )
          ],
        ),
      ),
    );
  }
}
