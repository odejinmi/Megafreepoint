import 'package:megafreepoint/app/modules/banks_module/banks_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class banksBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => banksController());
  }
}