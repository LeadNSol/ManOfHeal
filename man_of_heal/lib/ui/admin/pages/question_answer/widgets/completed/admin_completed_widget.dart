import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/ui/admin/pages/question_answer/widgets/completed/completed_details_widget.dart';
import 'package:man_of_heal/ui/admin/pages/question_answer/widgets/header_widget.dart';
import 'package:man_of_heal/ui/components/custom_container.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class AdminCompletedQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint("");
    return Obx(
      () => qaController.adminSearchList.isNotEmpty
          ? _buildListView(qaController.adminSearchList)
          : qaController.completedQAList.isNotEmpty
              ? _buildListView(qaController.completedQAList)
              : Center(
                  child: Text(
                    qaController.notFoundListItems.value,
                    style: AppThemes.headerItemTitle,
                  ),
                ),
    );
  }

  _buildListView(List<QuestionModel> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          QuestionModel questionModel = list[index];
          return SingleCompletedQuestionUI(questionModel);
        });
  }
}

class SingleCompletedQuestionUI extends StatelessWidget {
  final QuestionModel questionModel;

  SingleCompletedQuestionUI(this.questionModel);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => CompletedQuestionDetails(questionModel));
      },
      child: CustomContainer(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
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
              FormVerticalSpace(
                height: 10,
              ),
              Text(
                'Answer',
                style: AppThemes.normalBlackFont,
              ),
              Container(
                width: 245,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                child: Text(
                  '${questionModel.answerMap!.answer}',
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: AppThemes.normalBlack45Font,
                ),
              ),
              FormVerticalSpace(
                height: 10,
              ),
              //footer or bottom
              _footerWidget(),
            ],
          ),
        ),
      ),
    );
  }

  _footerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(
          "assets/icons/tick_mark_icon.png",
          width: 10,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          'Answered',
          style: GoogleFonts.poppins(
              color: Colors.green, fontWeight: FontWeight.w700, fontSize: 8),
        ),
      ],
    );
  }
}
