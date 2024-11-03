// import 'package:get/get.dart';
// import 'package:man_of_heal/controllers/export_controller.dart';
//
// class DashboardBinding extends Bindings {
//   @override
//   void dependencies() {
//     // TDO: implement dependencies
//     //Get.lazyPut(() => AuthController());
//     Get.put(SubscriptionController());
//     Get.put(CategoryController());
//
//     Get.lazyPut(() => CustomTabsController(Get.find()));
//
//     Get.lazyPut(() => FeedBackController(
//         authController: Get.find(), notificationController: Get.find()));
//
//     // Get.lazyPut(() => QAController(
//     //     categoryController: Get.find<CategoryController>(),
//     //     subscriptionController: Get.find<SubscriptionController>(),
//     //     landingController: Get.find<LandingPageController>(),
//     //     notificationController: Get.find(),
//     //     feedBackController: Get.find()));
//
//     Get.lazyPut(() => DailyActivityController(
//         notificationController: Get.find(), feedbackController: Get.find()));
//
//     Get.lazyPut(() => LabController(
//         authController: Get.find(), notificationController: Get.find()));
//
//     Get.lazyPut(() => AdminVdController(
//         authController: Get.find(),
//         notificationController: Get.find()));
//     Get.lazyPut(() => VDController());
//   }
// }
