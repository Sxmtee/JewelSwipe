import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jewelswipe/JewelSwipe/Ad/appopen_ad.dart';

class AppLifecycleReactor {
  final AppOpenAdManager appOpenAdManager;
  var inBackground = false;

  AppLifecycleReactor({required this.appOpenAdManager}) {
    listenToAppStateChanges();
  }

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    // Try to show an app open ad if the app is being resumed and
    // we're not already showing an app open ad.
    if (appState == AppState.foreground && inBackground) {
      appOpenAdManager.showAdIfAvailable();
    }
    inBackground = appState == AppState.background;
  }

  void onDispose() {
    AppStateEventNotifier.stopListening();
    appOpenAdManager.onDispose();
  }
}
