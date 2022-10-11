import 'package:flutter/material.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/quiz_review_model.dart';
import 'package:man_of_heal/ui/components/black_rounded_container.dart';
import 'package:man_of_heal/ui/components/custom_container.dart';
import 'package:man_of_heal/ui/components/custom_header_row.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class ReviewUI extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

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
                CustomHeaderRow(title: "Quiz Review", hasProfileIcon: true),

                /// Options list .. PageView
                Container(
                  height: AppConstant.getScreenHeight(context) * 0.65,
                  child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: vdController.pageReviewQuizController,
                    //onPageChanged: adminVdController.updatePageNumber,
                    itemCount: vdController.quizReviewList.length,
                    itemBuilder: (context, index) {
                      //int jumpToIndex = adminVdController.pageNumber.value;
                      QuizReviewModel reviewModel =
                          vdController.quizReviewList[index];

                      return pageViewQuestionBody(context, reviewModel, index);
                    },
                  ),
                ),

                FormVerticalSpace(),

                /// next and previous icons
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: btnNextPrevious()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pageViewQuestionBody(context, QuizReviewModel reviewModel, index) {
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
                      "${reviewModel.quizQuestion!.question!}",
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
            reviewModel.quizQuestion!.options!.length,
            (i) => OptionsUI(
              reviewModel.quizQuestion!.options![i],
              i,
              reviewModel
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
              vdController.pageReviewQuizController.previousPage(
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

                vdController.pageReviewQuizController.nextPage(
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeIn);

            },
            icon: Icon(
              Icons.play_arrow,
              color: Colors.black38,
            )),
      ],
    );
  }
}

class OptionsUI extends StatelessWidget {
  final String? text;
  final int? index;
  final QuizReviewModel? reviewModel;

  //final VoidCallback? press;

  OptionsUI(this.text, this.index, this.reviewModel);

  final optionNumber = ['a', 'b', 'c', 'd'];

  @override
  Widget build(BuildContext context) {
    Color rightColor = AppThemes.rightAnswerColor;
    Color wrongColor = AppThemes.DEEP_ORANGE;
    Color defaultColor = AppThemes.DEEP_ORANGE.withOpacity(0.3);

    Color getRightAnswerColor() {
      if (index == reviewModel!.correctIndex!) {
        return rightColor;
      }
      if(index ==  reviewModel!.selectedIndex){
        return wrongColor;
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
