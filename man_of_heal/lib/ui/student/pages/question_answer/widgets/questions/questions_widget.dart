import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/controllers/qa_controller.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/ui/student/pages/question_answer/widgets/questions/single_question.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class QuestionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    debugPrint("Questions: length BuildFun${qaController.questionsList.length}");
    return Obx(
      () => qaController.questionsList.length > 0
          ? ListView.builder(
              itemCount:qaController.questionsList.length,
              itemBuilder: (context, index) {
                QuestionModel questionModel = qaController.questionsList[index];
                return SingleQAWidget(questionModel, index);
              })
          : Center(
              child: Text(
                "You haven't ask any question yet?",
                style: AppThemes.headerItemTitle,
              ),
            ),
    );
  }
}
