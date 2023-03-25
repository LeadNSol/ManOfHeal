import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';



class DailyActivityBinding extends Bindings {
  @override
  void dependencies() {
    // TOO: implement dependencies
    Get.lazyPut(() => FeedBackController(
        authController: findOrInitAuth, notificationController:findOrInitNotification));

    Get.lazyPut(() => DailyActivityController(
        notificationController: findOrInitNotification,
        feedbackController: findOrInitFeedBack));
  }
}
