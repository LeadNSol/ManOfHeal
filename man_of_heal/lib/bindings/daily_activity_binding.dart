import 'package:get/get.dart';

import '../controllers/export_controller.dart';

class DailyActivityBinding extends Bindings {
  @override
  void dependencies() {
    // TOO: implement dependencies
    Get.lazyPut(() => FeedBackController(
        authController: Get.find(), notificationController: Get.find()));

    Get.lazyPut(() => DailyActivityController(
        authController: Get.find(),
        notificationController: Get.find(),
        feedbackController: Get.find()));
  }
}
