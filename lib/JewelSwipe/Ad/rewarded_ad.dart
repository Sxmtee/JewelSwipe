import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/dialogs.dart';

class RewardedState {
  static RewardedAd? _rewardedAd;
  final adUnitId = "ca-app-pub-3940256099942544/5224354917";

  /// Loads a rewarded ad.
  loadAd() {
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
            },
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
          );
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _rewardedAd = null;
        },
      ),
    );
  }

  showAd(Function() onEarnedReward, BuildContext context) {
    if (_rewardedAd == null) {
      adUnavailable(context);
      return;
    }
    _rewardedAd!.show(onUserEarnedReward: (AdWithoutView, RewardItem) {
      loadAd();
      onEarnedReward();
    });
  }
}
