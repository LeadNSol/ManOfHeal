import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/auth_controller.dart';
import 'package:man_of_heal/controllers/custom_tabs_controller.dart';
import 'package:man_of_heal/controllers/landing_page_controller.dart';
import 'package:man_of_heal/controllers/qa_controller.dart';
import 'package:man_of_heal/controllers/subscription_controller.dart';
import 'package:man_of_heal/utils/app_routes.dart';
import 'package:man_of_heal/utils/app_themes.dart';
import 'package:man_of_heal/utils/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await firebaseInitialization.then((value) {
    //making app wise access for the controller
    Get.put(AuthController());
    Get.put(SubscriptionController());
    Get.put(QAController());
    Get.put(LandingPageController());
    Get.put(CustomTabsController());
  });

  runApp(ManOfHeal());
}

class ManOfHeal extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () => GetMaterialApp(
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
            ));
  }
}
