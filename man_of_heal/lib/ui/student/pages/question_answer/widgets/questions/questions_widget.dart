import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/ui/components/not_found_data_widget.dart';
import 'package:man_of_heal/ui/student/pages/question_answer/widgets/questions/single_question.dart';

class QuestionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => qaController.questionsList.isNotEmpty
          ? _buildListView(qaController.questionsList)
          : NoDataFound(
              text: "You haven't ask any question yet?",
            ),
    );
  }

  _buildListView(List<QuestionModel> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        QuestionModel questionModel = list[index];
        return SingleQAWidget(questionModel, index);
      },
    );
  }
}
