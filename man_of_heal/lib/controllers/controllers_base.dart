import 'package:man_of_heal/controllers/admin_vd_controller.dart';
import 'package:man_of_heal/controllers/auth_controller.dart';
import 'package:man_of_heal/controllers/categories_controller.dart';
import 'package:man_of_heal/controllers/custom_tabs_controller.dart';
import 'package:man_of_heal/controllers/daily_activity_controller.dart';
import 'package:man_of_heal/controllers/feed_back_controller.dart';
import 'package:man_of_heal/controllers/lab_controller.dart';
import 'package:man_of_heal/controllers/landing_page_controller.dart';
import 'package:man_of_heal/controllers/notification_controller.dart';
import 'package:man_of_heal/controllers/qa_controller.dart';
import 'package:man_of_heal/controllers/subscription_controller.dart';
import 'package:man_of_heal/controllers/vd_controller.dart';

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
