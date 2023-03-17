import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/provider/api.dart';
/// GetX Template Generator - fb.com/htngu.99
///

class signupController extends GetxController{

  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

  final _isloading = false.obs;
  set isloading(value) => _isloading.value = value;
  get isloading => _isloading.value;


  static signupController get instance => Get.find();


  String? _name;
  String? get name => _name;
  void setName(String? text) {
    _name = text;
    debugPrint("Updated name: $name");
    update();
  }

  String? _email;
  String? get email => _email;
  void setEmail(String? text) {
    _email = text;
    debugPrint("Updated email: $email");
    update();
  }

  String? _password;
  String? get password => _password;
  void setPassword(String? text) {
    _password = text;
    debugPrint("Updated password: $password");
    update();
  }

  String? _mobileNumber;
  String? get mobileNumber => _mobileNumber;
  void setMobileNumber(String? text) {
    _mobileNumber = text;
    debugPrint("Updated mobileNumber: $mobileNumber");
    update();
  }
  var apicontroller = Get.put(ApiProvider());

  var prefs = GetStorage();
  void registerUser() async {
    try {
      var body = {
        "name": name,
        "email": email,
        "phone": mobileNumber,
        "password": password
      };
      isloading = true;
      var response = await apicontroller.postdetail("https://5stargames.5starcompany.com.ng/api/register",body);
      isloading = false;
      apicontroller.loginprogress(response,success:(serverdata){
        //--- trigger Password Save
        TextInput.finishAutofillContext();
        Get.snackbar("Success", "User Registered");
        // Get.find<SavedetailsController>().token.value = serverdata['token'];
        prefs.write('token', serverdata['access_token'] ?? "user");
        prefs.write('name', serverdata['user']['name'] ?? "user");
        prefs.write('email', serverdata['user']['email'] ?? "user");
        prefs.write('phone', serverdata['user']['phone'] ?? "user");
        prefs.write('game', serverdata['user']['game'] ?? "user");
          Get.offAllNamed("/homescreen");

        });

    } catch (error) {
      // if (error is FirebaseAuthException) {
      //   Get.showSnackbar(GetSnackBar(
      //     message: error.toString(),
      //   ));
      // }
    }
  }

  var errorMessage = "".obs;
  void validateEmail(String val) {
    if (val.isEmpty) {

        errorMessage.value = "Email can not be empty";

    } else if (!EmailValidator.validate(val, true)) {

        errorMessage.value = "Invalid Email Address";

    } else {

        errorMessage.value = "";

    }
  }

}
