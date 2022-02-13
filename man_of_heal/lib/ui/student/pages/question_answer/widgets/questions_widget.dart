import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/ui/student/pages/question_answer/widgets/single_question.dart';

class QuestionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('QALength  ${qaController.qaList.length}');

    var questionsList = [].obs;
    for (QuestionModel q in qaController.qaList) {
      if (q.answerMap == null) {
        questionsList.add(q);
      }
    }
    return Container(
      child: Obx(
        () => ListView.builder(
            itemCount: questionsList.length,
            itemBuilder: (context, index) {
              QuestionModel questionModel = questionsList[index];
              //if (questionModel.answerMap == null)
              //print('QuestionModel: $questionModel');
              return SingleQAWidget(questionModel, index);
            }),
      ),
    );
  }
}
