import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class GoogleProvider extends GetxController {
  InterstitialAd? intersAd1;
  int _numInterstitialLoadAttempts = 0;
  InterstitialAd? intersAd2;
  InterstitialAd? intersAd3;
  RewardedAd? rewardedAd,rewardedAd2,rewardedAd3,rewardedAd4,rewardedAd5;

  int _numRewardedLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  var bannerReady = false.obs;
  bool _footerBannerShow = false;
  dynamic _bannerAd;

  set footBannerShow(bool value) {
    _footerBannerShow = value;
    update();
  }

  get videoready => rewardedAd != null;

  // bool get footBannerShow => !showAds ? false : _footerBannerShow;

  get bannerIsAvailable => _bannerAd != null;

  // InterstitialAd _intersAd1Create() => InterstitialAd(
  //       unitId: screenUnitId,
  //       loadTimeout: Duration(seconds: 8),
  //     )..onEvent.listen(
  //         (event) {
  //           switch (event.keys.first) {
  //             case FullScreenAdEvent.closed:
  //               intersAd1!.dispose();
  //               intersAd1 = _intersAd1Create();
  //               intersAd1!.load();
  //               break;
  //             default:
  //           }
  //         },
  //       );

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: screenUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            intersAd1 = ad;
            update();
          },
          onAdFailedToLoad: (LoadAdError error) {
            // googleinstatialfailed = true;
            _numInterstitialLoadAttempts += 1;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
                createInterstitialAd();
            }
          },
        ));
  }

  void initAds() {
    // if (!showAds) return;
    // AdsProvider adsProvider = AdsProvider.instance(context);

    // adsProvider.intersAd1 = adsProvider._intersAd1Create();
    // adsProvider.intersAd2 = adsProvider._intersAd2Create();
    // adsProvider.intersAd3 = adsProvider._intersAd3Create();
    //
    createInterstitialAd();
    _createRewardedAd();
    _createRewardedAd2();
    _createRewardedAd3();
    _createRewardedAd4();
    _createRewardedAd5();
    loadbanner();
    // adsProvider.intersAd2?.load();
    // adsProvider.intersAd3?.load();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initAds();
  }

  void showAd1() async {
    if (intersAd1 != null) {
      intersAd1?.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {},
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          intersAd1 = null;
          update();
          ad.dispose();
          createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          intersAd1 = null;
          update();
          ad.dispose();
          createInterstitialAd();
        },
      );

      intersAd1?.show();
    } else {
      createInterstitialAd();
    }
  }

  void showAd2(BuildContext context) async {
    // if (!showAds) return;
    // VpnProvider vpnProvider = Get.find<VpnProvider>();
    // if (vpnProvider.isPro) return;
    if (intersAd2 != null) {
      intersAd2?.show();
    } else {
      // intersAd2?.load();
    }
  }

  void showAd3(BuildContext context) async {
    // if (!showAds) return;
    // VpnProvider vpnProvider = Get.find<VpnProvider>();
    // if (vpnProvider.isPro) return;
    if (intersAd3 != null) {
      intersAd3?.show();
    } else {
      // intersAd3?.load();
    }
  }

  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: videoUnitId,
        // request: request,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void showRewardedAd(Function? rewarded) {
    if (rewardedAd != null) {
      showRewardedAd1(rewarded);
    } else if (rewardedAd2 != null) {
      showRewardedAd2(rewarded);
    } else if (rewardedAd3 != null) {
      showRewardedAd3(rewarded);
    } else if (rewardedAd4 != null) {
      showRewardedAd4(rewarded);
    } else {
      showRewardedAd5(rewarded);
    }
  }

  void showRewardedAd1(Function? rewarded) {
    if (rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;//08152836015
    }
    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();

      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    rewardedAd!.setImmersiveMode(true);
    rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
      if (rewarded != null) {
        rewarded();
      }
    });
    rewardedAd = null;
  }

  void _createRewardedAd2() {
    RewardedAd.load(
        adUnitId: videoUnitId2,
        // request: request,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            rewardedAd2 = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            rewardedAd2 = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd2();
            }
          },
        ));
  }

  void showRewardedAd2(Function? rewarded) {
    if (rewardedAd2 == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;//08152836015
    }
    rewardedAd2!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd2();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd2();
      },
    );

    rewardedAd2!.setImmersiveMode(true);
    rewardedAd2!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
      if (rewarded != null) {
        rewarded();
      }
    });
    rewardedAd2 = null;
  }

  void _createRewardedAd3() {
    RewardedAd.load(
        adUnitId: videoUnitId3,
        // request: request,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            rewardedAd3 = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            rewardedAd3 = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd3();
            }
          },
        ));
  }

  void showRewardedAd3(Function? rewarded) {
    if (rewardedAd3 == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;//08152836015
    }
    rewardedAd3!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd3();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd3();
      },
    );

    rewardedAd3!.setImmersiveMode(true);
    rewardedAd3!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
      if (rewarded != null) {
        rewarded();
      }
    });
    rewardedAd3 = null;
  }

  void _createRewardedAd4() {
    RewardedAd.load(
        adUnitId: videoUnitId4,
        // request: request,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            rewardedAd4 = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            rewardedAd4 = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd4();
            }
          },
        ));
  }

  void showRewardedAd4(Function? rewarded) {
    if (rewardedAd4 == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;//08152836015
    }
    rewardedAd4!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd4();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd4();
      },
    );

    rewardedAd4!.setImmersiveMode(true);
    rewardedAd4!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
      if (rewarded != null) {
        rewarded();
      }
    });
    rewardedAd4 = null;
  }

  void _createRewardedAd5() {
    RewardedAd.load(
        adUnitId: videoUnitId5,
        // request: request,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            rewardedAd5 = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            rewardedAd5 = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd5();
            }
          },
        ));
  }

  void showRewardedAd5(Function? rewarded) {
    if (rewardedAd5 == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;//08152836015
    }
    rewardedAd5!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd5();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd5();
      },
    );

    rewardedAd5!.setImmersiveMode(true);
    rewardedAd5!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
      if (rewarded != null) {
        rewarded();
      }
    });
    rewardedAd5 = null;
  }

  void loadbanner(){
    _bannerAd = BannerAd(
      adUnitId: Platform.isAndroid
      // test
      // ? 'ca-app-pub-3940256099942544/6300978111'
          ? 'ca-app-pub-1598206053668309/7104910929'
      // : 'ca-app-pub-3940256099942544/2934735716';
          : 'ca-app-pub-1598206053668309/3771336427',
      request: const AdRequest(),
      size: AdSize.largeBanner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
            bannerReady.value = true;
        },
        onAdFailedToLoad: (ad, err) {
            bannerReady.value = false;
          ad.dispose();
        },
        onAdOpened: (ad){
          loadbanner();
        },
      ),
    );
    _bannerAd.load();
  }

  Widget adWidget() {
      // return SizedBox.shrink();
      return _bannerAd == null?const SizedBox.shrink(): Container(
        alignment: Alignment.center,
        width: Get.width,
        height: _bannerAd.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd),
      );
      // return BannerAd(adUnitId: bannerId ?? banner1, adSize: adsize);
  }

  // Widget adbottomSpace() {
  //   if (!showAds) return SizedBox.shrink();
  //   return GetBuilder<AdsProvider>(
  //     builder: (value) =>
  //         value.footBannerShow ? SizedBox(height: 60) : SizedBox.shrink(),
  //   );
  // }

  void removeBanner() {
    footBannerShow = false;
    _bannerAd.dispose();
    _bannerAd = null;
    loadbanner();
  }

  // static AdsProvider instance(BuildContext context) =>
  //     Provider.of(context, listen: false);

  static String get appId => Platform.isAndroid
      // old
      // ? 'ca-app-pub-6117361441866120~5026343195'
      ? 'ca-app-pub-6117361441866120~1106255385'
      : 'ca-app-pub-1598206053668309~7710581439';

  static String get bannerUnitId => Platform.isAndroid
      // test
      // ? 'ca-app-pub-3940256099942544/6300978111'
      ? 'ca-app-pub-6117361441866120/9339968624'
      : 'ca-app-pub-6117361441866120/4727426885';

  static String get screenUnitId => Platform.isAndroid
      // test
      // ? 'ca-app-pub-3940256099942544/1033173712'
      ? 'ca-app-pub-6117361441866120/1078335225'
      : 'ca-app-pub-6117361441866120/2111790264';

  static String get screenrewardUnitId => Platform.isAndroid
      // test
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-6117361441866120/7273232580';

  static String get videoUnitId => Platform.isAndroid
      // ? 'ca-app-pub-3940256099942544/5224354917'
      ? 'ca-app-pub-6117361441866120/3692890274'
      : 'ca-app-pub-6117361441866120/7176414688';

  static String get videoUnitId2 => Platform.isAndroid
      // ? 'ca-app-pub-3940256099942544/5224354917'
      ? 'ca-app-pub-6117361441866120/3017677823'
      : 'ca-app-pub-6117361441866120/4550251341';

  static String get videoUnitId3 => Platform.isAndroid
      // ? 'ca-app-pub-3940256099942544/5224354917'
      ? 'ca-app-pub-6117361441866120/5013285775'
      : 'ca-app-pub-6117361441866120/8353194161';

  static String get videoUnitId4 => Platform.isAndroid
      // ? 'ca-app-pub-3940256099942544/5224354917'
      ? 'ca-app-pub-6117361441866120/2798185970'
      : 'ca-app-pub-6117361441866120/9223993527';

  static String get videoUnitId5 => Platform.isAndroid
      // ? 'ca-app-pub-3940256099942544/5224354917'
      ? 'ca-app-pub-6117361441866120/5779572537'
      : 'ca-app-pub-6117361441866120/3971666841';

}
