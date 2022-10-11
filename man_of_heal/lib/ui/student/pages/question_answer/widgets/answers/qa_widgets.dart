import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/ui/student/pages/question_answer/widgets/answers/single_answer.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class QAWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => qaController.answerList.length > 0
          ? qaController.searchList.length > 0 ||
                  qaController.searchController.text.isNotEmpty
              ? ListView.builder(
                  itemCount: qaController.searchList.length,
                  //qaController.answerList.length,
                  itemBuilder: (context, index) {
                    //QuestionModel questionModel = qaController.answerList[index];
                    QuestionModel questionModel =
                        qaController.searchList[index];
                    return SingleAnswerWidget(questionModel);
                  })
              : ListView.builder(
                  itemCount: qaController.answerList.length,
                  //qaController.answerList.length,
                  itemBuilder: (context, index) {
                    //QuestionModel questionModel = qaController.answerList[index];
                    QuestionModel questionModel =
                        qaController.answerList[index];
                    return SingleAnswerWidget(questionModel);
                  })
          : Center(
              child: Text(
                "You haven't any answers of the Questions",
                style: AppThemes.headerItemTitle,
              ),
            ),
    );
  }
}
