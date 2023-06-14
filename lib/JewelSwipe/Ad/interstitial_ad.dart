import 'package:google_mobile_ads/google_mobile_ads.dart';

InterstitialAd? interstitialAd;

Future<void> pageAd() async {
  await InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          interstitialAd = null;
          print('InterstitialAd failed to load: $error');
        },
      ),);
}