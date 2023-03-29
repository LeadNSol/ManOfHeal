import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class InProgressQuestionDetails extends GetView<QAController> {
  final QuestionModel questionModel;

  InProgressQuestionDetails(this.questionModel);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppThemes.BG_COLOR,
        body: body(context),
      ),
    );
  }

  Widget body(context) {
    int endTime = questionModel.toBeAnsweredIn!.millisecondsSinceEpoch;

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          height: 225,
          top: 0,
          right: 0,
          left: 0,
          child: BlackRoundedContainer(),
        ),
        Positioned(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              FormVerticalSpace(),
              CustomHeaderRow(
                title: "Status",
                hasProfileIcon: true,
              ),
              FormVerticalSpace(
                height: AppConstant.getScreenHeight(context) * 0.12,
              ),

              /// Timer
              CustomContainer(
                hasOuterShadow: true,
                height: 110,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: CountdownTimer(
                    endTime: endTime,
                    widgetBuilder: (context, CurrentRemainingTime? time) {
                      if (time == null) {
                        return Text(
                          'Time over',
                          style: GoogleFonts.poppins(
                              fontSize: 63,
                              color: AppThemes.DEEP_ORANGE.withOpacity(0.7)),
                        );
                      }
                      return Text('${AppConstant.getFormattedTime(time)}',
                          style: GoogleFonts.poppins(
                              fontSize: 63,
                              color: AppThemes.DEEP_ORANGE.withOpacity(0.7)));
                    },
                  ),

                  /* Text(
                              "71:51:00",
                              style: ),
                            ),*/
                ),
              ),

              /// question detail
              CustomContainer(
                hasOuterShadow: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HeaderWidget(questionModel),
                    FormVerticalSpace(
                      height: 10,
                    ),
                    AppConstant.textWidget("Questions", questionModel.question,
                        AppThemes.normalBlack45Font),
                    FormVerticalSpace(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: AppThemes.DEEP_ORANGE.withOpacity(0.5))),
                      child: Text(
                        '${controller.categoryController!.getCategoryById(questionModel.category)}',
                        style: GoogleFonts.poppins(
                            fontSize: 9, fontWeight: FontWeight.w600),
                      ),
                    ),
                    FormVerticalSpace(),
                    _answerButton(),
                    FormVerticalSpace(),
                    _footerWidget(),
                    FormVerticalSpace(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _footerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Image.asset(
                  "assets/icons/estimated_time_icon.png",
                  width: 13,
                ),
              ),
              TextSpan(
                text: "  Start Time",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 9),
              ),
            ],
          ),
        ),
        FormVerticalSpace(
          height: 8,
        ),
        Text(
          '${AppConstant.formattedDataTime("hh:mm a, MMM dd yyyy", questionModel.qCreatedDate!)}',
          style:
              GoogleFonts.poppins(fontSize: 14.28, fontWeight: FontWeight.w600),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "Answer Status:   ",
                  style: GoogleFonts.poppins(
                      fontSize: 14.28,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
              TextSpan(
                text: "Pending",
                style: GoogleFonts.poppins(
                  fontSize: 14.28,
                  color: Colors.black45,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _answerButton() {
    return Obx(
      () => Center(
        child: controller.ansStatusQuesModel.value.isSomeoneAnswering!
            ? Text(
                "Someone is already working...",
                style: AppThemes.buttonFont
                    .copyWith(color: AppThemes.rightAnswerColor),
              )
            : Container(
                width: 200,
                child: PrimaryButton(
                  buttonStyle: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                    backgroundColor: AppThemes.DEEP_ORANGE,
                    shape: StadiumBorder(),
                  ),
                  labelText: 'Answer',
                  textStyle: AppThemes.buttonFont,
                  onPressed: () {
                    //qaController.getAnsweringStatus(questionModel.qID!);

                    questionModel.isSomeoneAnswering = true;
                    controller.updateQuestionStatusWhenAnswering(questionModel);

                    Get.bottomSheet(
                      AnswerUI(questionModel),
                      isDismissible: false,
                      enableDrag: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      backgroundColor: Colors.white,
                    );
                  },
                ),
              ),
      ),
    );
  }
}

class AnswerUI extends GetView<QAController> {
  //const AnswerUI({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final QuestionModel questionModel;

  AnswerUI(this.questionModel);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FormVerticalSpace(
              height: 5,
            ),
            Text(
              "Answer the Question",
              style: AppThemes.headerTitleBlackFont,
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              height: 200,
              child: FormInputFieldWithIcon(
                controller: controller.dialogAnswerController!,
                iconPrefix: Icons.question_answer_outlined,
                labelText: 'Answer Body',
                maxLines: 5,
                isExpanded: true,
                autofocus: true,
                iconColor: AppThemes.DEEP_ORANGE,
                textStyle: AppThemes.normalBlackFont,
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
                //controller.questionController.text = value!,
              ),
            ),
            FormVerticalSpace(),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 100,
                    child: PrimaryButton(
                        buttonStyle: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          backgroundColor: AppThemes.DEEP_ORANGE,
                          shape: StadiumBorder(),
                        ),
                        labelText: "Cancel",
                        onPressed: () {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          questionModel.isSomeoneAnswering = false;
                          controller
                              .updateQuestionStatusWhenAnswering(questionModel);
                          Get.back();
                        }),
                  ),
                  Container(
                    width: 100,
                    child: PrimaryButton(
                        buttonStyle: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          backgroundColor: AppThemes.DEEP_ORANGE,
                          shape: StadiumBorder(),
                        ),
                        labelText: "Submit",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                            Get.back();
                            controller.answerTheQuestionById(questionModel);
                          }
                        }),
                  ),
                ],
              ),
            ),
            FormVerticalSpace(),
          ],
        ),
      ),
    );
  }
}
