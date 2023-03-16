import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:megafreepoint/app/provider/adsProvider.dart';

import 'app/provider/networkProvider.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';
import 'app/utils/strings.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1080, 1920),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context , child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: appThemeData,
          debugShowCheckedModeBanner: false,
          initialRoute: token == "you"?'/loginpage':'/homescreen',
          getPages: AppPages.pages,
          initialBinding: BindingsBuilder(() {
            Get.lazyPut(() => NetworkProvider(), fenix: true);
            Get.lazyPut(() => AdsProvider(), fenix: true);
            // Get.lazyPut(() => ApiProvider(), fenix: true);
          }),
        );
      }
    );
  }
}

