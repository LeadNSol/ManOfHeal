import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/ui/components/base_widget.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class SignUpUI extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());
  
  @override
  Widget build(BuildContext context) {

    authController.setBtnState(0);
    return BaseWidget(
      backgroundColor: AppThemes.BG_COLOR,
      statusBarColor: AppThemes.BG_COLOR,
      statusBarIconBrightness: Brightness.dark,
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
                    FormVerticalSpace(
                      height: 50
                    ),
                    Center(
                      child: SvgPicture.asset(
                        "assets/icons/logo.svg",
                        width: 150,
                      ),
                    ),
                    FormVerticalSpace(
                      height: 30,
                    ),
                    Text(
                      "Create your\nAccount",
                      style: AppThemes.header1,
                    ),
                    FormVerticalSpace(
                      height: 15,
                    ),
                    Text(
                      signUpText, style: GoogleFonts.montserrat(
                          fontSize: 13, color: AppThemes.blackPearl),
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
                      textStyle: AppThemes.normalBlackFont,
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
                      textStyle: AppThemes.normalBlackFont,
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
                      textStyle: AppThemes.normalBlackFont,
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
                      textStyle: AppThemes.normalBlackFont,
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
                      /* suffix: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'From Map',
                          style: AppThemes.normalORANGEFont,
                        ),
                      ),*/
                      iconColor: AppThemes.DEEP_ORANGE,
                      textStyle: AppThemes.normalBlackFont,
                      keyboardType: TextInputType.streetAddress,
                      validator: Validator().notEmpty,
                      onChanged: (value) => null,
                      onSaved: (value) => null,
                    ),
                    FormVerticalSpace(
                      height: 40,
                    ),
                    Obx(
                      () => Center(
                        child: _setupSignUpBtn(),
                      ),
                    ),
                    FormVerticalSpace(),
                    Center(
                        child: InkWell(
                      onTap: () => Get.to(() => SignInUI()),
                      child: Column(
                        children: [
                          Text("Already have an Account?",
                              style: AppThemes.normalBlackFont),
                          Text("Sign In here",
                              style: AppThemes.normalORANGEFont),
                        ],
                      ),
                    )),
                    FormVerticalSpace()
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }

  Widget _setupSignUpBtn() {
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
          child: Icon(Icons.check, size: 30, color: AppThemes.white));

    return Container(
      width: 300,
      child: PrimaryButton(
          labelText: 'Sign Up',
          buttonStyle: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            backgroundColor: AppThemes.DEEP_ORANGE,
            shape: StadiumBorder(),
          ),
          textStyle: AppThemes.buttonFont,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              SystemChannels.textInput.invokeMethod(
                  'TextInput.hide'); //to hide the keyboard - if any
              authController.signUp();
            }
          }),
    );
  }
}
