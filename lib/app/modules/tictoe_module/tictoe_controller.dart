import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megafreepoint/app/components/custom_alert_dialog.dart';
import 'package:megafreepoint/app/components/custom_alert_dialog_widget.dart';

import '../../data/provider/Globalvariable.dart';
import '../../provider/adsProvider.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class tictoeController extends GetxController{

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

  var _click = false.obs;
  set click(value) => _click.value = value;
  get click => _click.value;

  var _pointwon = 0.obs;
  set pointwon(value) => _pointwon.value = value;
  get pointwon => _pointwon.value;

  var _advertready = false.obs;
  set advertready(value) => _advertready.value = value;
  get advertready => _advertready.value;

  late int filledBoxesNumber;
  var boxesData = ["","","","","","","","",""].obs;
  List<String> initialboxesData = ["assets/Images/girl.jpg","assets/Images/logo.png","assets/Images/girl.jpg",
    "assets/Images/logo.png","assets/Images/logo.png","assets/Images/girl.jpg",
    "assets/Images/logo.png","assets/Images/girl.jpg",
    "assets/Images/logo.png"];

  late OverlayEntry overlayEntry1;
  late Timer _timer;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    gameInitialization();
    Future.delayed(const Duration(milliseconds: 10)).then((value) {
      // showstartalert ();
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      advertready = Get.find<AdsProvider>().isvideoready;
    });


  }


  void gameInitialization(){
    filledBoxesNumber = 0 ;  // Todo: when filled = 9 mean that all boxes have Data on It ( X or O )
    boxesData.value = ["","","","","","","","",""];
    initialboxesData.shuffle();
    // emit(GameInitializationSuccessState());
  }

  Future<void> boxClicked({required int index}) async {
    if( filledBoxesNumber <= 8 )
    {
      if( boxesData[index].isEmpty )
      {
        boxesData[index] = initialboxesData[index];
        filledBoxesNumber++;
        debugPrint("Filled Numbers is : $filledBoxesNumber , Data on index : $index become ${boxesData[index]}");
        // emit(MoveToAnotherPlayerState());
        await Future.delayed(const Duration(milliseconds: 200));
        if (boxesData[index] == "assets/Images/logo.png") {
          pointwon +=1;
          CustomAlertDialogloader(
              title: "Point won",
            message: "You just won a point for yourself",
            negativeBtnText: "ok",
            onNegativePressed: (){
                if (pointwon == 5) {
                  gameInitialization();
                }
            }
          );
          addpoint();
        }
      }
      else
      {
        // emit(BoxAlreadyHaveDataState( message : "This Box already have Data !") );
      }
    }
  }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _timer.cancel();
  }
}
