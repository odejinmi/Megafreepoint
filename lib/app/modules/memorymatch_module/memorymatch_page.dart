import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../provider/adsProvider.dart';
import 'memorymatch_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class memorymatchPage extends GetView<memorymatchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Match Game'),
      ),
      body: Column(
        children: [
          Obx(() {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      'Attempts: ${controller.attempts}',
                      style: TextStyle(fontSize: 24),
                    ),
                  Visibility(
                    visible: false,
                    child: Text(
                      'Attempts: ${controller.prevCardIndex}',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: controller.cards.length,
                    itemBuilder: (context, index) {
                      controller.prevCardIndex;
                      return GestureDetector(
                          onTap: () => controller.flipCard(index),
                          child: Card(
                            color: controller.cardFlips[index]
                                ? Colors.white
                                : Colors
                                .blue,
                            elevation: 4,
                            margin: EdgeInsets.all(4),
                            child: Center(
                              child: Text(
                                controller.cardFlips[index]
                                    ? controller.cards[index]
                                    : '',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                    },
                  ),
                  if (controller.isGameOver)
                    ElevatedButton(
                      onPressed: controller.restartGame,
                      child: Text('Restart Game'),
                    ),
                ],
              ),
            );
          }),
          SizedBox(height: 20),
          Get.find<AdsProvider>().banner()
        ],
      ),
    );
  }
}
