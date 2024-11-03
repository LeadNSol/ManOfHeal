import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:man_of_heal/controllers/auth_controller.dart';
import 'package:man_of_heal/utils/app_commons.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class SplashUI extends StatelessWidget {


  final AuthController authController = AppCommons.authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.BG_COLOR,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Load a Lottie file from your assets
            // Lottie.asset('assets/LottieLogo1.json'),
            kIsWeb
                ? Container(
                    child: Text(
                      "Web",
                      style: AppThemes.buttonFont,
                    ),
                  )
                : Center(
                    child: Lottie.asset("assets/icons/logo.json",
                        controller: authController.animationController,
                        onLoaded: (comp) {
                      authController.animationController
                        ..duration = comp
                            .duration //Duration(seconds: comp.seconds.round() + 10)
                        ..forward();
                    }),
                    /* Lottie.network(
                  'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json')*/
                  ),
            SizedBox(height: 40),
            // CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
