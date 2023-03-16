import 'package:megafreepoint/app/modules/signup_module/signup_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class signupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => signupController());
  }
}