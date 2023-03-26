import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class SignInUI extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    /// btn state default
    authController.setBtnState(0);
    return Scaffold(
      body: SafeArea(
        child: Form(
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
                    FormVerticalSpace(
                      height: 50,
                    ),
                    Center(
                        child: SvgPicture.asset(
                      "assets/icons/logo.svg",
                      width: 150,
                    )),
                    FormVerticalSpace(
                      height: 50,
                    ),
                    Text(
                      "Sign in to your\nAccount",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          color: AppThemes.DEEP_ORANGE),
                    ),
                    FormVerticalSpace(
                      height: 15,
                    ),
                    Text(
                      signInText,
                      style: GoogleFonts.montserrat(
                          fontSize: 13, color: AppThemes.blackPearl),
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
                      textStyle: AppThemes.normalBlackFont,
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
                      textStyle: AppThemes.normalBlackFont,
                      labelText: 'Password',
                      validator: Validator().password,
                      obscureText: true,
                      onChanged: (value) => null,
                      maxLines: 1,
                    ),
                    FormVerticalSpace(
                      height: 40,
                    ),
                    Obx(
                      () => Center(
                        child: _setupButton(),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: LabelButton(
                        labelText: 'Forgot Password!',
                        textStyle: AppThemes.normalORANGEFont,
                        onPressed: () => Get.to(() => ForgotPassword()),
                      ),
                    ),
                    FormVerticalSpace(),
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

  Widget _setupButton() {
    if (authController.btnState! == 1)
      return Container(
        width: 45,
        height: 45,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppThemes.DEEP_ORANGE,
        ),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 2.5,
        ),
      );
    else if (authController.btnState! == 2)
      return Container(
          width: 45,
          height: 45,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppThemes.rightAnswerColor,
          ),
          child: Center(
              child: Icon(Icons.check, size: 30, color: AppThemes.white)));
    return Container(
      width: 300,
      child: PrimaryButton(
          buttonStyle: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            primary: AppThemes.DEEP_ORANGE,
            shape: StadiumBorder(),
          ),
          labelText: 'SIGN IN',
          textStyle: AppThemes.buttonFont,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              SystemChannels.textInput.invokeMethod(
                  'TextInput.hide'); //to hide the keyboard - if any
              // animateButton();
              authController.signIn();
            }
          }),
    );
  }

  void animateButton() {}
}
