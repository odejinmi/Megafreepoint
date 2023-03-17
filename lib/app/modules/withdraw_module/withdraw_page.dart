import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:megafreepoint/app/components/custom_alert_dialog.dart';
import 'package:megafreepoint/app/data/provider/Globalvariable.dart';
import 'package:megafreepoint/app/modules/withdraw_module/withdraw_controller.dart';

import '../../components/custom_alert_dialog_widget.dart';
import '../../utils/strings.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class withdrawPage extends GetView<withdrawController> {

  final passwordController = TextEditingController().obs;
  ScrollController? _scrollController;
  List? tope;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Withdrawal')),
      body: ListView(
        controller: _scrollController,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.black26
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Text.rich(
                            TextSpan(
                                children: [
                                  TextSpan(text: points,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                  const TextSpan(text: "  Point"),
                                ]
                            )
                        ),
                        const Text("Wallet's balance")
                      ],
                    ),
                    const Spacer(),
                    Text("NGN${double.parse(points) * pointvalue}",
                        style: const TextStyle(color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600))
                  ],
                ),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    const Text("Exchange rate:", style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Text("1 point = NGN$pointvalue", style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600))
                  ],
                ),
                const SizedBox(height: 10,),
                TextField(
                  onChanged: (value) {
                    controller.setPassword(value);
                  },
                  onSubmitted: (value) {
                    controller.setPassword(value);
                  },
                  controller: passwordController.value,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: HexColor("#4f4f4f"),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: "Type in your amount",
                      fillColor: Colors.black,
                      contentPadding: const EdgeInsets.fromLTRB(
                          20, 20, 20, 20),
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        color: HexColor("#8d8d8d"),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      focusColor: HexColor("#44564a"),
                      suffixIcon: const Text(
                        "Point", style: TextStyle(color: Colors.white),)
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          GestureDetector(
            onTap: () {
              controller.methodselected = 1;
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 10),
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.black26
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("NGN(Bank)", style: TextStyle(color: Colors
                          .white),),
                      SizedBox(height: 10,),
                      Text("Minimum Withdrawal 1000 point (NGN 500)",
                        style: TextStyle(color: Colors.white),)
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 20, width: 20,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.amber),
                        shape: BoxShape.circle,
                        color: controller.methodselected == 1
                            ? Colors.amber
                            : Colors.white
                    ),
                    child: const Icon(
                      Icons.done, color: Colors.white, size: 10,),
                  )
                ],
              ),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: controller.methodselected == 1,
              child: Column(
                children: [
                  GestureDetector(
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      padding: const EdgeInsets.only(left: 10),
                      color: Colors.black12,
                      child: Row(
                        children: [
                          Text(controller.bankselected,
                            style: const TextStyle(color: Colors.white),),
                          const Spacer(),
                          const Icon(
                            Icons.keyboard_arrow_down_sharp, color: Colors
                              .white,)
                        ],
                      ),
                    ),
                    onTap: () {
                      CustomAlertDialogWidgetloader(
                          widget: SizedBox(
                            height: (40 *
                                controller.accountlist.length)
                                .toDouble(),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  for(int position = 0; position < controller.accountlist.length; position++)
                                    GestureDetector(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(controller
                                                      .accountlist[position]["account_name"]),
                                                ),
                                                const SizedBox(width: 20,),
                                                Icon(controller
                                                    .accountlist[position]["account_name"] ==
                                                    controller.bankselected
                                                    ? Icons
                                                    .radio_button_on
                                                    : Icons
                                                    .radio_button_off,
                                                  color: Colors.green,)
                                              ],
                                            ),
                                            const SizedBox(height: 10,),
                                            const Divider(),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        controller.bankselected =
                                        controller
                                            .accountlist[position]["account_name"];
                                        controller.bankaccountid =
                                            controller.accountlist[position]["id"].toString();
                                        Get.back();
                                      },
                                    )
                                ],
                              ),
                            ),
                          )
                      );
                    },
                  ),
                  const SizedBox(height: 5,),
                  Visibility(
                    visible: controller.accountlist.isEmpty &&
                        !controller.isloading,
                    child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 15),
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)),
                        ),
                        child: const Text("To bind a wallet account",
                          style: TextStyle(color: Colors.white),),
                      ),
                      onTap: () {
                        Get.toNamed("/banks");
                      },
                    ),
                  )
                ],
              ),
            );
          }),
          const SizedBox(height: 20,),
          const Text("Tips of withdrawal:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          const SizedBox(height: 10,),
          const Text(
            "Tip 1: The minimum withdrawal amount is 1000 points",
            style: TextStyle(color: Colors.red),),
          const SizedBox(height: 10,),
          const Text("Tip 2: Withdrawals will be made within 24 hours!",
            style: TextStyle(color: Colors.red),),
          const SizedBox(height: 10,),
          const Text(
            "Tip 3: If you have any queries, please Contact our online customer service.",
            style: TextStyle(color: Colors.red),),
          const SizedBox(height: 15,),
          Center(
            child: Obx(() {
              return controller.isloading? loader():GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 60),
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Text("Confirm"),
                ),
                onTap: () {
                  if (double.parse(controller.password.toString()) < 1) {
                    CustomAlertDialogloader(
                        title: "Amount too Low",
                        message: "Kindly enter the amount you want to withdraw",
                        negativeBtnText: "ok"
                    );
                  } else if (int.parse(points) >
                      int.parse(controller.password ?? "0")) {
                    controller.makewithdrawal();
                  } else {
                    CustomAlertDialogloader(
                        title: "Error",
                        message: "The amount you want to withdraw is greater than your withdrawable point",
                        negativeBtnText: "ok"
                    );
                  }
                },
              );
            }),
          ),
          const SizedBox(height: 50,),
        ],
      ),
    );
  }
}
