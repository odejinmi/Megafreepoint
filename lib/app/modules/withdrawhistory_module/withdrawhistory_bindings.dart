import 'package:megafreepoint/app/modules/withdrawhistory_module/withdrawhistory_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class withdrawhistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => withdrawhistoryController());
  }
}