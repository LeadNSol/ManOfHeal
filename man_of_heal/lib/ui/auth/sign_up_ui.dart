import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/ui/components/form_input_field_with_icon.dart';
import 'package:man_of_heal/ui/components/form_password_input_field_with_icon.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/label_button.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/utils/app_themes.dart';
import 'package:man_of_heal/utils/validator.dart';

import 'sing_in_ui.dart';

class SignUpUI extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return SafeArea(
      top: true,
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
                    FormVerticalSpace(
                      height: 30,
                    ),
                    Center(child: SvgPicture.asset("assets/icons/logo.svg")),
                    FormVerticalSpace(
                      height: 30,
                    ),
                    Text(
                      "Create your\nAccount",
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
                      controller: authController.nameController,
                      iconPrefix: Icons.person,
                      labelText: 'Name',
                      autofocus: true,
                      iconColor: AppThemes.DEEP_ORANGE,
                      textStyle: TextStyle(color: AppThemes.blackPearl),
                      validator: Validator().name,
                      onChanged: (value) => null,
                      /* onSaved: (value) =>
                          authController.nameController.text = value!,*/
                      onSaved: (value) => null,
                    ),
                    FormVerticalSpace(),
                    FormInputFieldWithIcon(
                      controller: authController.emailController,
                      iconPrefix: Icons.email,
                      labelText: 'Email',
                      autofocus: false,
                      iconColor: AppThemes.DEEP_ORANGE,
                      textStyle: TextStyle(color: AppThemes.blackPearl),
                      validator: Validator().email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => null,
                      onSaved: (value) => null,
                    ),
                    FormVerticalSpace(),
                    FormPasswordInputFieldWithIcon(
                      controller: authController.passwordController,
                      iconPrefix: Icons.lock,
                      labelText: 'Password',
                      iconColor: AppThemes.DEEP_ORANGE,
                      textStyle: TextStyle(color: AppThemes.blackPearl),
                      keyboardType: TextInputType.text,
                      validator: Validator().password,
                      obscureText: true,
                      onChanged: (value) => null,
                      onSaved: (value) => null,
                      maxLines: 1,
                    ),
                    FormVerticalSpace(),
                    FormInputFieldWithIcon(
                      controller: authController.phoneController,
                      iconPrefix: Icons.phone,
                      labelText: 'Phone Number',
                      autofocus: false,
                      iconColor: AppThemes.DEEP_ORANGE,
                      textStyle: TextStyle(color: AppThemes.blackPearl),
                      keyboardType: TextInputType.phone,
                      validator: Validator().number,
                      onChanged: (value) => null,
                      onSaved: (value) => null,
                      maxLines: 1,
                    ),
                    /* FormVerticalSpace(),
                    FormInputFieldWithIcon(
                      controller: authController.degreeProgramController,
                      iconPrefix: Icons.school,
                      autofocus: false,
                      labelText: 'Degree Program',
                      iconColor: Colors.white,
                      textStyle: TextStyle(color: Colors.white),
                      validator: Validator().name,
                      onChanged: (value) => null,
                      onSaved: (value) => null,
                      maxLines: 1,
                    ),*/
                    FormVerticalSpace(),
                    FormInputFieldWithIcon(
                      controller: authController.addressController,
                      iconPrefix: Icons.fmd_good,
                      labelText: 'Address',
                      autofocus: false,
                      suffix: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'From Map',
                          style: _textTheme.bodyText2!.copyWith(
                              color: AppThemes.DEEP_ORANGE,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      iconColor: AppThemes.DEEP_ORANGE,
                      textStyle: TextStyle(color: AppThemes.blackPearl),
                      keyboardType: TextInputType.streetAddress,
                      validator: Validator().name,
                      onChanged: (value) => null,
                      onSaved: (value) => null,
                    ),
                    FormVerticalSpace(
                      height: 40,
                    ),
                    Center(
                      child: Container(
                        width: 300,
                        child: PrimaryButton(
                            labelText: 'Sign Up',
                            buttonStyle: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              primary: AppThemes.DEEP_ORANGE,
                              shape: StadiumBorder(),
                            ),
                            textStyle: _textTheme.headline5!
                                .copyWith(color: AppThemes.white),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                SystemChannels.textInput.invokeMethod(
                                    'TextInput.hide'); //to hide the keyboard - if any
                                authController.signUp();
                              }
                            }),
                      ),
                    ),
                    FormVerticalSpace(),
                    Center(
                      child:

                      InkWell(
                        onTap: () => Get.to(SignInUI()),
                        child: Column(
                          children: [
                            Text("Already have an Account?",
                                style: _textTheme.bodyText1!
                                    .copyWith(color: AppThemes.blackPearl)),
                            Text("Sign In here", style: _textTheme.bodyText1!.copyWith(color: AppThemes.DEEP_ORANGE),),
                          ],
                        ),
                      )

                    ),
                    FormVerticalSpace()
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
