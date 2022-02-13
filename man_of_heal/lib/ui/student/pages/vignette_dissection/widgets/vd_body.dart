import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/quiz_model.dart';
import 'package:man_of_heal/ui/components/custom_container.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/utils/app_themes.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class VDBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

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
                    Container(
                      decoration: BoxDecoration(
                        color: AppThemes.blackPearl,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                    ),
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
                      top: -constraints.maxHeight * 0.10,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          //question body
                          CustomContainer(
                            width: constraints.maxWidth * 0.9,
                            height: constraints.maxWidth * 0.42,
                            hasOuterShadow: false,
                            child: Column(
                              children: [
                                FormVerticalSpace(height: 10),

                                //Question numbering
                                Obx(
                                  () => Text.rich(
                                    TextSpan(
                                      text:
                                          "Question ${vdController.questionNumber.value}",
                                      style: textTheme.headline5!.copyWith(
                                          color: AppThemes.DEEP_ORANGE),
                                      children: [
                                        TextSpan(
                                          text:
                                              "/${vdController.questions.length}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
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
                                      "${vdController.cardQuestion.value}",
                                      style: textTheme.bodyText1!.copyWith(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      top: -90,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200.0),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CircularPercentIndicator(
                            radius: 50.0,
                            lineWidth: 4.0,
                            //animateFromLastPercent: true,
                            animationDuration: 1000,
                            animation: true,
                            percent: vdController.animation.value,
                            center: new Text(
                              "${vdController.animation.value}",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17.0),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: AppThemes.DEEP_ORANGE,
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
                        //vdController.setCardQuestion(quizQuestion.question!);
                        print(
                            'Correct Index before: ${quizQuestion.correctAnswer}');
                        return QuestionCard(
                            quizQuestion, constraints, textTheme);
                      },
                    )
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
  QuestionCard(this.quizQuestion, this.constraints, this.textTheme);

  final BoxConstraints constraints;
  final QuizQuestion quizQuestion;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...List.generate(
            quizQuestion.options!.length,
            (index) => Options(
              quizQuestion.options![index],
              index,
              () => vdController.checkAns(
                  quizQuestion, index, quizQuestion.correctAnswer!),
            ),
          ),
        ],
      ),
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
            print('Correct answered:  ${vdController.correctAns}');
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
                  style: TextStyle(color: getRightAnswerColor(), fontSize: 16),
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

   /* return GetBuilder<VDController>(
      init: VDController(),
      builder: (controller) {
        Color getRightAnswerColor() {
          if (controller.isAnswered.isTrue) {
            print('Correct answered:  ${controller.correctAns}');
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
                  style: TextStyle(color: getRightAnswerColor(), fontSize: 16),
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
    );*/
  }
}
