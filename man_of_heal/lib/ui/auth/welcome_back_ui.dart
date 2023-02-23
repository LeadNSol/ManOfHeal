import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/ui/auth/sign_up_ui.dart';
import 'package:man_of_heal/ui/auth/sign_in_ui.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class WelcomeBackUI extends StatelessWidget {
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
                      child: SvgPicture.asset("assets/icons/logo.svg",width: 150,)
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
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do',
                      style: GoogleFonts.poppins(
                          color: AppThemes.blackPearl, fontSize: 13),
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
                          textStyle: GoogleFonts.poppins(
                              color: AppThemes.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                          onPressed: () async {
                            await authController.singInWithGoogle();
                          },
                        ),
                      ),
                    ),
                    FormVerticalSpace(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        width: 300,
                        child: PrimaryButton(
                          hasIcon: true,
                          icon: "email_welcome_icon.svg",
                          labelText: 'Sign In with Email',
                          textStyle: GoogleFonts.poppins(
                              color: AppThemes.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                          onPressed: () async {
                            authController.isSignedInWithGoogle.value = false;
                            Get.to(() => SignInUI());
                          },
                        ),
                      ),
                    ),
                    FormVerticalSpace(
                      height: 80,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () => Get.to(() => SignUpUI()),
                        child: Column(
                          children: [
                            Text("Don't have an Account?",
                                style: GoogleFonts.poppins(
                                    color: AppThemes.blackPearl,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              "Sign up here",
                              style: GoogleFonts.poppins(
                                  color: AppThemes.DEEP_ORANGE,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                      /*LabelButton(
                        labelText: "Don't have an Account?",
                        textStyle: _textTheme.bodyText1!
                            .copyWith(color: AppThemes.blackPearl),
                        onPressed: () {
                          Get.to(()=>SignUpUI());
                        },
                      )*/
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
