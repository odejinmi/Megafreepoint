import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megafreepoint/app/modules/pointhistory_module/pointhistory_controller.dart';

import '../../data/provider/Globalvariable.dart';
/// GetX Template Generator - fb.com/htngu.99
///

class pointhistoryPage extends GetView<pointhistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Point History')),
      body: Container(
        child: Obx(()=>controller.isloading? loader():ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemBuilder: (context, position) {
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
                    Image.asset("assets/Images/tactoelogo.png",height: 50, width: 50,),
                    const SizedBox(width: 15,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Point(s): ${controller.banklist[position]["points"]}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          const SizedBox(height: 10,),
                          Text("Previous point: " + controller.banklist[position]["prev_bal"]+" New point: " + controller.banklist[position]["next_bal"]),
                          const SizedBox(height: 10,),
                          Text("Date: ${controller.banklist[position]["created_at"].toString().split('T')[0]} ${controller.banklist[position]["created_at"].toString().split('T')[1].toString().split('.')[0]}"),

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

    // :[{"id":3,"user_id":2,"game":"Mega free point","points":"1","prev_bal":"0","next_bal":"1","created_at":"2023-03-13T14:45:15.000000Z","updated_at":"2023-03-13T14:45:15.000000Z"},{"id":4,"user_id":2,"game":"Mega free point","points":"1","prev_bal":"1","next_bal":"2","created_at":"2023-03-13T15:18:19.000000Z","updated_at":"2023-03-13T15:18:19.000000Z"},{"id":5,"user_id":2,"game":"Mega free point","points":"1","prev_bal":"2","next_bal":"3","created_at":"2023-03-13T17:23:35.000000Z","updated_at":"2023-03-13T17:23:35.000000Z"}