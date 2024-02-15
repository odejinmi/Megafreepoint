import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:megafreepoint/app/components/custom_alert_dialog.dart';
import 'package:megafreepoint/app/modules/homescreen_module/homescreen_controller.dart';
import 'package:megafreepoint/app/utils/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider/adsProvider.dart';
import '../../provider/networkProvider.dart';
import '../tictoe_module/brick_breaker_page.dart';
import '../tictoe_module/dot_page.dart';
import '../tictoe_module/memory_match_page.dart';
import '../tictoe_module/pong_page.dart';
import '../tictoe_module/whack_page.dart';
import 'feature_item.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class HomescreenPage extends GetView<HomescreenController> {
  // final user = FirebaseAuth.instance.currentUser!;

  ScrollController? _scrollController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#fed8c3"),
      appBar: AppBar(
        title: const Text("HomePage"),
        actions: [
          IconButton(
              onPressed: controller.signUserOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(0),
        children: [
          Container(
            color: const Color(0xFF0f65fa),
            height: 291.w,
            width: 1.sw,
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (_) => DummyPage(
                //           text: "Buka Lazada Amanah",
                //         )));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 60.w,
                    ),
                    width: 678.w,
                    height: 195.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          name,
                          maxLines: 2,
                          minFontSize: 1,
                          style: TextStyle(
                            fontSize: 50.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 614.w,
                              child: AutoSizeText(
                                email,
                                maxLines: 1,
                                minFontSize: 1,
                                style: TextStyle(
                                  fontSize: 42.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(width: 14.w),
                            Container(
                              width: 50.w,
                              height: 50.w,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF105de9)),
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                                size: 45.w,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/Images/lazada.png',
                    width: 280.w,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (_) => DummyPage(
                  //           text: "OVO",
                  //         )));
                },
                child: Container(
                  padding: EdgeInsets.only(left: 56.w),
                  width: 537.w,
                  height: 173.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                            width: 6.w, color: const Color(0xFFf7f7f7)),
                        right: BorderSide(
                            width: 3.w, color: const Color(0xFFf7f7f7)),
                      )),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/Images/ovo_with_border@2x.png',
                        width: 78.w,
                        height: 78.w,
                      ),
                      SizedBox(width: 22.w),
                      SizedBox(
                        height: 50.w,
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Lp',
                                style: TextStyle(
                                  fontSize: 32.sp,
                                  color: const Color(0xFFa9acad),
                                ),
                              ),
                            ),
                            Text(
                              '1',
                              style: TextStyle(
                                  fontSize: 42.sp,
                                  color: const Color(0xFF1c1c1c),
                                  fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: const Color(0xFFbdc1c1),
                              size: 50.w,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (_) => DummyPage(
                  //           text: "Points",
                  //         )));
                },
                child: Container(
                  padding: EdgeInsets.only(left: 56.w),
                  width: 537.w,
                  height: 173.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                            width: 6.w, color: const Color(0xFFf7f7f7)),
                        left: BorderSide(
                            width: 3.w, color: const Color(0xFFf7f7f7)),
                      )),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/Images/points_with_border@2x.png',
                        width: 78.w,
                        height: 78.w,
                      ),
                      SizedBox(width: 22.w),
                      SizedBox(
                        height: 50.w,
                        child: Row(
                          children: [
                            Text(
                              '${points} Points',
                              style: TextStyle(
                                  fontSize: 42.sp,
                                  color: const Color(0xFF1c1c1c),
                                  fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: const Color(0xFFbdc1c1),
                              size: 50.w,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            // height: 775.w,
            width: 1.sw,
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(width: 6.w, color: const Color(0xFFf7f7f7)),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FeatureItem(
                  onTap: () {
                    Get.toNamed("/tictoe");
                  },
                  text: 'Tic Tac Toe',
                  asset: 'assets/Images/tic_tac_toe.png',
                ),
                FeatureItem(
                  onTap: () {
                    Get.to(() => WhackAMole());
                  },
                  text: 'WhackAMole',
                  asset: 'assets/Images/tic_tac_toe.png',
                ),
                FeatureItem(
                  onTap: () {
                    Get.to(() => Pong());
                  },
                  text: 'Pong',
                  asset: 'assets/Images/tic_tac_toe.png',
                ),
                FeatureItem(
                  onTap: () {
                    Get.to(() => TapTheDot());
                  },
                  text: 'TapTheDot',
                  asset: 'assets/Images/tic_tac_toe.png',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            // height: 775.w,
            width: 1.sw,
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(width: 6.w, color: const Color(0xFFf7f7f7)),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FeatureItem(
                  onTap: () {
                    Get.to(() => Pong());
                  },
                  text: 'Pong',
                  asset: 'assets/Images/tic_tac_toe.png',
                ),
                FeatureItem(
                  onTap: () {
                    Get.to(() => TapTheDot());
                  },
                  text: 'TapTheDot',
                  asset: 'assets/Images/tic_tac_toe.png',
                ),
                FeatureItem(
                  onTap: () {
                    Get.to(() => BrickBreaker());
                  },
                  text: 'BrickBreaker',
                  asset: 'assets/Images/tic_tac_toe.png',
                ),
                FeatureItem(
                  onTap: () {

                    Get.toNamed("/memorymatch");
                  },
                  text: 'Memory Match',
                  asset: 'assets/Images/tic_tac_toe.png',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            // height: 775.w,
            width: 1.sw,
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(width: 6.w, color: const Color(0xFFf7f7f7)),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FeatureItem(
                  onTap: () {
                    Get.toNamed("/spinandwin");
                  },
                  text: 'Spin & Win',
                  asset: 'assets/Images/spin&win.png',
                ),
                FeatureItem(
                  onTap: () {
                    // Get.toNamed("/dayily");
                    CustomAlertDialogloader(
                        title: "Info",
                        message: "Coming soon...",
                        negativeBtnText: 'Ok');
                  },
                  text: 'Daily login',
                  asset: 'assets/Images/dailywin.webp',
                ),
                FeatureItem(
                  onTap: () {
                    Get.toNamed("/withdraw");
                  },
                  text: 'Withdraw',
                  asset: 'assets/Images/withdraw.jpg',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  var mail =
                      "https://5stargames.5starcompany.com.ng/privacy_policy.html";
                  var url = Uri.parse(mail).toString();
                  await launchUrl(Uri.parse(url));
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Card(
                  color: Colors.blue,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 150,
                    child: Text(
                      "Privacy Policy ->",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  var mail =
                      "https://5stargames.5starcompany.com.ng/terms_conditions.html";
                  var url = Uri.parse(mail).toString();
                  await launchUrl(Uri.parse(url));
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Card(
                  color: Colors.blue,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 150,
                    child: Text(
                      "Terms of Use ->",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  var mail =
                      "mailto:info@5starcompany.com.ng?subject=Support Needed on 5G Tac Toe";
                  var url = Uri.parse(mail).toString();
                  await launchUrl(Uri.parse(url));
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Card(
                  color: Colors.black,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 150,
                    child: Text(
                      "Contact Support",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Platform.isAndroid ||
                  Platform.isIOS && Get.find<NetworkProvider>().isonline.isTrue
              // ? Obx(() => Get.find<AdsProvider>().banner())
              ? Get.find<AdsProvider>().banner()
              : const SizedBox.shrink(),
          SizedBox(
            height: 10,
          ),
          Platform.isAndroid ||
                  Platform.isIOS && Get.find<NetworkProvider>().isonline.isTrue
              // ? Obx(() => Get.find<AdsProvider>().banner())
              ? Get.find<AdsProvider>().banner()
              : const SizedBox.shrink(),
        ],
      ),
      drawer: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color(0xFF0f65fa),
              padding: EdgeInsets.only(left: 60.w, top: 30, bottom: 20),
              width: 678.w,
              // height: 185.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    name,
                    maxLines: 2,
                    minFontSize: 1,
                    style: TextStyle(
                      fontSize: 50.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AutoSizeText(
                    email,
                    maxLines: 1,
                    minFontSize: 1,
                    style: TextStyle(
                      fontSize: 42.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  Get.toNamed("/tictoe");
                },
                child: const Text("Tic Tac Toe")),
            TextButton(
                onPressed: () {
                  Get.toNamed("/spinandwin");
                },
                child: const Text("Spin & Win")),
            TextButton(
                onPressed: () {
                  // Get.toNamed("/dayily");
                  CustomAlertDialogloader(
                      title: "Info",
                      message: "Coming soon...",
                      negativeBtnText: 'Ok');
                },
                child: const Text("Daily login")),
            TextButton(
                onPressed: () {
                  Get.toNamed("/withdraw");
                },
                child: const Text("Withdraw")),
            TextButton(
                onPressed: () {
                  Get.toNamed("/banks");
                },
                child: const Text("Banks")),
            TextButton(
                onPressed: () {
                  Get.toNamed("/withdrawhistory");
                },
                child: const Text("Withdraw history")),
            TextButton(
                onPressed: () {
                  Get.toNamed("/pointhistory");
                },
                child: const Text("Point history")),
            const Spacer(),
            TextButton(
                onPressed: controller.signUserOut, child: const Text("Logout")),
          ],
        ),
      ),
    );
  }
}
