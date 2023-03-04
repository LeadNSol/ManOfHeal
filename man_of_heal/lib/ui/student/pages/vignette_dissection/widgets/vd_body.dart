import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';


class VDBody extends GetView<VDController> {
  @override
  Widget build(BuildContext context) {
    //return _body(context);
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
                                          "Question ${controller.questionNumber.value}",
                                      style: AppThemes.buttonFont.copyWith(
                                          color: AppThemes.DEEP_ORANGE),
                                      children: [
                                        TextSpan(
                                          text:
                                              "/${controller.questions.length}",
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
                                      "${controller.quizQuestionsList[controller.questionNumber.value - 1].question}",
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
                          child: Obx(() {
                            int duration = (((controller.duration.value) /
                                            controller.questions.length) /
                                        10)
                                    .round() *
                                60;

                            return CircularCountDownTimer(
                              width: 70,
                              height: 70,
                              controller: controller.countDownController,
                              duration: duration,
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
                                //controller.obtainDuration(controller.questionNumber-1);
                              },
                              onComplete: () {
                                //controller.countDownController.restart(duration: controller.duration.value);
                                if (controller.isLastQuestion.isFalse) {
                                  controller.updateTheQnNum(
                                      controller.questionNumber.value);
                                  controller.nextQuestion();
                                  controller.countDownController
                                      .restart(duration: duration);
                                } else {
                                  controller.countDownController.reset();
                                }
                              },
                            );
                          }),
                        ),
                      ),
                    ),

                    PageView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      controller: controller.pageController,
                      onPageChanged: controller.updateTheQnNum,
                      itemCount: controller.questions.length,
                      itemBuilder: (context, index) {
                        QuizQuestion quizQuestion =
                            controller.questions[index];

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

/*_body(context) {
  return Stack(
    fit: StackFit.expand,
    clipBehavior: Clip.antiAlias,
    children: [
      /// black background
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        height: 210,
        child: BlackRoundedContainer(),
      ),

      /// QuestionCard plus options
      Positioned(
        top: 120,
        left: 0,
        right: 0,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          children: [
            FormVerticalSpace(),
            CustomContainer(
              //width: constraints.maxWidth * 0.9,
              margin: EdgeInsets.only(
                left: 17.0,
                right: 17.0,
              ),
              height: 130,
              child: Column(
                children: [
                  FormVerticalSpace(),

                  //Question numbering
                  Obx(
                    () => Text.rich(
                      TextSpan(
                        text: "Question ${controller.questionNumber.value}",
                        style: AppThemes.buttonFont
                            .copyWith(color: AppThemes.DEEP_ORANGE),
                        children: [
                          TextSpan(
                            text: "/${controller.questions.length}",
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
                        "${controller.quizQuestionsList[controller.questionNumber.value - 1].question}",
                        style: AppThemes.normalBlackFont.copyWith(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      ///Duration circle
      Positioned(
        top: 100,
        left: 0,
        right: 0,
        child: Column(
          children: [
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
                    //controller.obtainDuration(controller.questionNumber-1);
                  },
                  onComplete: () {
                    //controller.countDownController.restart(duration: controller.duration.value);
                    controller
                        .updateTheQnNum(controller.questionNumber.value);
                    controller.nextQuestion();
                    controller.countDownController.restart(duration: 15);
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      ///PageView Options
      Positioned(
        top: 70,
        left: 0,
        right: 0,
        child: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          onPageChanged: controller.updateTheQnNum,
          itemCount: controller.questions.length,
          itemBuilder: (context, index) {
            QuizQuestion quizQuestion = controller.questions[index];

            return QuestionCard(quizQuestion);
          },
        ),
      ),
    ],
  );
}*/

class QuestionCard extends GetView<VDController> {
  //const QuestionCard({Key? key}) : super(key: key);
  QuestionCard(this.quizQuestion);

  final QuizQuestion quizQuestion;

  @override
  Widget build(BuildContext context) {
    //controller.setCardQuestion(quizQuestion.question!);
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
              () => controller.checkAns(
                  quizQuestion, index, quizQuestion.correctAnswer!),
            ),
          ),

          FormVerticalSpace(),

          /// Review and Submit buttons
          Obx(
            () => controller.isLastQuestion.value
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
                backgroundColor: AppThemes.DEEP_ORANGE,
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
                backgroundColor: AppThemes.DEEP_ORANGE,
                shape: StadiumBorder(),
              ),
              labelText: 'Submit',
              textStyle: AppThemes.buttonFont,
              onPressed: () async {
                await controller
                    .createScoreBoard()
                    .then((value) => Get.off(() => ScoreBoardUI()));
              },
            ),
          ),
        ],
      ),
    );
  }

/*  _buildNewBody(context) {
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
                width: AppConstant.getScreenWidth(context),
                height: 130.0,
                hasOuterShadow: false,
                child: Column(
                  children: [
                    FormVerticalSpace(),

                    //Question numbering
                    Obx(
                      () => Text.rich(
                        TextSpan(
                          text: "Question ${controller.questionNumber.value}",
                          style: AppThemes.buttonFont
                              .copyWith(color: AppThemes.DEEP_ORANGE),
                          children: [
                            TextSpan(
                              text: "/${controller.questions.length}",
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
                          "${controller.quizQuestionsList[controller.questionNumber.value - 1].question}",
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
          controller: controller.pageController,
          onPageChanged: controller.updateTheQnNum,
          itemCount: controller.questions.length,
          itemBuilder: (context, index) {
            QuizQuestion quizQuestion = controller.questions[index];

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
                //controller.obtainDuration(controller.questionNumber-1);
              },
              onComplete: () {
                //controller.countDownController.restart(duration: controller.duration.value);
                controller.updateTheQnNum(controller.questionNumber.value);
                controller.nextQuestion();
                controller.countDownController.restart(duration: 5);
              },
            ),
          ),
        ),
      ],
    );
  }*/
}

class Options extends GetView<VDController> {
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
          if (controller.isAnswered.isTrue) {
            //print('Correct answered:  ${controller.correctAns}');
            if (index == controller.correctAns) {
              return rightColor;
            } else if (index == controller.selectedAns &&
                controller.selectedAns != controller.correctAns) {
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
