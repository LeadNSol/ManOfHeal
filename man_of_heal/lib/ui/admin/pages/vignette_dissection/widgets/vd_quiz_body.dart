import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/quiz_model.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class VDQuizBody extends StatelessWidget {
  VDQuizBody({Key? key}) : super(key: key);

  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: adminVdController.quizList.length,
      itemBuilder: (context, index) {
        QuizModel quizModel = adminVdController.quizList[index];
        return SingleQuizItem(quizModel);
      },
    );
  }
}

class SingleQuizItem extends StatelessWidget {
  //const SingleQuizItem({Key? key}) : super(key: key);
  final QuizModel quizModel;

  SingleQuizItem(this.quizModel);

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        // Get.to(InProgressQuestionDetails(questionModel));
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
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            title: Text(
              '${quizModel.quizTitle!}',
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: _textTheme.headline6!
                  .copyWith(color: Colors.black, fontSize: 15),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Created at: ${AppConstant.convertToFormattedDataTime("dd MMM yy, hh:mm", quizModel.createdDate!)}',
                  textAlign: TextAlign.start,
                  style: _textTheme.bodyText1!
                      .copyWith(color: Colors.black45, fontSize: 13),
                ),
                Text(
                  'Total Questions: ${quizModel.questionList == null ? 0 : quizModel.questionList!.length}',
                  textAlign: TextAlign.start,
                  style: _textTheme.bodyText1!
                      .copyWith(color: Colors.black45, fontSize: 13),
                ),

              ],

            ),
            trailing: InkWell(child: Icon(Icons.note_add,color: AppThemes.DEEP_ORANGE)),
          ),
        ),
      ),
    );
  }
}
