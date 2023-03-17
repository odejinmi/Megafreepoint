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

        prefs.write('name', serverdata['name'] ?? "user");
        prefs.write('email', serverdata['email'] ?? "user");
        prefs.write('phone', serverdata['phone'] ?? "user");
        prefs.write('game', serverdata['game'] ?? "user");

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
