import 'package:get/get.dart';

import '../../data/provider/api.dart';

class spinningController extends GetxController{

  final _isloading = false.obs;
  set isloading(value) => _isloading.value = value;
  get isloading => _isloading.value;

  final _items = [].obs;
  set items(value) => _items.value = value;
  get items => _items.value;

  var apicontroller = Get.put(ApiProvider());

  void fetchspinwin() async {
    try {
      isloading = true;
      var response = await apicontroller.gettokendetail("https://5stargames.5starcompany.com.ng/api/spinwin");
      isloading = false;
      apicontroller.loginprogress(response,success:(serverdata){
        items = serverdata["data"];
        // banklist = serverdata["data"];
      });

    } catch (error) {
      // if (error is FirebaseAuthException) {
      //   Get.showSnackbar(GetSnackBar(
      //     message: error.toString(),
      //   ));
      // }
    }
  }

  Future<void> addpoint(id) async {
    var body = {
      "id": id.toString()
    };
    var response = await apicontroller.posttokendetail(
        "https://5stargames.5starcompany.com.ng/api/spinwin-continue", body);
    apicontroller.loginprogress(response, success: (serverdata) {
      // prefs.write('name', serverdata['name'] ?? "user");
      // prefs.write('email', serverdata['email'] ?? "user");
      // prefs.write('phone', serverdata['phone'] ?? "user");
      // prefs.write('game', serverdata['game'] ?? "user");
      // prefs.write('points', serverdata['points'].toString());
    });
  }
}