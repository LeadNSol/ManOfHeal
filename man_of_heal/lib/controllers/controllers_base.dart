
// AuthController authController = findOrInitAuth;
//
// AuthController get findOrInitAuth {
//   try {
//     return Get.find();
//   } catch (e) {
//     Get.put<AuthController>(AuthController());
//     return Get.find();
//   }
// }

// NotificationController get findOrInitNotification {
//   try {
//     return Get.find();
//   } catch (e) {
//     Get.put<NotificationController>(NotificationController());
//     return Get.find();
//   }
// }

// FeedBackController get findOrInitFeedBack {
//   try {
//     return Get.find();
//   } catch (e) {
//     Get.put<FeedBackController>(FeedBackController(
//         authController: findOrInitAuth,
//         notificationController: findOrInitNotification));
//     return Get.find();
//   }
// }
/*
AuthController authController = AuthController.instance;

QAController qaController = QAController.instance; //Get.find<QAController>();

LandingPageController landingPageController = LandingPageController.instance;

SubscriptionController subscriptionController = SubscriptionController.instance;

VDController vdController = VDController.instance;
AdminVdController adminVdController = AdminVdController.instance;

CustomTabsController customTabsController = CustomTabsController.instance;

LabController labController = LabController.instance;

DailyActivityController dailyActivityController =
    DailyActivityController.instance;

NotificationController notificationController = NotificationController.instance;

FeedBackController feedBackController = FeedBackController.instance;

CategoryController categoryController = CategoryController.instance;
*/
