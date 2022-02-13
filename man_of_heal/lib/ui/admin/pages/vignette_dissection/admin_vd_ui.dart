import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/admin_vd_controller.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/ui/components/form_input_field_with_icon.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/utils/app_themes.dart';
import 'package:man_of_heal/utils/validator.dart';

import 'widgets/vd_quiz_body.dart';

class AdminVignetteDissectionUI extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(AdminVdController());
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppThemes.BG_COLOR,
      appBar: AppBar(
        //leadingWidth: 25,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: AppThemes.blackPearl,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Vignette Dissection",
          style: textTheme.headline6!.copyWith(color: AppThemes.blackPearl),
        ),
      ),
      body: SafeArea(child: VDQuizBody()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Pressed fab');
          Get.defaultDialog(
            title: 'Add Quiz',
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FormInputFieldWithIcon(
                      controller: adminVdController.quizQuestionController,
                      iconPrefix: Icons.title,
                      labelText: 'Quiz title',
                      autofocus: false,
                      iconColor: AppThemes.DEEP_ORANGE,
                      textStyle: TextStyle(color: AppThemes.DEEP_ORANGE),
                      validator: Validator().notEmpty,
                      keyboardType: TextInputType.text,
                      onChanged: (value) => null,
                      onSaved: (value) => null,
                    ),
                    FormVerticalSpace(),
                  ],
                ),
              ),
            ),
            confirm:  Container(
              width: 120,
              child: PrimaryButton(
                  buttonStyle: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    primary: AppThemes.DEEP_ORANGE,
                    shape: StadiumBorder(),
                  ),
                  labelText: 'Add',
                  textStyle: textTheme.headline5!
                      .copyWith(color: AppThemes.white),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      SystemChannels.textInput.invokeMethod(
                          'TextInput.hide'); //to hide the keyboard - if any
                      await adminVdController.createQuiz();
                    }
                  }),
            ),
            /*onConfirm: () async {
              await adminVdController.createQuiz();
            },*/
          );
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [AppThemes.gradientColor_1, AppThemes.gradientColor_2],
            ),
          ),
          child: Icon(
            Icons.add_rounded,
            size: 30,
          ),
          // child: SvgPicture.asset("assets/icons/fab_icon.svg"),
        ),
      ),
    );
  }
}
