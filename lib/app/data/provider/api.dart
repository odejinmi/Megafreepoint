import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../components/custom_alert_dialog.dart';
import '../../utils/strings.dart';




class ApiProvider extends GetxController {
  // final String appBaseUrl;
  // ApiProvider({required this.appBaseUrl});

  var authurl = "".obs;
  var transactionurl = "https://transaction.mcd.5starcompany.com.ng/api/v1/".obs;
  var utilityurl = "https://utility.mcd.5starcompany.com.ng/api/v1/".obs;

  var prefs = GetStorage();

  geturls(){
    transactionurl.value = prefs.read("transaction_service")??
        "https://transaction.mcd.5starcompany.com.ng/api/v1/";
    utilityurl.value = prefs.read("ultility_service")??
        "https://utility.mcd.5starcompany.com.ng/api/v1/";

  }

  Future<http.Response> getdetail(url) async {
    geturls();
    debugPrint(url);
    var response = await http.get(Uri.parse(url),
        headers: {
          "game": appname,
          "Access-Control-Allow-Origin": "*",
          "Connection": "Keep-Alive",
          "Keep-Alive": "timeout=5, max=5000",
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.connectionHeader: "keep-alive"
        });
    debugPrint("response.body");
    debugPrint(response.body);
    return response;
    // if (response.status.hasError) {
    //   return Future.error(response.statusText!);
    // } else {
    //   return response.body['result'];
    // }
  }

  Future<http.Response> gettokendetail(url) async {
    geturls();
    debugPrint(url);
    var response = await http.get(Uri.parse(url), headers: {
      "game": appname,
      "Access-Control-Allow-Origin": "*",
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=5, max=5000",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader:
          "Bearer $token",
      HttpHeaders.connectionHeader: "keep-alive"
    });
    debugPrint("response.body");
    debugPrint(response.body);
    return response;
    // if (response.status.hasError) {
    //   return Future.error(response.statusText!);
    // } else {
    //   return response.body['result'];
    // }
  }

  Future<http.Response> deletedetail(url) async {
    geturls();
    debugPrint(url);
    var response = await http.delete(Uri.parse(url),
        headers: {
          "game": appname,
          "Access-Control-Allow-Origin": "*",
          "Connection": "Keep-Alive",
          "Keep-Alive": "timeout=5, max=5000",
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.connectionHeader: "keep-alive"
        });
    debugPrint("response.body");
    debugPrint(response.body);
    return response;
    // if (response.status.hasError) {
    //   return Future.error(response.statusText!);
    // } else {
    //   return response.body['result'];
    // }
  }

  Future<http.Response> deletetokendetail(url) async {
    geturls();
    debugPrint(url);
    var response = await http.delete(Uri.parse(url), headers: {
      "game": appname,
      "Access-Control-Allow-Origin": "*",
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=5, max=5000",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader:
          "Bearer $token",
      HttpHeaders.connectionHeader: "keep-alive"
    });
    debugPrint("response.body");
    debugPrint(response.body);
    return response;
    // if (response.status.hasError) {
    //   return Future.error(response.statusText!);
    // } else {
    //   return response.body['result'];
    // }
  }

  Future<http.Response> postdetail(url, Map body) async {
    geturls();
    debugPrint(url);
    debugPrint(body.toString());
    var response = await http.post(
        Uri.parse(url),
      body: body,
      headers: {
        "game": appname,
        "Access-Control-Allow-Origin": "*",
        "Connection": "Keep-Alive",
        "Keep-Alive": "timeout=5, max=1000",
        HttpHeaders.connectionHeader: "keep-alive"
      },
    );
    debugPrint("response.body");
    debugPrint(response.body);
    return response;
    // if (response.body == null || !response.body["success"]) {
    //   CustomAlertDialogloader(
    //       title: "Error",
    //       message: response.body == null
    //           ? "Check connection, Kindly connect to another network"
    //           : response.body["message"],
    //       // onPostivePressed: () {},
    //       // positiveBtnText: 'Continue',
    //       negativeBtnText: 'Continue');
    //   return Future.error(response.statusText!);
    // } else {
    //   return response.body;
    // }
  }

