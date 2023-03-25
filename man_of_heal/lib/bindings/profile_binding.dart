import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // TDO: implement dependencies

    //Get.lazyPut(() => AuthController());
    Get.lazyPut(() => SubscriptionController());
    Get.lazyPut(() => FeedBackController(
        authController: Get.find(), notificationController: Get.find()));
    Get.lazyPut(() => ProfileController(
        subscriptionController: Get.find<SubscriptionController>(), feedBackController: findOrInitFeedBack));
  }
}
