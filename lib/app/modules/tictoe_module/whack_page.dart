import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megafreepoint/app/components/custom_alert_dialog.dart';
import 'package:megafreepoint/app/data/provider/Globalvariable.dart';
import 'package:megafreepoint/app/provider/adsProvider.dart';
import 'package:megafreepoint/app/provider/networkProvider.dart';

import 'tictoe_controller.dart';

class WhackAMole extends StatefulWidget {
  @override
  _WhackAMoleState createState() => _WhackAMoleState();
}

class _WhackAMoleState extends State<WhackAMole> {
  List<bool> moles = [];
  int score = 0;
  int scoreBeforeAd = 2;
  Random random = new Random();

  var controller = Get.put(tictoeController());

  @override
  void initState() {
    super.initState();
    moles = List.generate(9, (index) => false);
    score = 0;
    random = Random();
    startGame();
    controller.click = false;
  }

  void startGame() {
    const duration = Duration(milliseconds: 300);
    Timer.periodic(duration, (timer) {
      updateMoles();
    });
  }

  void updateMoles() {
    setState(() {
      moles = List.generate(9, (index) => random.nextBool());
    });
  }

  void whackMole(int index) {
    if (score < scoreBeforeAd) {
      if (moles[index]) {
        setState(() {
          score += 1;
          moles[index] = false;
        });
        addpoint();
      }
    } else {
      controller.click = true;
      CustomAlertDialogloader(
          title: "Points won",
          message:
              "You just won $scoreBeforeAd points for yourself. Click on Watch an Ad to continue",
          negativeBtnText: "ok",
          onNegativePressed: () {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whack-a-Mole Game'),
      ),
      body: Column(
        children: [
          Container(
            height: Get.height - 400,
            child: Center(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => whackMole(index),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: moles[index] ? Colors.brown : Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: moles[index]
                            ? Icon(Icons.android, size: 40, color: Colors.black)
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Obx(() {
              return controller.advertready && controller.click
                  ? GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.purple),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Spacer(),
                            Text(
                              "Watch ad to continue",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.movie_creation_outlined,
                              color: Colors.white,
                            ),
                            // Spacer(),
                          ],
                        ),
                      ),
                      onTap: () {
                        // Removing the first OverlayEntry from the Overlay
                        Get.find<AdsProvider>().showreawardads(() {
                          controller.click = true;
                          setState(() {
                            score = 0;
                          });
                        });
                        // controller.overlayEntry1.remove();
                      },
                    )
                  : const SizedBox.shrink();
            }),
          ),
          const SizedBox(
            height: 20,
          ),
          Platform.isAndroid ||
                  Platform.isIOS && Get.find<NetworkProvider>().isonline.isTrue
              // ? Obx(() => Get.find<AdsProvider>().banner())
              ? Get.find<AdsProvider>().banner()
              : const SizedBox.shrink(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Score: $score',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
