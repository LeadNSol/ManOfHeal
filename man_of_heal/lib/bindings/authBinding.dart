import 'package:get/get.dart';
import 'package:man_of_heal/controllers/auth_controller.dart';
import 'package:man_of_heal/controllers/landing_page_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => LandingPageController());
  }
}
