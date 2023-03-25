import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // TDO: implement dependencies
    //Get.lazyPut(() => AuthController());

    Get.lazyPut(() => CustomTabsController(findOrInitAuth));
    Get.lazyPut(() => SubscriptionController());


    Get.lazyPut(() => FeedBackController(
        authController: findOrInitAuth,
        notificationController: findOrInitNotification));

    Get.lazyPut(() => QAController(
        categoryController: Get.find<CategoryController>(),
        subscriptionController: Get.find<SubscriptionController>(),
        landingController: Get.find<LandingPageController>(),
        notificationController: findOrInitNotification,
        feedBackController: findOrInitFeedBack));

    Get.lazyPut(() => DailyActivityController(
        notificationController: findOrInitNotification,
        feedbackController: findOrInitFeedBack));

    Get.lazyPut(() => LabController(
        authController: findOrInitAuth,
        notificationController: findOrInitNotification));

    Get.lazyPut(() => AdminVdController(authController: findOrInitAuth, notificationController: findOrInitNotification));
  }
}
