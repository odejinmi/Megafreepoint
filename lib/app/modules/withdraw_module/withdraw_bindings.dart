import 'package:megafreepoint/app/modules/withdraw_module/withdraw_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class withdrawBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => withdrawController());
  }
}