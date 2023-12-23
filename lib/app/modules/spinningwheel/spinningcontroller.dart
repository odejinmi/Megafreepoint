import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:megafreepoint/app/modules/spinningwheel/roll_button.dart';

import '../../components/custom_alert_dialog.dart';
import '../../data/provider/api.dart';
import '../../provider/adsProvider.dart';

class spinningController extends GetxController{

  final _isloading = false.obs;
  set isloading(value) => _isloading.value = value;
  get isloading => _isloading.value;

  final _items = [].obs;
  set items(value) => _items.value = value;
  get items => _items.value;

  final _advertready = false.obs;
  set advertready(value) => _advertready.value = value;
  get advertready => _advertready.value;

  var _itemselected ;
  set itemselected(value) => _itemselected = value;
  get itemselected => _itemselected.value;

  var apicontroller = Get.put(ApiProvider());

  late Timer _timer;

  var selected;
  var selectedIndex;
  var isAnimating;


  // var items = [
  //   {"name":"0 point","type":"0"},
  //   {"name":"1 point","type":"1"},
  //   {"name":"opps 🥵", "type":"empty"},
  //   {"name":"2 points", "type":"2"},
  //   {"name":"0 point", "type":"0"},
  //   {"name":"3 points", "type":"3"},
  //   {"name":"+1 attempt", "type": "+1"},
  //   {"name":"4 points", "type":"4"},
  //   {"name":"Opps 🥵", "type":"empty"},
  //   {"name":"Try again", "type":"empty"}
  // ];


  var prefs = GetStorage();
  var spined = false.obs;
  var numberplayed = 0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(milliseconds: 10)).then((value) {
      // showstartalert ();
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      advertready = Get.find<AdsProvider>().isvideoready;
    });


    Get.find<AdsProvider>().showads();
    fetchspinwin();
    numberplayed.value = prefs.read('numberplayed') ?? 0;
  }
  void handleRoll() {
    debugPrint("prefs.read('numberplayed')");
    debugPrint(gm_advt.value.toString());
    debugPrint(numberplayed.value.toString());
    // if (gm_advt.value < 3) {
    //   gm_advt.value += 1;
    //   handleRoll1();
    // } else {
    gm_advt.value = 0;
    if (numberplayed.value == 5) {
      CustomAlertDialogloader(
          title: "Opps",
          message: "Kindly try again",
          negativeBtnText: 'Continue');
    } else {
      selected.add(
        roll(items.length),
      );
      spined.value = true;
      numberplayed.value = prefs.read('numberplayed') ?? 0;
      numberplayed.value += 1;
      prefs.write('numberplayed', numberplayed.value);
      prefs.write('timeplayed', DateTime.now());
    }
    // }
  }

  var gm_advt = 0.obs;

  void handleRoll1() {
      spined.value = false;
      if (!isAnimating.value &&
          itemselected["type"] == "empty") {
        debugPrint("not luck");
        CustomAlertDialogloader(
          title: "You are not lucky",
          message:
          "Try again",
          negativeBtnText: 'ok',
        );
      } else if (!isAnimating.value && itemselected["type"] == "+1") {
        debugPrint("try again");
        // gm_advt.value -= 1;
        numberplayed.value = prefs.read('numberplayed') ?? 0;
        numberplayed.value -= 1;
        prefs.write('numberplayed', numberplayed.value);
        prefs.write('timeplayed', DateTime.now());
      } else {
        debugPrint("add point");
        addpoint(itemselected["id"]);
        CustomAlertDialogloader(
            title: "Point won",
            message: "You just won a point for yourself",
            negativeBtnText: "ok",
            onNegativePressed: (){
              fetchspinwin();
            }
        );
      }
  }
  void fetchspinwin() async {
    try {
      isloading = true;
      var response = await apicontroller.gettokendetail("https://5stargames.5starcompany.com.ng/api/spinwin");
      isloading = false;
      apicontroller.loginprogress(response,success:(serverdata){
        items = serverdata["data"];
        // banklist = serverdata["data"];
      });

    } catch (error) {
      // if (error is FirebaseAuthException) {
      //   Get.showSnackbar(GetSnackBar(
      //     message: error.toString(),
      //   ));
      // }
    }
  }

  Future<void> addpoint(id) async {
    var body = {
      "id": id.toString()
    };
    var response = await apicontroller.posttokendetail(
        "https://5stargames.5starcompany.com.ng/api/spinwin-continue", body);
    apicontroller.loginprogress(response, success: (serverdata) {
      print("serverdata");
      print(serverdata);
      // prefs.write('name', serverdata['name'] ?? "user");
      // prefs.write('email', serverdata['email'] ?? "user");
      // prefs.write('phone', serverdata['phone'] ?? "user");
      // prefs.write('game', serverdata['game'] ?? "user");
      // prefs.write('points', serverdata['points'].toString());
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _timer.cancel();
  }
}