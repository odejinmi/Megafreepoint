import 'package:megafreepoint/app/modules/homescreen_module/homescreen_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class HomescreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomescreenController());
  }
}