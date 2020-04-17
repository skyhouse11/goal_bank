import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:goal_bank/main_wrapper.dart';

class AdMobService {
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['goal', 'bank', 'motivation', 'target'],
    childDirected: true,
    nonPersonalizedAds: true,
  );

  Future init() async {
    await FirebaseAdMob.instance.initialize(
      appId: Platform.isIOS
          ? 'ca-app-pub-4441592323916017~1425439145'
          : 'ca-app-pub-4441592323916017~9225728494',
      analyticsEnabled: true,
      trackingId: '214054335',
    );

    _bannerAd ??= BannerAd(
      size: AdSize.banner,
      adUnitId: Platform.isIOS
          ? 'ca-app-pub-4441592323916017/2150583056'
          : 'ca-app-pub-4441592323916017/6182408979',
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.loaded) bottomPadding.value = 50.0;
      },
    );

    _interstitialAd ??= InterstitialAd(
      targetingInfo: targetingInfo,
      adUnitId: Platform.isIOS
          ? 'ca-app-pub-4441592323916017/8990505335'
          : 'ca-app-pub-4441592323916017/2261445457',
    );
  }

  Future createBannerAd() async {
    await _bannerAd?.load()?.then((bool isLoaded) async {
      if (isLoaded) await _bannerAd?.show(anchorType: AnchorType.bottom);
    });
  }

  Future disposeBannerAd() async {
    await _bannerAd?.dispose();
  }

  Future createInterstitialAd() async {
    await _interstitialAd?.load()?.then((bool isLoaded) async {
      if (isLoaded) await _interstitialAd?.show();
    });
  }

  Future disposeInterstitialAd() async {
    await _interstitialAd?.dispose();
  }
}
