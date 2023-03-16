
import 'package:get/get.dart';

import 'loginpage_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class loginpageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => loginpageController());
  }
}