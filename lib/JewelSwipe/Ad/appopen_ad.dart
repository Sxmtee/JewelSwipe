import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdManager {
  String adUnitId = 'ca-app-pub-3940256099942544/3419835294';

  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

  /// Load an AppOpenAd.
  void loadAd() {
    AppOpenAd.loadWithAdManagerAdRequest(
      adUnitId: adUnitId,
      orientation: AppOpenAd.orientationPortrait,
      adManagerAdRequest: const AdManagerAdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _appOpenAd!.show();
        },
        onAdFailedToLoad: (error) {
          loadAd();
        },
      ),
    );
  }

  void showAdIfAvailable() {
    if (!isAdAvailable) {
      loadAd();
      return;
    }

    if (_isShowingAd) {
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        // loadAd();
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    _appOpenAd!.show();
  }

  /// Whether an ad is available to be shown.
  bool get isAdAvailable => _appOpenAd != null;

  void onDispose() {
    _appOpenAd?.dispose();
  }
}
