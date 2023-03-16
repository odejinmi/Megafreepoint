import 'package:megafreepoint/app/modules/dayily_module/dayily_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class dayilyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => dayilyController());
  }
}