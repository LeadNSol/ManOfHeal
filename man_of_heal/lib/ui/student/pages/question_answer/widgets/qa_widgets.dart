import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/ui/student/pages/question_answer/widgets/single_answer.dart';

class QAWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('QALength 1 ${qaController.qaList.length}');
    var answerList = [].obs;
    for (QuestionModel q in qaController.qaList) {
      if (q.answerMap != null) {
        answerList.add(q);
      }
    }
    print('QALength Answer: ${qaController.qaList.length}');

    return Container(
      child: Obx(
        () => ListView.builder(
            itemCount: answerList.length, //qaController.answerList.length,
            itemBuilder: (context, index) {
              //QuestionModel questionModel = qaController.answerList[index];
              QuestionModel questionModel = answerList[index];
              return SingleAnswerWidget(questionModel);
            }),
      ),
    );
  }
}
