import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/ui/auth/forgot_password_ui.dart';
import 'package:man_of_heal/ui/auth/sign_up_ui.dart';
import 'package:man_of_heal/ui/components/form_input_field_with_icon.dart';
import 'package:man_of_heal/ui/components/form_password_input_field_with_icon.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/label_button.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/utils/app_themes.dart';
import 'package:man_of_heal/utils/validator.dart';

class SignInUI extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //LogoGraphicHeader(),
                    Center(child: SvgPicture.asset("assets/icons/logo.svg")),
                    FormVerticalSpace(
                      height: 50,
                    ),
                    Text(
                      "Sign in to your\nAccount",
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
                      height: 10,
                    ),
                    FormInputFieldWithIcon(
                      controller: authController.emailController,
                      iconPrefix: Icons.email,
                      labelText: 'Email',
                      iconColor: AppThemes.DEEP_ORANGE,
                      autofocus: true,
                      textStyle: TextStyle(color: AppThemes.blackPearl),
                      validator: Validator().email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => null,
                      onSaved: (value) => null,
                    ),
                    FormVerticalSpace(),
                    FormPasswordInputFieldWithIcon(
                      controller: authController.passwordController,
                      iconPrefix: Icons.lock_rounded,
                      iconColor: AppThemes.DEEP_ORANGE,
                      textStyle: TextStyle(color: AppThemes.blackPearl),
                      labelText: 'Password',
                      validator: Validator().password,
                      obscureText: true,
                      onChanged: (value) => null,
                      maxLines: 1,
                    ),
                    FormVerticalSpace(
                      height: 40,
                    ),
                    Center(
                      child: Container(
                        width: 300,
                        child: PrimaryButton(
                            buttonStyle: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              primary: AppThemes.DEEP_ORANGE,
                              shape: StadiumBorder(),
                            ),
                            labelText: 'SIGN IN',
                            textStyle: _textTheme.headline6!
                                .copyWith(color: AppThemes.white),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                SystemChannels.textInput.invokeMethod(
                                    'TextInput.hide'); //to hide the keyboard - if any
                                authController.signIn();
                              }
                            }),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: LabelButton(
                        labelText: 'Forgot Password!',
                        textStyle: _textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppThemes.DEEP_ORANGE),
                        onPressed: () => Get.to(ForgotPassword()),
                      ),
                    ),
                    FormVerticalSpace(),
                    Center(
                      child: InkWell(
                        onTap: () => Get.to(SignUpUI()),
                        child: Column(
                          children: [
                            Text("Don't have an Account?",
                                style: _textTheme.bodyText1!
                                    .copyWith(color: AppThemes.blackPearl)),
                            Text("Sign up here", style: _textTheme.bodyText1!.copyWith(color: AppThemes.DEEP_ORANGE),),
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
/*
RichText(
text: TextSpan(
text: 'Don\'t have an account?',
style: _textTheme.bodyMedium!.copyWith(color: AppThemes.white,),
children: <TextSpan>[
TextSpan(text: '\n         Sign up here',
style: _textTheme.bodyLarge!.copyWith(color: AppThemes.white),
recognizer: TapGestureRecognizer()
..onTap = () {
// navigate to desired screen
Get.to(SignUpUI());
}
)
]
),
),*/
