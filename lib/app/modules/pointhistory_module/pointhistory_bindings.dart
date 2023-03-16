import 'package:megafreepoint/app/modules/pointhistory_module/pointhistory_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class pointhistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => pointhistoryController());
  }
}