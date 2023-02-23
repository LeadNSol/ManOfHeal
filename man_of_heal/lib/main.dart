import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/bindings/init_binding.dart';
import 'package:man_of_heal/controllers/auth_controller.dart';
import 'package:man_of_heal/controllers/categories_controller.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/controllers/custom_tabs_controller.dart';
import 'package:man_of_heal/controllers/daily_activity_controller.dart';
import 'package:man_of_heal/controllers/feed_back_controller.dart';
import 'package:man_of_heal/controllers/lab_controller.dart';
import 'package:man_of_heal/controllers/landing_page_controller.dart';
import 'package:man_of_heal/controllers/notification_controller.dart';
import 'package:man_of_heal/controllers/qa_controller.dart';
import 'package:man_of_heal/controllers/subscription_controller.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_routes.dart';
import 'package:man_of_heal/utils/app_themes.dart';
import 'package:man_of_heal/utils/firebase.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage? message) async {
  Firebase.initializeApp();
  print('Handling a background message ${message!.messageId}');
  print(message.data);

  notificationController.showNotification(message);
}

Future<void> putControllersToGet() async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set the publishable key for Stripe - this is mandatory
  //await Stripe.instance.applySettings();

  if (!kIsWeb) {
    Stripe.publishableKey = AppConstant.PUBLISHABLE_KEY;
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.grey[300]!));
  }
  await firebaseInitialization.then((value) {
    //making app wise access for the controller
    Get.put(AuthController());
    Get.put(LandingPageController());
    Get.put(CustomTabsController());

    Get.put(NotificationController());
    Get.put(CategoryController());
    Get.put(SubscriptionController());
    Get.put(LabController());
    Get.put(DailyActivityController());
    Get.put(QAController());
    Get.put(FeedBackController());
  });

  //
  //  Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    await notificationController.createAndroidNotificationChannel();
    await notificationController.updateIOSNotificationOptions();
  }
  runApp(ManOfHeal());
}

class ManOfHeal extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    /*  if (kIsWeb) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        //disabling demo label
        title: 'Man Of Heal',

        //theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        //themeMode: ThemeMode.system,
        // themeMode: ThemeMode.system,

        initialRoute: "/",
        getPages: AppRoutes.routes,
        //home: SignInUI(),
      );
    }*/
    return ScreenUtilInit(
      //designSize: Size(360, 700),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        //disabling demo label
        title: 'Man Of Heal',

        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.system,

        initialRoute: "/",
        getPages: AppRoutes.routes,

        initialBinding: AppInitBindings(),

        //home: SignInUI(),
      ),
    );
  }
}
