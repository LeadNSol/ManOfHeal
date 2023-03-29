import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/ui/components/not_found_data_widget.dart';
import 'package:man_of_heal/ui/student/pages/question_answer/widgets/answers/single_answer.dart';

class QAWidget extends GetView<QAController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.searchList.isNotEmpty
          ? _buildListView(controller.searchList)
          : controller.answerList.isNotEmpty
              ? _buildListView(controller.answerList)
              : NoDataFound(
                  text: "No Answers Found",
                ),
    );
  }

  _buildListView(List<QuestionModel> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        QuestionModel questionModel = list[index];
        return SingleAnswerWidget(questionModel);
      },
    );
  }
}
