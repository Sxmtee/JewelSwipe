import 'package:flutter/material.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Screens/Gamescreen.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/gamebutton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  // final Uri _uri =
  //     Uri.parse("https://www.youtube.com/@digitaldreamsictacademy1353");

  // _launchUrl() async {
  //   if (await canLaunchUrl(_uri)) {
  //     await launchUrl(_uri, mode: LaunchMode.externalApplication);
  //   } else {
  //     throw Exception('Could not launch $_uri');
  //   }
  // }

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
    Size size = MediaQuery.of(context).size;
    var sizeHeight = size.height;
    var sizeWidth = size.width;
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
                height: sizeHeight / 2,
                width: sizeWidth / 1.2,
                margin: EdgeInsets.only(
                  top: sizeHeight / 80,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/swipelogo.png"),
                  ),
                ),
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
                  width: sizeWidth / 2,
                  height: sizeHeight / 10,
                  assetName: "assets/images/play.png",
                ),
              ),
              SizedBox(
                height: sizeHeight / 26.67,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GameButton(
                    onPressed: () {
                      // _launchUrl();
                    },
                    width: sizeWidth / 3.6,
                    height: sizeHeight / 10,
                    assetName: "assets/images/youtube.png",
                  ),
                  SizedBox(
                    width: sizeWidth / 12,
                  ),
                  GameButton(
                    onPressed: () {},
                    width: sizeWidth / 3.6,
                    height: sizeHeight / 10,
                    assetName: "assets/images/leaderboard.png",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
