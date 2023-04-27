import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../components/custom_alert_dialog.dart';
import '../../data/provider/api.dart';
import '../../utils/strings.dart';
/// GetX Template Generator - fb.com/htngu.99
///

class withdrawController extends GetxController{

  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

  final _methodselected = 1.obs;
  set methodselected(value) => _methodselected.value = value;
  get methodselected => _methodselected.value;

  final _isloading = true.obs;
  set isloading(value) => _isloading.value = value;
  get isloading => _isloading.value;

  final _bankselected = "Please bind a wallet account first".obs;
  set bankselected(value) => _bankselected.value = value;
  get bankselected => _bankselected.value;

  final _bankaccountid = "".obs;
  set bankaccountid(value) => _bankaccountid.value = value;
  get bankaccountid => _bankaccountid.value;

  final _accountlist = [].obs;
  set accountlist(value) => _accountlist.value = value;
  get accountlist => _accountlist.value;

  String _password = "0";
  String? get password => _password;

  void setPassword(String? text) {
    _password = text!;
    debugPrint("Updated password: $password");
    update();
  }

  var apicontroller = Get.put(ApiProvider());

  void fetchbankaccounts() async {
    try {
      isloading = true;
      var response = await apicontroller.gettokendetail("https://5stargames.5starcompany.com.ng/api/bank_accounts");
      isloading = false;
      apicontroller.loginprogress(response,success:(serverdata){
        accountlist = serverdata["data"];
        bankselected = serverdata["data"][0]["account_name"];
        bankaccountid = serverdata["data"][0]["id"].toString();
      });
    } catch (error) {
      // if (error is FirebaseAuthException) {
      //   Get.showSnackbar(GetSnackBar(
      //     message: error.toString(),
      //   ));
      // }
    }
  }


  void fetchbalance() async {
    try {
      isloading = true;
      var response = await apicontroller.gettokendetail("https://5stargames.5starcompany.com.ng/api/user");
      isloading = false;
      apicontroller.loginprogress(response,success:(serverdata){
        prefs.write('name', serverdata['name'] ?? "user");
        prefs.write('email', serverdata['email'] ?? "user");
        prefs.write('phone', serverdata['phone'] ?? "user");
        prefs.write('game', serverdata['game'] ?? "user");
        prefs.write('points', serverdata['points'] ?? "user");
        points = serverdata['points'] ?? "";

      });

    } catch (error) {
      // if (error is FirebaseAuthException) {
      //   Get.showSnackbar(GetSnackBar(
      //     message: error.toString(),
      //   ));
      // }
    }
  }
  var prefs = GetStorage();

  void makewithdrawal() async {
    var body = {
      "bank_account_id": bankaccountid,
      "amount": password
    };
    try {
      isloading = true;
      var response = await apicontroller.posttokendetail("https://5stargames.5starcompany.com.ng/api/withdrawals",body);
      isloading = false;
      apicontroller.loginprogress(response,success:(serverdata){

        prefs.write('points', serverdata['data']["next_bal"].toString());
        points = serverdata['data']['next_bal'].toString();
        CustomAlertDialogloader(
            title: "Withdraw Successful",
            message: serverdata["message"],
            negativeBtnText: "ok"
        );
      });

    } catch (error) {
      // if (error is FirebaseAuthException) {
      //   Get.showSnackbar(GetSnackBar(
      //     message: error.toString(),
      //   ));
      // }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // fetchbankaccounts();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    fetchbankaccounts();
    fetchbalance();
  }
}
