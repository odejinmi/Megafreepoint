import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megafreepoint/app/components/custom_alert_dialog.dart';
import 'package:megafreepoint/app/components/custom_alert_dialog_widget.dart';
import 'package:megafreepoint/app/modules/dayily_module/dayily_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class dayilyPage extends GetView<dayilyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rewards')),
      // appBar: AppBar(title: Row(
      //   children: [
      //     Text('Rewards'),
      //     Spacer(),
      //     GestureDetector(child: Text("Rules"), onTap: (){
      //       CustomAlertDialogWidget(
      //         widget: Column(
      //           children: [
      //             Row(
      //               children: [
      //                 Spacer(),
      //                 Text("Rules"),
      //                 Spacer(),
      //                 Icon(Icons.close)
      //               ],
      //             ),
      //             Text("1. Benefits to the Welcome Bonus Promotion"),
      //             Text("Get cashback by signing in to the app or completing tasks "
      //                 "such as: Add money and bill payments. Cashback will be "
      //                 "issued automatically to your account and can be used to "
      //                 "make payments for airtime top-up, betting, TV subscriptions, electricity, data, etc."),
      //           ],
      //         ),
      //       );
      //     },)
      //   ],
      // )),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Row(children:[
              Expanded(
                child: Container(
                  color: Colors.black12,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Text("Cashback"),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text("#70.00"),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios, size: 15, color: Colors.black26,)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Container(
                  color: Colors.black12,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Text("Voucher"),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text("#0"),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios, size: 15, color: Colors.black26,)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]),
            SizedBox(height: 10,),
            Row(
              children: [
                Text("Daily Casback"),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Text("Reminder", style: TextStyle(color: Colors.white),),
                )
              ],
            ),
            SizedBox(height: 10,),
            Text("You've earned #70 cashback"),
            SizedBox(height: 10,),
            Container(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (context, position){
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      children: [
                        Container(
                          child: Text("10", style: TextStyle(color: Colors.white),),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          padding: EdgeInsets.all(5),
                        ),
                        SizedBox(height: 5,),
                        Text("03.12"),
                        Text(DateTime.now().month.toString()),
                        Text(DateTime.now().day.toString())
                      ],
                    ),
                  );
                },
                itemCount: 30,),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.green
              ),
              alignment: Alignment.center,
              child: Text("You have signed in today", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}
