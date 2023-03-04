import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';

class QuestionWidget extends GetView<QAController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.questionsList.isNotEmpty
          ? _buildListView(controller.questionsList)
          : NoDataFound(text: "You haven't ask any question yet?"),
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
