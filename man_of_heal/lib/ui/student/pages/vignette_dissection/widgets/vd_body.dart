import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/quiz_model.dart';
import 'package:man_of_heal/ui/components/black_rounded_container.dart';
import 'package:man_of_heal/ui/components/custom_container.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/ui/student/pages/vignette_dissection/widgets/review_ui.dart';
import 'package:man_of_heal/ui/student/pages/vignette_dissection/widgets/score_board_ui.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class VDBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //vdController.quizQuestionsList.bindStream(vdController.getQuizQuestions());
    print('QuizQL ${vdController.quizQuestionsList.length}');
    // var quizID =  "".obs;
    //var cardQuestion = "No question found!".obs;
    //vdController.getActiveQuiz();


    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    BlackRoundedContainer(),
                  ],
                ),
              ),
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight / 1.3,
                color: AppThemes.BG_COLOR,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    //Top Question Card
                    Positioned(
                      top: -constraints.maxHeight * 0.08,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          //question body
                          CustomContainer(
                            width: constraints.maxWidth * 0.9,
                            height: 130,
                            hasOuterShadow: false,
                            child: Column(
                              children: [
                                FormVerticalSpace(),

                                //Question numbering
                                Obx(
                                  () => Text.rich(
                                    TextSpan(
                                      text:
                                          "Question ${vdController.questionNumber.value}",
                                      style: AppThemes.buttonFont.copyWith(
                                          color: AppThemes.DEEP_ORANGE),
                                      children: [
                                        TextSpan(
                                          text:
                                              "/${vdController.questions.length}",
                                          style: AppThemes.buttonFont.copyWith(
                                              color: AppThemes.DEEP_ORANGE),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                FormVerticalSpace(height: 10),
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  child: Obx(
                                    () => Text(
                                      "${vdController.quizQuestionsList[vdController.questionNumber.value - 1].question}",
                                      style: AppThemes.normalBlackFont
                                          .copyWith(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// duration
                    Positioned(
                      top: -85,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200.0),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CircularCountDownTimer(
                            width: 70,
                            height: 70,
                            duration: 15 * 60,
                            textStyle: AppThemes.normalBlackFont,
                            autoStart: true,
                            strokeCap: StrokeCap.round,
                            initialDuration: 0,
                            textFormat: CountdownTextFormat.MM_SS,
                            isReverse: true,
                            isReverseAnimation: true,
                            ringColor: Colors.grey[200]!,
                            fillColor: AppThemes.DEEP_ORANGE,
                            onStart: () {
                              debugPrint('Circular started');
                              //vdController.obtainDuration(vdController.questionNumber-1);
                            },
                            onComplete: () {
                              //vdController.countDownController.restart(duration: vdController.duration.value);
                              vdController.updateTheQnNum(
                                  vdController.questionNumber.value);
                              vdController.nextQuestion();
                              vdController.countDownController
                                  .restart(duration: 15);
                            },
                          ),
                        ),
                      ),
                    ),

                    PageView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      controller: vdController.pageController,
                      onPageChanged: vdController.updateTheQnNum,
                      itemCount: vdController.questions.length,
                      itemBuilder: (context, index) {
                        QuizQuestion quizQuestion =
                            vdController.questions[index];

                        return QuestionCard(quizQuestion);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class QuestionCard extends StatelessWidget {
  //const QuestionCard({Key? key}) : super(key: key);
  QuestionCard(this.quizQuestion);

  final QuizQuestion quizQuestion;

  @override
  Widget build(BuildContext context) {
    //vdController.setCardQuestion(quizQuestion.question!);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FormVerticalSpace(),
          ...List.generate(
            quizQuestion.options!.length,
            (index) => Options(
              quizQuestion.options![index],
              index,
              () => vdController.checkAns(
                  quizQuestion, index, quizQuestion.correctAnswer!),
            ),
          ),

          FormVerticalSpace(),

          /// Review and Submit buttons
          Obx(
            () => vdController.isLastQuestion.value
                ? btnReviewSubmit()
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget btnReviewSubmit() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 120,
            child: PrimaryButton(
              buttonStyle: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                primary: AppThemes.DEEP_ORANGE,
                shape: StadiumBorder(),
              ),
              labelText: 'Review',
              textStyle: AppThemes.buttonFont,
              onPressed: () {
                //Get.off(AdminVignetteDissectionUI());
                Get.to(ReviewUI());
              },
            ),
          ),
          Container(
            width: 120,
            child: PrimaryButton(
              buttonStyle: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                primary: AppThemes.DEEP_ORANGE,
                shape: StadiumBorder(),
              ),
              labelText: 'Submit',
              textStyle: AppThemes.buttonFont,
              onPressed: () async {
                await vdController
                    .createScoreBoard()
                    .then((value) => Get.off(() => ScoreBoardUI()));
              },
            ),
          ),
        ],
      ),
    );
  }
  _buildNewBody(context){
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        /// black background
        Positioned(
            top: 0,
            height: 225,
            left: 0,
            right: 0,
            child: BlackRoundedContainer()),

        /// question and options
        Positioned(
          top: 120,
          left: 0,
          right: 0,
          child: Column(
            children: [
              FormVerticalSpace(),
              //question body
              CustomContainer(
                width: AppConstant.getScreenWidth(context) ,
                height: 130.0,
                hasOuterShadow: false,
                child: Column(
                  children: [
                    FormVerticalSpace(),

                    //Question numbering
                    Obx(
                          () => Text.rich(
                        TextSpan(
                          text: "Question ${vdController.questionNumber.value}",
                          style: AppThemes.buttonFont
                              .copyWith(color: AppThemes.DEEP_ORANGE),
                          children: [
                            TextSpan(
                              text: "/${vdController.questions.length}",
                              style: AppThemes.buttonFont
                                  .copyWith(color: AppThemes.DEEP_ORANGE),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FormVerticalSpace(height: 10),
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Obx(
                            () => Text(
                          "${vdController.quizQuestionsList[vdController.questionNumber.value - 1].question}",
                          style:
                          AppThemes.normalBlackFont.copyWith(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
        PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: vdController.pageController,
          onPageChanged: vdController.updateTheQnNum,
          itemCount: vdController.questions.length,
          itemBuilder: (context, index) {
            QuizQuestion quizQuestion = vdController.questions[index];

            return QuestionCard(quizQuestion);
          },
        ),

        /// duration
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200.0),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircularCountDownTimer(
              width: 70,
              height: 70,
              duration: 5 * 60,
              textStyle: AppThemes.normalBlackFont,
              autoStart: true,
              strokeCap: StrokeCap.round,
              initialDuration: 0,
              textFormat: CountdownTextFormat.MM_SS,
              isReverse: true,
              isReverseAnimation: true,
              ringColor: Colors.grey[200]!,
              fillColor: AppThemes.DEEP_ORANGE,
              onStart: () {
                debugPrint('Circular started');
                //vdController.obtainDuration(vdController.questionNumber-1);
              },
              onComplete: () {
                //vdController.countDownController.restart(duration: vdController.duration.value);
                vdController.updateTheQnNum(
                    vdController.questionNumber.value);
                vdController.nextQuestion();
                vdController.countDownController
                    .restart(duration: 5);
              },
            ),
          ),
        ),
      ],
    );

  }
}



class Options extends StatelessWidget {
  final String? text;
  final int? index;
  final VoidCallback? press;

  Options(this.text, this.index, this.press);

  final optionNumber = ['a', 'b', 'c', 'd'];

  @override
  Widget build(BuildContext context) {
    Color rightColor = AppThemes.rightAnswerColor;
    Color wrongColor = AppThemes.DEEP_ORANGE;
    Color defaultColor = AppThemes.DEEP_ORANGE.withOpacity(0.3);

    return Obx(
      () {
        Color getRightAnswerColor() {
          if (vdController.isAnswered.isTrue) {
            //print('Correct answered:  ${vdController.correctAns}');
            if (index == vdController.correctAns) {
              return rightColor;
            } else if (index == vdController.selectedAns &&
                vdController.selectedAns != vdController.correctAns) {
              return wrongColor;
            }
          } else {
            print('Correct notAnswered');
          }
          return defaultColor;
        }

        IconData getRightAnswerIcon() {
          return getRightAnswerColor() == wrongColor ? Icons.close : Icons.done;
        }

        return InkWell(
          onTap: press,
          child: Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            height: 45,
            decoration: BoxDecoration(
              border: Border.all(color: getRightAnswerColor()),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${optionNumber[index!]}. $text",
                  style: AppThemes.normalBlack45Font,
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: getRightAnswerColor() == defaultColor
                        ? Colors.transparent
                        : getRightAnswerColor(),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: getRightAnswerColor()),
                  ),
                  child: getRightAnswerColor() == defaultColor
                      ? null
                      : Icon(
                          getRightAnswerIcon(),
                          size: 16,
                          color: AppThemes.white,
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
