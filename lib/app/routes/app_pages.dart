import '../../app/modules/pointhistory_module/pointhistory_page.dart';
import '../../app/modules/pointhistory_module/pointhistory_bindings.dart';
import '../../app/modules/withdrawhistory_module/withdrawhistory_page.dart';
import '../../app/modules/withdrawhistory_module/withdrawhistory_bindings.dart';
import '../../app/modules/banks_module/banks_page.dart';
import '../../app/modules/banks_module/banks_bindings.dart';
import '../../app/modules/withdraw_module/withdraw_page.dart';
import '../../app/modules/withdraw_module/withdraw_bindings.dart';
import '../../app/modules/dayily_module/dayily_page.dart';
import '../../app/modules/dayily_module/dayily_bindings.dart';
import 'package:megafreepoint/app/modules/spinningwheel/spinningwheel.dart';

import '../../app/modules/tictoe_module/tictoe_page.dart';
import '../../app/modules/tictoe_module/tictoe_bindings.dart';
import '../../app/modules/homescreen_module/homescreen_page.dart';
import '../../app/modules/homescreen_module/homescreen_bindings.dart';
import '../../app/modules/signup_module/signup_page.dart';
import '../../app/modules/signup_module/signup_bindings.dart';
import '../../app/modules/loginpage_module/loginpage_bindings.dart';
import '../../app/modules/loginpage_module/loginpage_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';
/**
 * GetX Generator - fb.com/htngu.99
 * */

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.LOGINPAGE,
      page: () => loginpagePage(),
      binding: loginpageBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => signupPage(),
      binding: signupBinding(),
    ),
    GetPage(
      name: Routes.HOMESCREEN,
      page: () => HomescreenPage(),
      binding: HomescreenBinding(),
    ),
    GetPage(
      name: Routes.TICTOE,
      page: () => tictoePage(),
      binding: tictoeBinding(),
    ),
    GetPage(
      name: Routes.SPINANDWIN,
      page: () => Spinningwheel(),
      // binding: tictoeBinding(),
    ),
    GetPage(
      name: Routes.DAYILY,
      page: () => dayilyPage(),
      binding: dayilyBinding(),
    ),
    GetPage(
      name: Routes.WITHDRAW,
      page: () => withdrawPage(),
      binding: withdrawBinding(),
    ),
    GetPage(
      name: Routes.BANKS,
      page: () => banksPage(),
      binding: banksBinding(),
    ),
    GetPage(
      name: Routes.WITHDRAWHISTORY,
      page: () => withdrawhistoryPage(),
      binding: withdrawhistoryBinding(),
    ),
    GetPage(
      name: Routes.POINTHISTORY,
      page: () => pointhistoryPage(),
      binding: pointhistoryBinding(),
    ),
  ];
}
