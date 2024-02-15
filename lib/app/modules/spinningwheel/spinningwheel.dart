import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

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

  var controller = Get.put(spinningController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    controller.selected = useStreamController<int>();
    controller.selectedIndex = useStream(controller.selected.stream, initialData: 0).data ?? 0;
    controller.isAnimating = useState(false);
    if (controller.items.length != 0) {
      controller.itemselected = controller.items[controller.selectedIndex];

    }
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
                selected: controller.selected.stream,
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
                onAnimationStart: () => controller.isAnimating.value = true,
                onAnimationEnd: () => controller.isAnimating.value = false,
              );
            }),
          ),
          const SizedBox(height: 10,),
          Obx(() =>
          controller.items.isEmpty  && !controller.advertready? const SizedBox.shrink() : controller.spined.isFalse
              ? RollButtonWithPreview(
            isAnimating: controller.isAnimating.value,
            selected: controller.selectedIndex,
            items: controller.items,
            onPressed: (){
              if (controller.isAnimating == true) {
                Get.find<AdsProvider>().showreawardads(controller.handleRoll);
              }else{
                debugPrint("ati ja kooooooo");
              }
            },
          )
              : ElevatedButton(
                onPressed: controller.handleRoll1,
                child: const Text('claim reward'),
              ),
          ),
          const SizedBox(height: 30),
          Platform.isAndroid || Platform.isIOS && Get
              .find<NetworkProvider>()
              .isonline
              .isTrue
              ? Get.find<AdsProvider>().banner()
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}