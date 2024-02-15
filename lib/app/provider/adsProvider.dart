import 'dart:io';

import 'package:advert/advert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AdsProvider extends GetxController {
  // Future<InitializationStatus> initialization;
  // AdsProvider(this.initialization);
  // static var initFuture = MobileAds.instance.initialize();
  // static var adstate = AdsProvider(initFuture);

  final _advertPlugin = Advert();
  get banneradUnitId {
    if (kDebugMode) {
      return Platform.isAndroid
          ? ['ca-app-pub-3940256099942544/6300978111']
          : ['ca-app-pub-6117361441866120/4722833700'];
    }else{
      return Platform.isAndroid
          ? ['ca-app-pub-6117361441866120/3708316699']
          : ['ca-app-pub-6117361441866120/4722833700'];
    }
  }

  get screenUnitId {
    if (kDebugMode) {
      return Platform.isAndroid
          ? ['ca-app-pub-3940256099942544/1033173712']
          : ['ca-app-pub-6117361441866120/4722833700'];
    }else {
      return Platform.isAndroid
          ? ['ca-app-pub-6117361441866120/1078335225']
          : ['ca-app-pub-6117361441866120/2111790264'];
    }
  }

  final  _nativeadUnitId = Platform.isAndroid
      ? ['ca-app-pub-6117361441866120/1183902113']
      : ['ca-app-pub-6117361441866120/7174595397'];

  get videoUnitId {
    if (kDebugMode) {
      return Platform.isAndroid
          ? ['ca-app-pub-3940256099942544/1033173712']
          : ['ca-app-pub-6117361441866120/4722833700'];
    }else {
      return Platform.isAndroid
          ? [
        'ca-app-pub-6117361441866120/3692890274',
        'ca-app-pub-6117361441866120/3017677823',
        'ca-app-pub-6117361441866120/5013285775',
        'ca-app-pub-6117361441866120/2798185970',
        'ca-app-pub-6117361441866120/5779572537'
      ]
          : [
        'ca-app-pub-6117361441866120/7176414688',
        'ca-app-pub-6117361441866120/4550251341',
        'ca-app-pub-6117361441866120/8353194161',
        'ca-app-pub-6117361441866120/9223993527',
        'ca-app-pub-6117361441866120/3971666841'
      ];
    }
  }

    // TODO: replace this test ad unit with your own ad unit.
    final adUnitId = Platform.isAndroid
        ? ['ca-app-pub-6117361441866120/3436743553','ca-app-pub-6117361441866120/4613296063',
      'ca-app-pub-6117361441866120/4942321320','ca-app-pub-6117361441866120/5020490174',
      'ca-app-pub-6117361441866120/3108642706']
        : ['ca-app-pub-6117361441866120/9800758737','ca-app-pub-6117361441866120/7481688904',
      'ca-app-pub-6117361441866120/3542443896','ca-app-pub-6117361441866120/5653601913',
      'ca-app-pub-6117361441866120/5447865581'];

    Advertresponse showads() {
      return _advertPlugin.adsProv.showads();
    }

    void loadinterrtitialad() {
      _advertPlugin.adsProv.loadinterrtitialad();
    }

    void loadrewardedad() {
      _advertPlugin.adsProv.loadrewardedad();
    }

   void loadrewardedinterstitialad() {
      _advertPlugin.adsProv.loadrewardedinterstitialad();
    }

    Widget shownativeads() {
      return  _advertPlugin.adsProv.shownativeads();
    }

    Advertresponse showreawardads(Function reward) {
      return _advertPlugin.adsProv.showreawardads(reward);
    }

    get isvideoready => _advertPlugin.adsProv.isvideoready;

    Widget banner() {
      return _advertPlugin.adsProv.banner();
      // return Container();
    }

    var slideIndex = 1.obs;

    void counting() {
      Future.delayed(const Duration(seconds: 30), () async {
        // if (unity.placements[AdManager.bannerAdPlacementId] == true &&
        //     unitybannerplayed.isFalse) {
        //   slideIndex.value = 1;
        //   adcolonybannerplayed.value = false;
        //   unitybannerplayed.value = true;
        //   googlebannerplayed.value = false;
        //   // } else if (await adcolony.isloaded() && adcolonybannerplayed.isFalse) {
        //   //   slideIndex.value = 2;
        //   //   adcolonybannerplayed.value = true;
        //   //   unitybannerplayed.value = false;
        //   //   googlebannerplayed.value = false;
        // } else if (googlebannerplayed.isFalse) {
        //   slideIndex.value = 0;
        //   adcolonybannerplayed.value = false;
        //   unitybannerplayed.value = false;
        //   googlebannerplayed.value = true;
        // }
        if (slideIndex.value == 1) {
          slideIndex.value = 0;
        } else {
          slideIndex.value += 1;
        }
        counting();
      });
    }

    @override
    void onInit() {
      // TODO: implement onInit
      super.onInit();
      Googlemodel googlemodel = Googlemodel()
        ..banneradadUnitId = banneradUnitId
        ..nativeadUnitId = _nativeadUnitId
        ..adUnitId = adUnitId
        ..videoUnitId = videoUnitId
        ..screenUnitId = screenUnitId;
      _advertPlugin.initialize(Adsmodel(googlemodel: googlemodel));
      // counting();
    }

}
