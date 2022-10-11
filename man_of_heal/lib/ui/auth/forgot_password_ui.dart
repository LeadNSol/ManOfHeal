import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/ui/auth/sing_in_ui.dart';
import 'package:man_of_heal/ui/components/form_input_field_with_icon.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/label_button.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/utils/app_themes.dart';
import 'package:man_of_heal/utils/validator.dart';

class ForgotPassword extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
       // appBar: appBar(context),
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
                    // LogoGraphicHeader(),
                    Center(child: SvgPicture.asset("assets/icons/logo.svg",width: 150,)),
                    FormVerticalSpace(
                      height: 50,
                    ),
                    Text(
                      "Reset Your Account\nPassword",
                      style:AppThemes.header1,
                    ),
                    FormVerticalSpace(
                      height: 15,
                    ),
                    FormInputFieldWithIcon(
                      controller: authController.emailController,
                      iconPrefix: Icons.email,
                      labelText: 'Email',
                      iconColor: AppThemes.DEEP_ORANGE,
                      autofocus: true,
                      textStyle: AppThemes.normalBlackFont,
                      validator: Validator().email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => null,
                      onSaved: (value) => null,
                    ),
                    FormVerticalSpace(),
                    FormVerticalSpace(
                      height: 40,
                    ),
                    Center(
                      child: Container(
                        width: 300,
                        child: PrimaryButton(
                            buttonStyle: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 13.0),
                              primary: AppThemes.DEEP_ORANGE,
                              shape: StadiumBorder(),
                            ),
                            labelText: 'Reset Password',
                            textStyle: AppThemes.buttonFont,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                SystemChannels.textInput.invokeMethod(
                                    'TextInput.hide'); //to hide the keyboard - if any
                                await authController
                                    .sendPasswordResetEmail(context);
                              }
                            }),
                      ),
                    ),
                    FormVerticalSpace(),
                    signInLink(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  appBar(BuildContext context) {
    if (authController.emailController.text == '') {
      return null;
    }
    return AppBar(title: Text('Reset Password'));
  }

  signInLink(BuildContext context) {
    if (authController.emailController.text == '') {
      return Center(
        child: LabelButton(
          labelText: 'Back to Sign In',
          textStyle: AppThemes.normalORANGEFont,
          onPressed: () => Get.offAll(SignInUI()),
        ),
      );
    }
    return Container(width: 0, height: 0);
  }
}
