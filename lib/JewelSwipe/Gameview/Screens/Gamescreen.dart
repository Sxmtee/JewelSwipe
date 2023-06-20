import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jewelswipe/JewelSwipe/Ad/banner_ad.dart';
import 'package:jewelswipe/JewelSwipe/Ad/rewarded_ad.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_dimension.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Screens/Homescreen.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/sizes.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/gamescreen/blockdrag_target.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/gamescreen/main_block_grid.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/gamescreen/next_item_list.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/gamescreen/statusbar.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  goBack() {
    var route = MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    );
    Navigator.push(context, route);
  }

  @override
  void initState() {
    RewardedState().loadAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Sizes().init(context);
    final itemSize = Sizes.screenWidth * 0.9 / Dimensions.gridSize;
    final myBanner = getBanner();
    return WillPopScope(
      onWillPop: () async {
        goBack();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/mainBg.jpg"),
              ),
            ),
            height: Sizes.screenHeight,
            child: Stack(
              children: [
                Column(
                  children: [
                    const StatusBar(),
                    SizedBox(
                      height: Sizes.sHeight * 5,
                    ),
                    const BlockGrid(),
                    Column(
                      children: List.generate(
                        2,
                        (y) => Row(
                          children: List.generate(
                            Dimensions.gridSize,
                            (x) => Expanded(
                              child: SizedBox(
                                width: itemSize,
                                height: itemSize,
                                child: BlockDragTarget(
                                  currX: x,
                                  currY: Dimensions.gridSize + y,
                                  itemSize: itemSize,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Flexible(
                      child: NextItemList(),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: myBanner.size.width.toDouble(),
                    height: myBanner.size.height.toDouble(),
                    child: AdWidget(ad: myBanner),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
