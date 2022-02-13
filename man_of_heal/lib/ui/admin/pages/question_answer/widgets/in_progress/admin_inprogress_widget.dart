import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/ui/admin/pages/question_answer/widgets/header_widget.dart';
import 'package:man_of_heal/ui/admin/pages/question_answer/widgets/in_progress/inprogress_details_widget.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class AdminInProgressQuestions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var questionList = [];
    for (QuestionModel qm in qaController.allQAList) {
      if (qm.answerMap == null) {
        questionList.add(qm);
      }
    }
    return Container(
      child: ListView.builder(
          itemCount: questionList.length,
          itemBuilder: (context, index) {
            QuestionModel questionModel = questionList[index];

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
    TextTheme _textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        Get.to(InProgressQuestionDetails(questionModel));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppThemes.DEEP_ORANGE.withOpacity(0.26),
              blurRadius: 4,
              spreadRadius: 2,
              offset: Offset(2, 3),
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
                  style: _textTheme.bodyText1!
                      .copyWith(color: Colors.black45, fontSize: 15),
                ),
              ),
              //footer or bottom
              _footerWidget(_textTheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _footerWidget(TextTheme textTheme) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/icons/estimated_time_icon.png",
            width: 13,
          ),
          SizedBox(
            width: 5,
          ),
          RichText(
            text: TextSpan(
                text: "Remaining Time\n",
                children: [
                  TextSpan(
                      text: "23 hrs",
                      style: textTheme.bodyText2!
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w800))
                ],
                style: textTheme.bodyText2!
                    .copyWith(fontSize: 10, fontWeight: FontWeight.w800)),
          )
        ],
      ),
    );
  }
}
