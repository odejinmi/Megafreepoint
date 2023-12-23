

import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';

import 'api.dart';

var prefs = GetStorage();

Future<void> addpoint() async {
  var body = {
    "point":"1"
  };
  var response = await apicontroller.posttokendetail(
      "https://5stargames.5starcompany.com.ng/api/points_history", body);
  apicontroller.loginprogress(response, success: (serverdata) {
    prefs.write('points', serverdata['data']['next_bal'].toString());
  });
}

var apicontroller = Get.put(ApiProvider());

Widget loader(){
  return SpinKitCircle(
    color: HexColor('#44564a'),
    size: 50.0,
  );
}
double pointvalue = 0.5;