  Future<http.Response> posttokendetail(url, Map body) async {
    geturls();
    debugPrint(url);
    debugPrint(body.toString());
    var response = await http.post(
        Uri.parse(url),
      body: body,
      headers: {
        "game": appname,
        "Access-Control-Allow-Origin": "*",
        "Connection": "Keep-Alive",
        "Keep-Alive": "timeout=5, max=1000",
        HttpHeaders.authorizationHeader:
            "Bearer $token",
        HttpHeaders.connectionHeader: "keep-alive"
      },
    );
    debugPrint("response.body");
    debugPrint(response.body);
    return response;
    // if (response.body == null || !response.body["success"]) {
    //   CustomAlertDialogloader(
    //       title: "Error",
    //       message: response.body == null
    //           ? "Check connection, Kindly connect to another network"
    //           : response.body["message"],
    //       // onPostivePressed: () {},
    //       // positiveBtnText: 'Continue',
    //       negativeBtnText: 'Continue');
    //   return Future.error(response.statusText!);
    // } else {
    //   return response.body;
    // }
  }


  loginprogress(response,{String? endpoint, required Function success, Function? fail}){
    if (response.statusCode == 200) {
      var cmddetails = jsonDecode(response.body);
      // serverdata = cmddetails['data'];
      // servermessage = cmddetails['message'] ?? "user";
      if (cmddetails['success'] == 1) {
        success(cmddetails);
    //   } else if (cmddetails['success'] == 2) {
    //     if (cmddetails['pin']) {
    //       Get.to(() => Authpin());
    //     } else {
    //       Get.offAll(() => Verifynewdevice());
    //     }
    //   } else if (cmddetails['success'] == 5) {
    //     CustomAlertDialogloader(
    //         title: "Update Required",
    //         message: servermessage,
    //         negativeBtnText: 'ok',
    //         positiveBtnText: 'Update Now',
    //         onPostivePressed: () async {
    //           await launchUrl(Uri.parse(
    //               'https://play.google.com/store/apps/details?id=a5starcompany.com.megacheapdata'));
    //         });
    //   } else {
    //     if (cmddetails['message'] == "Kindly login" ||
    //         cmddetails['message'] == "The user name field is required.") {
    //       Get.offAll(() => UserLoginActivity());
    //     }
    //     CustomAlertDialogloader(
    //         title: "Error",
    //         message: cmddetails['message'],
    //         negativeBtnText: 'Continue');
    //   }
    // } else if (response.statusCode == 401 || response.statusCode == 403) {
    //   if (endpoint == "biometriclogin") {
    //     CustomAlertDialogloader(
    //         title: "Error",
    //         message: "Kindly Login with password",
    //         // onPostivePressed: () {},
    //         // positiveBtnText: 'Continue',
    //         negativeBtnText: 'Continue');
      }else {
        CustomAlertDialogloader(
            title: "Error",
            message: cmddetails['message'],
            // onPostivePressed: () {},
            // positiveBtnText: 'Continue',
            negativeBtnText: 'Continue');
      }
    } else {
      if (fail == null) {
        CustomAlertDialogloader(
            title: "Error",
            message: "Connection Error",
            // onPostivePressed: () {},
            // positiveBtnText: 'Continue',
            negativeBtnText: 'Continue');
      }else{
        fail();
      }
    }
  }


  void generalbottomsheet(String title, message, type) {
    Get.bottomSheet(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 40,
            ),
            type == "fail"
                ? Image.asset(
              "assets/images/error.png",
              height: 40,
              width: 40,
            )
                : Image.asset(
              "assets/images/success.png",
              width: 40,
              height: 40,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              message,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  // foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.blue,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        // side: BorderSide(color: Colors.red)
                      ))),
              onPressed: () {
                if (type == "fail") {
                  Get.back();
                } else {
                  // Snackbar.showMessage("Thank You!!");
                  // Get.to(()=>LandingPage());
                }
              },
              child: Container(
                height: 35,
                child: const Text(
                  "  OK  ",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        )),shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      backgroundColor: Colors.white,
      isScrollControlled: true,);
  }
}
