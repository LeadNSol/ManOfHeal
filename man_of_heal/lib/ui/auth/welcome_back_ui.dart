import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class WelcomeBackUI extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //LogoGraphicHeader(),
                    Align(
                      alignment: Alignment.center,
                      child: buildLogo(),
                    ),
                    FormVerticalSpace(
                      height: 50,
                    ),
                    Text(
                      "Welcome Back",
                      style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppThemes.DEEP_ORANGE),
                    ),
                    FormVerticalSpace(
                      height: 15,
                    ),
                    Text(
                      welcomeText,
                      style: AppThemes.normalBlackFont,
                    ),
                    FormVerticalSpace(
                      height: 30,
                    ),
                    Center(
                      child: Container(
                        width: 300,
                        child: PrimaryButton(
                          hasIcon: true,
                          icon: "google_icon.svg",
                          labelText: 'Sign In with Google',
                          textStyle: AppThemes.buttonFont,
                          onPressed: () async {
                            await authController.singInWithGoogle();
                          },
                        ),
                      ),
                    ),
                    FormVerticalSpace(height: 10),
                    Center(
                      child: Container(
                        width: 300,
                        child: PrimaryButton(
                          hasIcon: true,
                          icon: "email_welcome_icon.svg",
                          labelText: 'Sign In with Email',
                          textStyle: AppThemes.buttonFont,
                          onPressed: () async {
                            authController.isSignedInWithGoogle.value = false;
                            Get.toNamed(AppRoutes.signInRoute);
                          },
                        ),
                      ),
                    ),
                    FormVerticalSpace(height: 80),
                    Center(
                      child: InkWell(
                        onTap: () => Get.toNamed(AppRoutes.signUpRoute),
                        child: Column(
                          children: [
                            Text("Don't have an Account?",
                                style: AppThemes.normalBlackFont),
                            Text(
                              "Sign up here",
                              style: AppThemes.normalORANGEFont,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
