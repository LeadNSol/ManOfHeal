import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/categories_controller.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/ui/components/form_input_field_with_icon.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';
import 'package:man_of_heal/utils/validator.dart';

class AskQuestionUI extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String? callingFor;
  final QuestionModel? questionModel;

  AskQuestionUI({this.callingFor, this.questionModel});

  @override
  Widget build(BuildContext context) {
    if (callingFor != "edit" &&
        subscriptionController.subsFirebase != null &&
        subscriptionController.subsFirebase!.noOfAskedQuestion != null &&
        subscriptionController.subsFirebase!.noOfAskedQuestion! <= 0)
      return _countDownTimerBody();

    return _formBody();
  }

  Widget _formBody() {
    var error = false.obs;
    var errorMessage = "".obs;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FormVerticalSpace(
                height: 5,
              ),
              Text(
                "${callingFor == "edit" ? "Update" : "Ask"} Question",
                style: AppThemes.headerTitleBlackFont,
              ),
              FormVerticalSpace(
                height: 10,
              ),
              callingFor == "edit"
                  ? Text('')
                  : Text(
                      'Questions Left: ${subscriptionController.subsFirebase?.noOfAskedQuestion != null ? subscriptionController.subsFirebase?.noOfAskedQuestion! : "onTrials"}',
                      style: AppThemes.normalORANGEFont,
                    ),

              FormVerticalSpace(),

              ///Category dropdown,
              Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppThemes.DEEP_ORANGE,
                          width: 1.5,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(8)),
                  child: DropdownButton(
                    isExpanded: true,
                    style: AppThemes.normalBlackFont,
                    hint: Text('${categoryController.selectedCategory.value}'),
                    onChanged: (newValue) {
                      categoryController
                          .setSelectedCategory(newValue as String);
                    },
                    items:
                        categoryController.categoriesList.map((categoryModel) {
                      String category = categoryModel.category!;
                      return DropdownMenuItem(
                        child: Text(
                          '$category',
                        ),
                        value: category,
                      );
                    }).toList(),
                    value: categoryController.selectedCategory.value,
                  ),
                ),
              ),

              FormVerticalSpace(),

              ///Question Body
              Container(
                height: 200,
                child: FormInputFieldWithIcon(
                  controller: qaController.questionController,
                  iconPrefix: Icons.question_answer_outlined,
                  labelText: 'Question Body',
                  maxLines: 4,
                  isExpanded: true,
                  autofocus: false,
                  iconColor: AppThemes.DEEP_ORANGE,
                  textStyle: AppThemes.normalBlackFont,
                  keyboardType: TextInputType.multiline,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  maxLength: 500,
                  enableBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppThemes.DEEP_ORANGE,
                      width: 2.0,
                    ),
                    //borderRadius: BorderRadius.circular(20)
                  ),
                  validator: Validator().notEmpty,
                  onChanged: (value) => null,
                  onSaved: (value) => null,
                  //qaController.questionController.text = value!,
                ),
              ),
              FormVerticalSpace(
                height: 5,
              ),
              Obx(
                () => error.isTrue
                    ? Text(
                        "* $errorMessage",
                        style: AppThemes.captionFont
                            .copyWith(color: AppThemes.DEEP_ORANGE),
                      )
                    : Text(""),
              ),
              FormVerticalSpace(
                height: 5,
              ),
              Container(
                width: 200,
                child: PrimaryButton(
                  buttonStyle: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    primary: AppThemes.DEEP_ORANGE,
                    shape: StadiumBorder(),
                  ),
                  labelText: callingFor == "edit" ? "Update" : "Submit",
                  onPressed: () async {
                    // if (_formKey.currentState!.validate()) {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    if (callingFor == "edit") {
                      questionModel!.question =
                          qaController.questionController.text;
                      questionModel!.category =
                          categoryController.selectedCategory.value;
                      questionModel!.qModifiedDate = Timestamp.now();

                      qaController.updateQuestionById(questionModel!);
                      Get.back();
                      error.value = false;
                    } else if (categoryController.selectedCategory.value
                            .toLowerCase() !=
                        CategoryController.CHOOSE_CATEGORY.toLowerCase()) {
                      if (_formKey.currentState!.validate()) {
                        qaController.createQuestion();
                        error.value = false;
                        errorMessage.value = "";
                        Get.back();
                      } else
                        error.value = true;
                      errorMessage.value = "Question must not be empty!";
                    } else {
                      error.value = true;
                      errorMessage.value = "Category is required!";
                    }
                  },
                ),
              ),
              FormVerticalSpace(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _countDownTimerBody() {
    print("_countDownTimerBody()");
    // var isNextQuestionTimeNotOver = true.obs;
    int endTime = AppConstant.getSecondsFromNowOnwardDate(
        subscriptionController.subsFirebase?.nextQuestionAt!);

    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FormVerticalSpace(),
        Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Ask Question",
              style: AppThemes.headerTitleBlackFont,
            )),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Next Question will be in: \n(5 mints for testing)',
                textAlign: TextAlign.center,
                style: AppThemes.normalBlackFont,
              ),
              FormVerticalSpace(),
              CountdownTimer(
                endTime: endTime,
                widgetBuilder: (context, CurrentRemainingTime? time) {
                  //print(time.toString());
                  if (time == null) {
                    subscriptionController
                        .updateSubscriptionOnNextQuestionTimerEnds();
                    return Text(
                      'You got ${subscriptionController.subsFirebase?.questionQuota} Questions\n'
                      'Close the dialog',
                      textAlign: TextAlign.center,
                      style: AppThemes.normalORANGEFont,
                    );
                  } else
                    return Text(
                        '${time.days == null ? "0 days" : time.days! < 2 ? "${time.days} day" : "${time.days} days"} & '
                        '${time.hours == null ? "00" : time.hours! < 10 ? "0${time.hours}" : time.hours}'
                        ':${time.min == null ? "00" : time.min! < 10 ? "0${time.min}" : time.min}'
                        ':${time.sec == null ? "00" : time.sec! < 10 ? "0${time.sec}" : time.sec}',
                        style: AppThemes.headerTitleFont.copyWith(
                            color: AppThemes.DEEP_ORANGE.withOpacity(0.7)));
                },
              ),
              FormVerticalSpace(),
            ],
          ),
        )
      ],
    );
  }
}
