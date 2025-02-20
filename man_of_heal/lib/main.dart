import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/utils/export_utils.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage? message) async {
  Firebase.initializeApp();
  print('Handling a background message ${message!.messageId}');
  print(message.data);

  Get.put(NotificationController()).showNotification(message);
}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // set the publishable key for Stripe - this is mandatory
  //await Stripe.instance.applySettings();

  if (!kIsWeb) {
    Stripe.publishableKey = AppConstant.PUBLISHABLE_KEY;
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Colors.grey[100]!));
  }
  /*await firebaseInitialization.then((value) {
    //making app wise access for the controller
    //Get.put(AuthController());
    //Get.put(LandingPageController());

    // Get.put(CustomTabsController());

    //Get.put(NotificationController());

    //Get.put(CategoryController());
    //Get.put(SubscriptionController());
    //Get.put(LabController());

    //Get.put(DailyActivityController());
    // Get.put(QAController());
    //Get.put(FeedBackController());
  });*/

  //
  //  Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    await Get.put(NotificationController()).createAndroidNotificationChannel();
    await Get.put(NotificationController()).updateIOSNotificationOptions();
  }
  runApp(ManOfHeal());
}

class ManOfHeal extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 812),
      //minTextAdapt: true,
      //splitScreenMode: true,
      builder: (_, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        //disabling demo label
        title: 'Man Of Heal',

        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.system,
        //navigatorObservers: [AppRouteObserver()],
        initialRoute: AppRoutes.initRoute,
        getPages: AppRoutes.routes,
        //initialBinding: AppInitBindings(),

        //home: SignInUI(),
      ),
    );
  }
}
