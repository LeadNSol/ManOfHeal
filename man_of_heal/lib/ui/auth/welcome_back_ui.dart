import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:man_of_heal/ui/auth/sign_up_ui.dart';
import 'package:man_of_heal/ui/auth/sing_in_ui.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class WelcomeBackUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        /*decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [AppThemes.gradientColor_1, AppThemes.gradientColor_2],
          ),
        ),*/
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
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 140,
                    ),
                  ),
                  FormVerticalSpace(
                    height: 50,
                  ),
                  Text(
                    "Welcome Back",
                    style: _textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppThemes.DEEP_ORANGE),
                  ),
                  FormVerticalSpace(
                    height: 15,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do',
                    style: _textTheme.bodyText2!
                        .copyWith(color: AppThemes.blackPearl),
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
                        buttonStyle: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          primary: AppThemes.DEEP_ORANGE,
                          shape: StadiumBorder(),
                        ),
                        labelText: 'Sign In with Google',
                        textStyle: _textTheme.headline6!
                            .copyWith(color: AppThemes.white, fontSize: 15),
                        onPressed: () async {},
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
                        buttonStyle: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          primary: AppThemes.DEEP_ORANGE,
                          shape: StadiumBorder(),
                        ),
                        labelText: 'Sign In with Email',
                        textStyle: _textTheme.headline6!
                            .copyWith(color: AppThemes.white, fontSize: 15),
                        onPressed: () async {
                          Get.to(SignInUI());
                        },
                      ),
                    ),
                  ),
                  FormVerticalSpace(
                    height: 80,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () => Get.to(SignUpUI()),
                      child: Column(
                        children: [
                          Text("Don't have an Account?",
                              style: _textTheme.bodyText1!
                                  .copyWith(color: AppThemes.blackPearl)),
                          Text(
                            "Sign up here",
                            style: _textTheme.bodyText1!
                                .copyWith(color: AppThemes.DEEP_ORANGE),
                          ),
                        ],
                      ),
                    ),

                    /*LabelButton(
                      labelText: "Don't have an Account?",
                      textStyle: _textTheme.bodyText1!
                          .copyWith(color: AppThemes.blackPearl),
                      onPressed: () {
                        Get.to(SignUpUI());
                      },
                    )*/
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
