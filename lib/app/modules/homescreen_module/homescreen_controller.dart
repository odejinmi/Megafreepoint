import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/provider/api.dart';
/// GetX Template Generator - fb.com/htngu.99
///

class HomescreenController extends GetxController{

  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

final _isloading = false.obs;
  set isloading(value) => _isloading.value = value;
  get isloading => _isloading.value;

  var prefs = GetStorage();
  var apicontroller = Get.put(ApiProvider());

  void fetchbankaccounts() async {
    try {
      isloading = true;
      var response = await apicontroller.gettokendetail("https://5stargames.5starcompany.com.ng/api/user");
      isloading = false;
      apicontroller.loginprogress(response,success:(serverdata){

        // Get.snackbar("Success", serverdata);
        // Get.find<SavedetailsController>().token.value = serverdata['token'];
        // prefs.write('token', serverdata['token'] ?? "user");
        // prefs.write('transaction_service', serverdata['transaction_service'] ?? "user");
        // prefs.write('ultility_service', serverdata['ultility_service'] ?? "user");
        // prefs.write('wallet', serverdata['balance'] ?? "user");
        // Get.find<SavedetailsController>().wallet.value = serverdata['balance'];
        // if (dynamic.isTrue) {
        //   Get.back(result: true);
        // } else {
        //   movin();
      });

    } catch (error) {
      // if (error is FirebaseAuthException) {
      //   Get.showSnackbar(GetSnackBar(
      //     message: error.toString(),
      //   ));
      // }
    }
  }
  void signUserOut() {
    prefs.erase();
    Get.offAllNamed("/loginpage");
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchbankaccounts();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    // fetchbankaccounts();
  }

}
