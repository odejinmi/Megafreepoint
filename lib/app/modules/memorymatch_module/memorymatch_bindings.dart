import 'package:get/get.dart';

import 'memorymatch_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class memorymatchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => memorymatchController());
  }
}