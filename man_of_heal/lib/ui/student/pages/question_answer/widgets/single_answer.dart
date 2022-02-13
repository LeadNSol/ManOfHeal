import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/student/pages/question_answer/widgets/single_answer_details.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class SingleAnswerWidget extends StatelessWidget {
  final QuestionModel? questionModel;

  SingleAnswerWidget(this.questionModel);

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        Get.to(AnswerDetails(questionModel));
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
            ]),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question',
                    style: _textTheme.headline6!.copyWith(fontSize: 17),
                  ),
                  _headerWidget(),
                ],
              ),

              Container(
                width: 245,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                child: Text(
                  '${questionModel!.question}',
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: _textTheme.bodyText2!
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
                  '${questionModel!.answerMap!.answer}',
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


              _footerWidget(_textTheme),
            ],
          ),
        ),
      ),
    );
  }

  _headerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              "assets/icons/fav_icon.svg",
              color: AppThemes.DEEP_ORANGE,
              width: 16,
            )),
        SizedBox(
          width: 18,
        ),
        InkWell(
          onTap: () {
            questionModel!.isDeleted = true;
            qaController.deleteQuestionById(questionModel);
          },
          child: Image.asset(
            "assets/icons/copy_icon.png",
            width: 15,
          ),
        ),
      ],
    );
  }

  _footerWidget(TextTheme _textTheme) {
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
          style: _textTheme.bodyText2!.copyWith(
              color: Colors.green, fontWeight: FontWeight.w700, fontSize: 11),
        ),
      ],
    );
  }
}
