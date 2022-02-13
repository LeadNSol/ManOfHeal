import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/ui/admin/pages/question_answer/widgets/completed/completed_details_widget.dart';
import 'package:man_of_heal/ui/admin/pages/question_answer/widgets/header_widget.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class AdminCompletedQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var answerList = [];
    for (QuestionModel q in qaController.allQAList) {
      if (q.answerMap != null) {
        answerList.add(q);
      }
    }
    return Container(
      child: ListView.builder(
          itemCount: answerList.length,
          itemBuilder: (context, index) {
            QuestionModel questionModel = answerList[index];
            return SingleCompletedQuestionUI(questionModel);
          }),
    );
  }
}

class SingleCompletedQuestionUI extends StatelessWidget {
  final QuestionModel questionModel;

  SingleCompletedQuestionUI(this.questionModel);

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        Get.to(CompletedQuestionDetails(questionModel));
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
              FormVerticalSpace(),
              Text(
                'Answer',
                style: _textTheme.headline6!.copyWith(fontSize: 17),
              ),
              Container(
                width: 245,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                child: Text(
                  '${questionModel.answerMap!.answer}',
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: _textTheme.bodyText1!
                      .copyWith(color: Colors.black45, fontSize: 15),
                ),
              ),
              FormVerticalSpace(
                height: 10,
              ),
              //footer or bottom
              _footerWidget(_textTheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //IconButton(onPressed: () {}, icon: Icon(Icons.edit_rounded)),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Image.network(
                "https://cdn-icons-png.flaticon.com/128/3011/3011270.png"),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text('${authController.userModel.value!.name}'),
      ],
    );
  }

  Widget _footerWidget(TextTheme textTheme) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
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
            style: textTheme.bodyText2!.copyWith(
                color: Colors.green, fontWeight: FontWeight.w700, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
