import 'package:get/get.dart';

import '../../data/provider/api.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class pointhistoryController extends GetxController{

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;


  final _isloading = false.obs;
  set isloading(value) => _isloading.value = value;
  get isloading => _isloading.value;

  final _banklist = [].obs;
  set banklist(value) => _banklist.value = value;
  get banklist => _banklist.value;

  var apicontroller = Get.put(ApiProvider());

  void fetchbankaccounts() async {
    try {
      isloading = true;
      var response = await apicontroller.gettokendetail("https://5stargames.5starcompany.com.ng/api/points_history");
      isloading = false;
      apicontroller.loginprogress(response,success:(serverdata){
        banklist = serverdata["data"];
      });

    } catch (error) {
      // if (error is FirebaseAuthException) {
      //   Get.showSnackbar(GetSnackBar(
      //     message: error.toString(),
      //   ));
      // }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchbankaccounts();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    // fetchbankaccounts();
    // fetchbanklist();
  }

}
