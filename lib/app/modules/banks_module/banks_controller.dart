import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/provider/api.dart';
/// GetX Template Generator - fb.com/htngu.99
///

class banksController extends GetxController{

  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

  final _wallettype = 'Banks'.obs;
  set wallettype(value) => _wallettype.value = value;
  get wallettype => _wallettype.value;

final _wallettypelist = ['Banks', "MCD Wallet"].obs;
  set wallettypelist(value) => _wallettypelist.value = value;
  get wallettypelist => _wallettypelist.value;

  final _banktype = 'Please select a bank'.obs;
  set banktype(value) => _banktype.value = value;
  get banktype => _banktype.value;

  final _banktypelist = [].obs;
  set banktypelist(value) => _banktypelist.value = value;
  get banktypelist => _banktypelist.value;

  final _banklist = [].obs;
  set banklist(value) => _banklist.value = value;
  get banklist => _banklist.value;

  final _banktypecode = "".obs;
  set banktypecode(value) => _banktypecode.value = value;
  get banktypecode => _banktypecode.value;

  final _isloading = false.obs;
  set isloading(value) => _isloading.value = value;
  get isloading => _isloading.value;

  String? _password;
  String? get password => _password;

  void setPassword(String? text) {
    _password = text;
    debugPrint("Updated password: $password");
    update();
  }

  String? _accountnumber;
  String? get accountnumber => _accountnumber;

  void setAccountnumber(String? text) {
    _accountnumber = text;
    debugPrint("Updated accountnumber: $accountnumber");
    update();
  }

  final accountnameController = TextEditingController().obs;
  final accountnumberController = TextEditingController().obs;

  var apicontroller = Get.put(ApiProvider());

  void fetchbankaccounts() async {
    try {
      // loader();
      var response = await apicontroller.gettokendetail("https://5stargames.5starcompany.com.ng/api/bank_accounts");
      // Get.back();
      apicontroller.loginprogress(response,success:(serverdata){
        banklist = serverdata["data"];
      });

    } catch (error) {
      // if (error is FirebaseAuthException) {
      //   Get.showSnackbar(GetSnackBar(
      //     message: error.toString(),
      //   ));
      // }
    }
  }
  void fetchbanklist() async {
    try {
      // loader();
      var response = await apicontroller.gettokendetail("https://5stargames.5starcompany.com.ng/api/bank_list");
      // Get.back();
      apicontroller.loginprogress(response,success:(serverdata){
        banktypelist = serverdata["data"];
        banktypelist.insert(0, {"name":'Please select a bank'});
      });

    } catch (error) {
      // if (error is FirebaseAuthException) {
      //   Get.showSnackbar(GetSnackBar(
      //     message: error.toString(),
      //   ));
      // }
    }
  }
  void validateaccount() async {
    var body = {
      "accountnumber": accountnumber,
      "code": banktypecode
    };
    try {
      isloading = true;
      var response = await apicontroller.posttokendetail("https://5stargames.5starcompany.com.ng/api/verify_bank",body);
      isloading = false;
      apicontroller.loginprogress(response,success:(serverdata){
        accountnameController.value.text = serverdata["data"];
      });

    } catch (error) {
      // if (error is FirebaseAuthException) {
      //   Get.showSnackbar(GetSnackBar(
      //     message: error.toString(),
      //   ));
      // }
    }
  }
  void addaccount() async {
    var body = {
      "account_number": accountnumber,
      "bank_code": banktypecode,
      "account_name": accountnameController.value.text,
      "bank_name": banktype,
    };
    try {
      isloading = true;
      var response = await apicontroller.posttokendetail("https://5stargames.5starcompany.com.ng/api/bank_accounts",body);
      isloading = false;
      apicontroller.loginprogress(response,success:(serverdata){
        banklist.add(serverdata["data"]);
        Get.back();
      });

    } catch (error) {
      // if (error is FirebaseAuthException) {
      //   Get.showSnackbar(GetSnackBar(
      //     message: error.toString(),
      //   ));
      // }
    }
  }
  void deleteaccount(id,position) async {
    try {
      isloading = true;
      var response = await apicontroller.deletetokendetail("https://5stargames.5starcompany.com.ng/api/bank_accounts/$id");
      isloading = false;
      apicontroller.loginprogress(response,success:(serverdata){
        banklist.removeAt(position);

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
    banktypelist.insert(0, {"name":'Please select a bank'});
    fetchbankaccounts();
    fetchbanklist();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    // fetchbankaccounts();
    // fetchbanklist();
  }
}
