import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../components/custom_alert_dialog_widget.dart';
import '../../data/provider/Globalvariable.dart';
import 'banks_controller.dart';

class Addbanks extends GetView<banksController> {
  const Addbanks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.symmetric(
        horizontal: 10),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text("Add wallet Address(s)"),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close)
                )
              ],
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              child: Container(
                height: 60,
                margin: const EdgeInsets.symmetric(
                    vertical: 10),
                padding: const EdgeInsets.only(left: 10),
                color: Colors.black12,
                child: Row(
                  children: [
                    Obx(() {
                      return Text(controller.wallettype,
                        style: const TextStyle(),);
                    }),
                    const Spacer(),
                    const Icon(Icons.keyboard_arrow_down_sharp,)
                  ],
                ),
              ),
              onTap: () {
                CustomAlertDialogWidgetloader(
                    widget: SizedBox(
                      height: (40 *
                          controller.wallettypelist.length)
                          .toDouble(),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemBuilder: (context, position) {
                          return GestureDetector(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 6),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(controller
                                          .wallettypelist[position]),
                                      const Spacer(),
                                      Icon(controller
                                          .wallettypelist[position] ==
                                          controller.wallettype
                                          ? Icons.radio_button_on
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
                              controller.wallettype =
                              controller.wallettypelist[position];
                              Get.back();
                            },
                          );
                        },
                        itemCount: controller.wallettypelist
                            .length,),
                    )
                );
              },
            ),
            GestureDetector(
              child: Container(
                height: 60,
                margin: const EdgeInsets.symmetric(
                    vertical: 10),
                padding: const EdgeInsets.only(left: 10),
                color: Colors.black12,
                child: Row(
                  children: [
                    Obx(() {
                      return Text(controller.banktype,
                        style: const TextStyle(),);
                    }),
                    const Spacer(),
                    const Icon(Icons.keyboard_arrow_down_sharp,)
                  ],
                ),
              ),
              onTap: () {
                CustomAlertDialogWidgetloader(
                    widget: Obx(() {
                      return SizedBox(
                        height: (40 *
                            controller.banktypelist.length)
                            .toDouble(),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8.0),
                          itemBuilder: (context, position) {
                            return GestureDetector(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 6),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(controller
                                              .banktypelist[position]["name"]),
                                        ),
                                        const SizedBox(width: 20,),
                                        Icon(controller
                                            .banktypelist[position]["name"] ==
                                            controller.banktype
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
                                controller.banktype =
                                controller.banktypelist[position]["name"];
                                controller.banktypecode =
                                controller.banktypelist[position]["code"];
                                Get.back();
                              },
                            );
                          },
                          itemCount: controller.banktypelist
                              .length,),
                      );
                    })
                );
              },
            ),
            const SizedBox(height: 10,),
            TextField(
              onChanged: (value) {
                controller.setAccountnumber(value);
                if (value.length == 10) {
                  controller.validateaccount();
                }
              },
              onSubmitted: (value) {
                controller.setAccountnumber(value);
              },
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: HexColor("#8d8d8d"),
              ),
              controller: controller.accountnumberController.value,
              cursorColor: HexColor("#4f4f4f"),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Please enter your account number",
                fillColor: Colors.black,
                contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
              ),
            ),
            const SizedBox(height: 20,),
            Obx(() {
              return TextField(
                onChanged: (value) {
                  // controller.setPassword(value);
                },
                onSubmitted: (value) {
                  // controller.setPassword(value);
                },
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: HexColor("#8d8d8d"),
                ),
                controller: controller.accountnameController.value,
                cursorColor: HexColor("#4f4f4f"),
                decoration: InputDecoration(
                  enabled: false,
                  hintText: "Please enter your account name",
                  fillColor: Colors.black,
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                ),
              );
            }),
            const SizedBox(height: 20,),
            Center(
              child:  Obx(()=>controller.isloading? loader():GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 60),
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Text("Confirm"),
                ),
                onTap: (){
                  controller.addaccount();
                },
              ),
            )),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

}
