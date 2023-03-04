import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';

class StdHomeBinding extends Bindings {
  @override
  void dependencies() {
    // TDO: implement dependencies

    Get.lazyPut(() => CustomTabsController(Get.find<AuthController>()));
    Get.lazyPut(() => SubscriptionController());
    Get.lazyPut(() => CategoryController());

    Get.lazyPut(() => QAController(
        categoryController: Get.find(),
        subscriptionController: Get.find(),
        landingController: Get.find(),
        notificationController: Get.find(),
        feedBackController: Get.find()));
  }
}
