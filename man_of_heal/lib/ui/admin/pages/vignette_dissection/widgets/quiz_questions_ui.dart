import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/quiz_model.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class QuizQuestionsUI extends GetView<AdminVdController> {
  final QuizModel? quizModel;

  const QuizQuestionsUI({Key? key, this.quizModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.bindQuizQuestionList(quizModel);
    return Scaffold(
      backgroundColor: AppThemes.blackPearl,
      body: bodyContent(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddQuestionUI(quizModel!));
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

  Widget bodyContent(context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        /// pink background
        Positioned(
          top: AppConstant.getScreenHeight(context) * 0.25,
          left: 0,
          child: Container(
            width: AppConstant.getScreenWidth(context),
            height: AppConstant.getScreenHeight(context),
            decoration: BoxDecoration(
              color: AppThemes.BG_COLOR,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
            ),
          ),
        ),

        Positioned(
          child: Column(
            children: [
              FormVerticalSpace(
                height: 40,
              ),

              ///Header Row
              CustomHeaderRow(
                title: "Quiz Questions",
                hasProfileIcon: true,
              ),
              FormVerticalSpace(
                height: AppConstant.getScreenHeight(context) * 0.18,
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.quizQuestionsList.length,
                      itemBuilder: (context, index) {
                        QuizQuestion question =
                            controller.quizQuestionsList[index];
                        //print('quizQuestions: ${controller.quizQuestionsList.length}');
                        return singleQuestionItem(context, question, index);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget singleQuestionItem(context, question, index) {
    return InkWell(
      onTap: () {
        controller.updatePageNumber(index);
        Get.to(() => QuizViewUI(question: question, pageIndex: index));
      },
      child: Container(
        height: 90,
        margin: const EdgeInsets.only(left: 17, right: 17, top: 0, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppThemes.DEEP_ORANGE.withOpacity(0.26),
              blurRadius: 10.78,
              offset: Offset(0, 0),
              // Shadow position
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Question ${index + 1}',
                  style: AppThemes.headerItemTitle,
                ),
              ),
              FormVerticalSpace(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${question.question}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppThemes.normalBlack45Font,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
