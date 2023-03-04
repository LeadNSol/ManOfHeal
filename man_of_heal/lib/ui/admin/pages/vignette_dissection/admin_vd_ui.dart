import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class AdminVignetteDissectionUI extends GetView<AdminVdController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppThemes.BG_COLOR,
      body: VDQuizReview(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print('Pressed WEEKDAY ${DateTime.now().weekday}');
          String weekDay = DateFormat('EEEE').format(DateTime.now());

          print('Pressed WEEKDAY $weekDay');
          if (weekDay.toLowerCase() == "wednesday")
            Get.defaultDialog(
              title: 'Add Quiz',
              titleStyle: AppThemes.headerTitleBlackFont,
              content: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FormInputFieldWithIcon(
                        controller: controller.quizTitleController,
                        iconPrefix: Icons.title,
                        labelText: 'Quiz title',
                        autofocus: true,
                        iconColor: AppThemes.DEEP_ORANGE,
                        textStyle: AppThemes.normalBlackFont,
                        //validator: Validator().notEmpty,
                        keyboardType: TextInputType.text,
                        onChanged: (value) => null,
                        onSaved: (value) => null,
                      ),
                      FormVerticalSpace(
                        height: 10,
                      ),
                      FormInputFieldWithIcon(
                        controller: controller.quizDescriptionController,
                        iconPrefix: Icons.description_outlined,
                        labelText: 'Quiz Description',
                        autofocus: false,
                        maxLines: 5,
                        maxLength: 500,
                        iconColor: AppThemes.DEEP_ORANGE,
                        textStyle: AppThemes.normalBlackFont,
                        //validator: Validator().notEmpty,
                        keyboardType: TextInputType.text,
                        onChanged: (value) => null,
                        onSaved: (value) => null,
                      ),
                      FormVerticalSpace(),

                      /// dropdown duration
                      Obx(
                        () => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppThemes.DEEP_ORANGE,
                                  width: 1.5,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FormVerticalSpace(
                                height: 10,
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Duration',
                                    style: AppThemes.normalBlackFont,
                                  )),
                              DropdownButton(
                                isExpanded: true,
                                style: AppThemes.normalBlackFont,
                                hint: Text('${controller.duration.value}'),
                                onChanged: (newValue) {
                                  controller.setDuration(newValue);
                                },
                                items: controller.durationsList.map((element) {
                                  //print('Option Value: ${controller.option.value}');
                                  return DropdownMenuItem(
                                    child: Text('$element Mints'),
                                    value: element,
                                  );
                                }).toList(),
                                value: controller.duration.value,
                              ),
                            ],
                          ),
                        ),
                      ),
                      FormVerticalSpace(
                        height: 10,
                      ),

                      //FormVerticalSpace()
                    ],
                  ),
                ),
              ),
              confirm: Container(
                width: 150,
                child: PrimaryButton(
                    buttonStyle: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      backgroundColor: AppThemes.DEEP_ORANGE,
                      shape: StadiumBorder(),
                    ),
                    labelText: 'Add',
                    textStyle: AppThemes.buttonFont,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        SystemChannels.textInput.invokeMethod(
                            'TextInput.hide'); //to hide the keyboard - if any
                        await controller.createQuiz();
                        Get.back();
                      }
                    }),
              ),

              /*onConfirm: () async {
              await controller.createQuiz();
            },*/
            );
          else
            AppConstant.displaySnackBar("Warning",
                "It's not Wednesday, You can access this only on Wednesday");
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
