import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import '../../components/custom_alert_dialog.dart';
import '../../components/custom_alert_dialog_widget.dart';
import '../../data/provider/Globalvariable.dart';
import '../../provider/adsProvider.dart';
import '../../provider/networkProvider.dart';
import 'roll_button.dart';
import 'spinningcontroller.dart';

class Spinningwheel extends StatefulHookWidget {
  const Spinningwheel({super.key});

  // StreamController<int> selected = StreamController<int>();


  @override
  _SpinningwheelState createState() => _SpinningwheelState();
}

class _SpinningwheelState extends State<Spinningwheel> {

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


  var controller = Get.put(spinningController());
  var spined = false.obs;
  var numberplayed = 0.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<AdsProvider>().showads();
    controller.fetchspinwin();
  }

  var prefs = GetStorage();

  void handleRoll() {
    debugPrint("prefs.read('numberplayed')");
    debugPrint(gm_advt.value.toString());
    debugPrint(prefs.read('numberplayed'));
    // if (gm_advt.value < 3) {
    //   gm_advt.value += 1;
    //   handleRoll1();
    // } else {
      gm_advt.value = 0;
      if (prefs.read('numberplayed') == 5) {
        CustomAlertDialogloader(
            title: "Opps",
            message: "Kindly try again",
            negativeBtnText: 'Continue');
      } else {
        selected.add(
          roll(controller.items.length),
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
    if (spined.isTrue) {
      spined.value = false;
      if (!isAnimating.value &&
          controller.items[selectedIndex]["type"] == "empty") {
        debugPrint("not luck");
        CustomAlertDialogloader(
          title: "You are not lucky",
          message:
          "Try again",
          negativeBtnText: 'ok',
        );
      } else if (!isAnimating.value &&
          controller.items[selectedIndex]["type"] == "+1") {
        debugPrint("try again");
        // gm_advt.value -= 1;
        numberplayed.value = prefs.read('numberplayed') ?? 0;
        numberplayed.value -= 1;
        prefs.write('numberplayed', numberplayed.value);
        prefs.write('timeplayed', DateTime.now());
      } else {
        debugPrint("add point");
        controller.addpoint(controller.items[selectedIndex]["id"]);
        CustomAlertDialogloader(
          title: "Point won",
          message: "You just won a point for yourself",
          negativeBtnText: "ok",
          onNegativePressed: (){
            controller.fetchspinwin();
          }
        );
      }
    } else {
      Get.find<AdsProvider>().showreawardads(handleRoll);
    }
  }


  @override
  Widget build(BuildContext context) {
    selected = useStreamController<int>();
    selectedIndex = useStream(selected.stream, initialData: 0).data ?? 0;
    isAnimating = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spin & Win'),
      ),
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.all(25),
              child: const Text(
                "Welcome to SPIN & WIN. \n\nYou only have 5 chances every 5 Hours. For every chances there is 3 advert video then you will be able to claim reward if your spin pointer rest on a gift.",
                style: TextStyle(fontSize: 14),
              )),
          Expanded(
            child: Obx(() {
              return controller.isloading? loader():FortuneWheel(
                animateFirst: false,
                selected: selected.stream,
                indicators: const <FortuneIndicator>[
                  FortuneIndicator(
                    alignment: Alignment.topCenter,
                    // <-- changing the position of the indicator
                    child: TriangleIndicator(
                      color: Colors
                          .red, // <-- changing the color of the indicator
                    ),
                  ),
                ],
                items: [
                  for (var it in controller.items) FortuneItem(
                      child: Text("${it["name"]} (${it["qty"]})")),
                ],
                // onFling: handleRoll,
                onAnimationStart: () => isAnimating.value = true,
                onAnimationEnd: () => isAnimating.value = false,
              );
            }),
          ),
          const SizedBox(height: 10,),
          Obx(() =>
          controller.items.isEmpty  && !Get.find<AdsProvider>().isvideoready? const SizedBox.shrink() : spined.isFalse
              ? RollButtonWithPreview(
            isAnimating: isAnimating.value,
            selected: selectedIndex,
            items: controller.items,
            onPressed: isAnimating.value ? null : handleRoll1,
          )
              : ElevatedButton(
            onPressed: handleRoll1,
            child: const Text('claim reward'),
          ),
          ),
          const SizedBox(height: 30),
          Platform.isAndroid || Platform.isIOS && Get
              .find<NetworkProvider>()
              .isonline
              .isTrue
          // ? Obx(() => Get.find<AdsProvider>().banner())
              ? Get.find<AdsProvider>().banner()
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}