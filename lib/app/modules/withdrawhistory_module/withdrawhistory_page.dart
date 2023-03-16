import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megafreepoint/app/modules/withdrawhistory_module/withdrawhistory_controller.dart';

import '../../data/provider/Globalvariable.dart';
/// GetX Template Generator - fb.com/htngu.99
///

class withdrawhistoryPage extends GetView<withdrawhistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('withdrawhistory Page')),
      body: Container(
        child: Obx(()=>controller.isloading? loader():ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemBuilder: (context, position) {
            print(controller
                .banklist[position]);
            return GestureDetector(
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 7),
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
                          Text(controller
                              .banklist[position]["bank_account"]["account_name"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          const SizedBox(height: 10,),
                          Text("Amount withdraw: "+controller
                              .banklist[position]["amount"]),
                          const SizedBox(height: 10,),
                          Text("Withdraw status: "+controller
                              .banklist[position]["status"]),
                          const SizedBox(width: 20,),
                        ],
                      ),
                    ),
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
