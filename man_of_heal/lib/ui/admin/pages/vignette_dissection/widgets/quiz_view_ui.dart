import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/quiz_model.dart';
import 'package:man_of_heal/ui/admin/pages/vignette_dissection/admin_vd_ui.dart';
import 'package:man_of_heal/ui/components/black_rounded_container.dart';
import 'package:man_of_heal/ui/components/custom_container.dart';
import 'package:man_of_heal/ui/components/custom_header_row.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class QuizViewUI extends StatelessWidget {
  final QuizQuestion? question;
  final int? pageIndex;

  // QuizViewUI(this.question, this.pageIndex);

  const QuizViewUI({Key? key, this.question, this.pageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    adminVdController.pageController = PageController(initialPage: pageIndex!);

    return Scaffold(
      backgroundColor: AppThemes.BG_COLOR,
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// Black rounded container
          Positioned(
            top: 0,
            height: 225,
            left: 0,
            right: 0,
            child: BlackRoundedContainer(),
          ),

          /// top Question body and options
          Positioned(
            top: 0,
            left: 10,
            right: 10,
            child: Column(
              children: [
                FormVerticalSpace(
                  height: 40,
                ),

                /// Header Row title, back icon, and profile icon
                CustomHeaderRow(title: "Quiz View", hasProfileIcon: true),

                /// Options list .. PageView
                Container(
                  height: AppConstant.getScreenHeight(context) * 0.65,
                  child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: adminVdController.pageController,
                    onPageChanged: adminVdController.updatePageNumber,
                    itemCount: adminVdController.quizQuestionsList.length,
                    itemBuilder: (context, index) {
                      //int jumpToIndex = adminVdController.pageNumber.value;
                      QuizQuestion quizQuestion =
                          adminVdController.quizQuestionsList[index];
                      //vdController.setCardQuestion(quizQuestion.question!);
                      print('Correct Index before: $pageIndex');
                      return pageViewQuestionBody(context, quizQuestion, index);
                    },
                  ),
                ),

                FormVerticalSpace(),

                /// next and previous icons
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: adminVdController.isLastPage.isFalse
                        ? btnNextPrevious()
                        : btnReviewSubmit(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pageViewQuestionBody(context, QuizQuestion question, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Question number and question
          CustomContainer(
            /*width: constraints.maxWidth * 0.9,
                height: constraints.maxWidth * 0.42,*/
            width: AppConstant.getScreenWidth(context) * 0.9,
            height: 150,
            margin: EdgeInsets.only(
              top: 70,
            ),
            hasOuterShadow: true,
            child: Container(
              child: Column(
                children: [
                  //Question numbering
                  Text("Question ${index + 1}",
                      style: AppThemes.buttonFont
                          .copyWith(color: AppThemes.DEEP_ORANGE)),
                  FormVerticalSpace(height: 10),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Text(
                      "${question.question!}",
                      style: AppThemes.normalBlack45Font,
                    ),
                  ),
                ],
              ),
            ),
          ),
          FormVerticalSpace(
            height: 10,
          ),

          ...List.generate(
            question.options!.length,
            (i) => OptionsUI(
              question.options![i],
              i,
              question.correctAnswer,
            ),
          ),
          //FormVerticalSpace(height: 100,),
        ],
      ),
    );
  }

  Widget btnNextPrevious() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ///previous
        RotatedBox(
          quarterTurns: 2,
          child: IconButton(
            onPressed: () {
              adminVdController.pageController.previousPage(
                  duration: Duration(milliseconds: 600), curve: Curves.easeOut);
            },
            icon: Icon(
              Icons.play_arrow,
              color: Colors.black38,
            ),
          ),
        ),

        ///Next
        IconButton(
            onPressed: () {
              if (adminVdController.pageNumber.value !=
                  adminVdController.quizQuestionsList.length) {
                adminVdController.pageController.nextPage(
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeIn);
              } else {}
            },
            icon: Icon(
              Icons.play_arrow,
              color: Colors.black38,
            )),
      ],
    );
  }

  Widget btnReviewSubmit() {
    final QuizModel quizModel = Get.find();
    return Row(
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
              Get.off(() => AdminVignetteDissectionUI());
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
            onPressed: () {
              if (!quizModel.isBlank!)
                adminVdController.updateQuiz(quizModel);
              else
                print('quiz model is blank');
            },
          ),
        ),
      ],
    );
  }
}

class OptionsUI extends StatelessWidget {
  final String? text;
  final int? index;
  final int? correctAnswer;

  //final VoidCallback? press;

  OptionsUI(this.text, this.index, this.correctAnswer);

  final optionNumber = ['a', 'b', 'c', 'd'];

  @override
  Widget build(BuildContext context) {
    Color rightColor = AppThemes.rightAnswerColor;
    Color wrongColor = AppThemes.DEEP_ORANGE;
    Color defaultColor = AppThemes.DEEP_ORANGE.withOpacity(0.3);

    print('Correct Answer: $correctAnswer');
    print('Correct Answer index: $index');
    Color getRightAnswerColor() {
      if (index == correctAnswer) {
        return rightColor;
      }
      return defaultColor;
    }

    IconData getRightAnswerIcon() {
      return getRightAnswerColor() == wrongColor ? Icons.close : Icons.done;
    }

    return InkWell(
      //onTap: press,
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
