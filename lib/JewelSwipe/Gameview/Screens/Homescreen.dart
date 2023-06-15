import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jewelswipe/JewelSwipe/Ad/banner_ad.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Screens/Gamescreen.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/gamebutton.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/sizes.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  final Uri _uri =
      Uri.parse("https://www.youtube.com/@digitaldreamsictacademy1353");

  _launchUrl() async {
    if (await canLaunchUrl(_uri)) {
      await launchUrl(_uri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not launch $_uri');
    }
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
    _animation = Tween<Offset>(
      begin: const Offset(-0.2, 0),
      end: const Offset(0.2, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Sizes().init(context);
    final myBanner = getBanner();
    return WillPopScope(
      onWillPop: () async {
        // exitGame(context);
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/mainBg.jpg"),
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
              SizedBox(
                height: Sizes.sHeight * 10,
              ),
              SlideTransition(
                position: _animation,
                child: GameButton(
                  onPressed: () {
                    var route = MaterialPageRoute(
                      builder: (context) => const GameScreen(),
                    );
                    Navigator.push(context, route);
                  },
                  width: Sizes.sWidth * 50,
                  height: Sizes.sHeight * 11,
                  assetName: "assets/images/play.png",
                ),
              ),
              SizedBox(
                height: Sizes.sHeight * 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GameButton(
                    onPressed: _launchUrl,
                    width: Sizes.sWidth * 28,
                    height: Sizes.sHeight * 11,
                    assetName: "assets/images/youtube.png",
                  ),
                  SizedBox(
                    width: Sizes.sWidth * 8,
                  ),
                  GameButton(
                    onPressed: () {},
                    width: Sizes.sWidth * 28,
                    height: Sizes.sHeight * 11,
                    assetName: "assets/images/leaderboard.png",
                  ),
                ],
              ),
              const Spacer(),
              Container(
                alignment: Alignment.bottomCenter,
                width: myBanner.size.width.toDouble(),
                height: myBanner.size.height.toDouble(),
                child: AdWidget(ad: myBanner),
              )
            ],
          ),
        ),
      ),
    );
  }
}
