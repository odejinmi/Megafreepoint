import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:megafreepoint/app/provider/adsProvider.dart';
import 'package:megafreepoint/app/utils/strings.dart';

import '../../data/provider/Globalvariable.dart';
import '../../data/provider/api.dart';
/// GetX Template Generator - fb.com/htngu.99
///

class HomescreenController extends GetxController{

  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

final _isloading = false.obs;
  set isloading(value) => _isloading.value = value;
  get isloading => _isloading.value;

  var prefs = GetStorage();
  var apicontroller = Get.put(ApiProvider());
  var advert = Get.put(AdsProvider());

  void fetchbankaccounts() async {
    try {
      isloading = true;
      var response = await apicontroller.gettokendetail("https://5stargames.5starcompany.com.ng/api/user");
      isloading = false;
      apicontroller.loginprogress(response,success:(serverdata){
        prefs.write('name', serverdata['name'] ?? "user");
        prefs.write('email', serverdata['email'] ?? "user");
        prefs.write('phone', serverdata['phone'] ?? "user");
        prefs.write('game', serverdata['game'] ?? "user");
        prefs.write('points', serverdata['points'] ?? "user");
        points = serverdata['points'] ?? "";

      });

    } catch (error) {
      // if (error is FirebaseAuthException) {
      //   Get.showSnackbar(GetSnackBar(
      //     message: error.toString(),
      //   ));
      // }
    }
  }
  void signUserOut() {
    prefs.erase();
    Get.offAllNamed("/loginpage");
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // fetchbankaccounts();
  }

  Timer? _timer;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    fetchbankaccounts();
    _timer = Timer.periodic(const Duration(seconds: 31), (timer) {
      // this function will be called every second
      debugPrint('Hello');
      // advert.showreawardads((){addpoint();});
      // advert.shownativeads();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
  }
}
