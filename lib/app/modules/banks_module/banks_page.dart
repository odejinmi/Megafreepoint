import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megafreepoint/app/components/custom_alert_dialog.dart';
import 'package:megafreepoint/app/components/custom_alert_dialog_widget.dart';
import 'package:megafreepoint/app/modules/banks_module/addbanks.dart';
import 'package:megafreepoint/app/modules/banks_module/banks_controller.dart';

import '../../data/provider/Globalvariable.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class banksPage extends GetView<banksController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Accounts'),
        actions: [
          IconButton(
              onPressed: () {
                Get.bottomSheet(
                    const Addbanks(),
                  isScrollControlled: true
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        child: Obx(() => controller.isloading? loader():ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemBuilder: (context, position) {
            return GestureDetector(
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 6),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10,vertical: 5),
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Row(
                  children: [
                    Image.asset("assets/Images/bankicon.jpeg",height: 50, width: 50,),
                    const SizedBox(width: 15,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text("BANK (${controller.banklist[position]["account_number"]})", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          const SizedBox(height: 10,),
                        Text(controller
                              .banklist[position]["account_name"]),
                          const SizedBox(width: 20,),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    IconButton(
                        onPressed: (){
                          controller.deleteaccount(controller.banklist[position]["id"],position);
                        },
                        icon: const Icon(Icons.delete,color: Colors.red, size: 30,)),
                  ],
                ),
              ),
              onTap: () {
              },
            );
          },
          itemCount: controller.banklist.length,)),
      ),
    );
  }
}
