import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megafreepoint/app/modules/tictoe_module/tictoe_controller.dart';

import '../../components/custom_alert_dialog.dart';
import '../../provider/adsProvider.dart';
import '../../provider/networkProvider.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class tictoePage extends GetView<tictoeController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Game')),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView(
          children: [
            Container(
              // width: 200,
              // color: Colors.amber,
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 10),
              child: const Text(
                  "Watch an ad and get a 5 out of 9 chance to win a sweet reward!"),
            ),
            GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (controller.click) {
                        controller.click = false;
                        controller.boxClicked(index: index);
                      }else{
                        CustomAlertDialogloader(
                            title: "Error",
                            message: "Kindly click on Watch ad button before you click on any of this",
                            negativeBtnText: "ok"
                        );
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        // color: controller.boxesData[index] == controller.player1 ? Colors.orange :
                        color: Colors.orange,
                        // controller.boxesData[index] == controller.player2 ? Colors.deepOrange : Colors.grey.withOpacity(0.2),
                      ),
                      alignment: Alignment.center,
                      // child: AnimatedDefaultTextStyle(
                      //   duration: const Duration(milliseconds: 500),
                      //   curve: Curves.easeIn,
                      //   style: const TextStyle(fontSize: 35,fontWeight: FontWeight.bold),
                      //   child: Text(""
                      //       // cubit.boxesData[index] == cubit.player1 ? cubit.player1 :
                      //       // cubit.boxesData[index] == cubit.player2 ? cubit.player2 : ""
                      //   ),
                      // ),
                      child: Obx(() =>
                      controller.boxesData[index].isEmpty
                          ? const Text("")
                          : Image.asset(controller.initialboxesData[index])),
                    ),
                  );
                }
            ),
            const SizedBox(height: 20,),
            Center(
              child: Obx(() {
                return controller.advertready && !controller.click ?GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.purple
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        // Spacer(),
                        Text("Watch ad", style: TextStyle(color: Colors.white),),
                        SizedBox(width: 10,),
                        Icon(Icons.movie_creation_outlined, color: Colors.white,),
                        // Spacer(),
                      ],
                    ),
                  ),
                  onTap: () {
                    // Removing the first OverlayEntry from the Overlay
                    Get.find<AdsProvider>().showreawardads(() {
                      controller.click = true;
                    });
                    // controller.overlayEntry1.remove();
                  },
                ): const SizedBox.shrink();
              }),
            ),
            const SizedBox(height: 20,),
            Platform.isAndroid || Platform.isIOS && Get
                .find<NetworkProvider>()
                .isonline
                .isTrue
            // ? Obx(() => Get.find<AdsProvider>().banner())
                ? Get.find<AdsProvider>().banner()
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
