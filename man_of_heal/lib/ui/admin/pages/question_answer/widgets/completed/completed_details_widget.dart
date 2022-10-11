import 'package:flutter/material.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/ui/student/pages/question_answer/widgets/answers/single_answer_details.dart';

class CompletedQuestionDetails extends StatelessWidget {
 final QuestionModel questionModel;
 CompletedQuestionDetails(this.questionModel);
  @override
  Widget build(BuildContext context) {
    return AnswerDetails(questionModel);
  }
}
