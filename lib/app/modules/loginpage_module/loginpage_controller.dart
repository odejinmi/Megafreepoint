import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/provider/api.dart';
/// GetX Template Generator - fb.com/htngu.99
///

class loginpageController extends GetxController{

  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

  final _isloading = false.obs;
  set isloading(value) => _isloading.value = value;
  get isloading => _isloading.value;

  final _obscuretext = true.obs;
  set obscuretext(value) => _obscuretext.value = value;
  get obscuretext => _obscuretext.value;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var apicontroller = Get.put(ApiProvider());

  void passwordvisibility(){
    obscuretext = !obscuretext;
  }
  var prefs = GetStorage();
  void signUserIn() async {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty
    ) {
      var body = {
        "email": emailController.text,
        "password": passwordController.text
      };
      isloading = true;
      var response = await apicontroller.postdetail(
          "https://5stargames.5starcompany.com.ng/api/login", body);
      isloading = false;
      apicontroller.loginprogress(response, success: (serverdata) {
        //--- trigger Password Save
        TextInput.finishAutofillContext();

        prefs.write('token', serverdata['access_token'] ?? "user");
        prefs.write('name', serverdata['user']['name'] ?? "user");
        prefs.write('email', serverdata['user']['email'] ?? "user");
        prefs.write('phone', serverdata['user']['phone'] ?? "user");
        prefs.write('game', serverdata['user']['game'] ?? "user");
        prefs.write('points', serverdata['user']['points'] ?? "user");
        Get.offAllNamed("/homescreen");
      });
    }
  }

  void showErrorMessage(String message) {
    Get.dialog(AlertDialog(
      title: Text(message),
    ));
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         title: Text(message),
    //       );
    //     });
  }

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    super.dispose();
  }

  final _isEmailCorrect = false.obs;
  set isEmailCorrect (value) => _isEmailCorrect.value = value;
  get isEmailCorrect => _isEmailCorrect.value;
  final _formKey = GlobalKey<FormState>().obs;
  set formKey (value) => _formKey.value = value;
  get formKey => _formKey.value;


  final _errorMessage = "".obs;
  set errorMessage(value) => _errorMessage.value = value;
  get errorMessage => _errorMessage.value;
  void validateEmail(String val) {
    if (val.isEmpty) {
        errorMessage = "Email can not be empty";

    } else if (!EmailValidator.validate(val, true)) {

        errorMessage = "Invalid Email Address";

    } else {

        errorMessage = "";

    }
  }
}
