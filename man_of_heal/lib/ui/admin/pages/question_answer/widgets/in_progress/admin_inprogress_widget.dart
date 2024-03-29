import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class AdminInProgressQuestions extends GetView<QAController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
          itemCount: controller.inProgressQList.length,
          itemBuilder: (context, index) {
            QuestionModel questionModel = controller.inProgressQList[index];
            return SingleQuestionUI(questionModel);
          }),
    );
  }
}

class SingleQuestionUI extends StatelessWidget {
  final QuestionModel questionModel;

  SingleQuestionUI(this.questionModel);

  @override
  Widget build(BuildContext context) {
    //TextTheme _textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        Get.to(()=>InProgressQuestionDetails(questionModel));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppThemes.DEEP_ORANGE.withOpacity(0.26),
              offset: Offset(0, 0),
              blurRadius: 10.78,
              // Shadow position
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              HeaderWidget(questionModel),

              Container(
                width: 245,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                child: Text(
                  '${questionModel.question}',
                  maxLines: 2,
                  textAlign: TextAlign.start,
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
