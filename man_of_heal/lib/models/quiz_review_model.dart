import 'package:man_of_heal/models/quiz_model.dart';

class QuizReviewModel {
  static const SELECTED_INDEX = "selectedIndex";
  static const CORRECT_INDEX = "correctIndex";
  static const QUIZ_QUESTION = "quizQuestion";
  static const QUIZ_QUESTION_ID = "quizQuestionsId";
  static const CORRECT = "totalCorrect";
  static const WRONG = "totalWrong";
  static const SCORE = "totalScore";
  static const NO_OF_QUESTIONS = "totalNoOfQuestions";

  int? selectedIndex, correctIndex;//, totalCorrect, totalWrong, totalScore, totalNoOfQuestions;
  QuizQuestion? quizQuestion;
  //String? quizQuestionsId;

  QuizReviewModel(
      {/*this.totalCorrect,
      this.totalWrong,
      this.totalScore,
      this.totalNoOfQuestions,*/
        this.correctIndex,
      this.selectedIndex,
      this.quizQuestion});

  Map<String, dynamic> toJson() => {
       /* CORRECT: totalCorrect,
        WRONG: totalWrong,
        SCORE: totalScore,
        NO_OF_QUESTIONS: totalNoOfQuestions,*/
        SELECTED_INDEX: selectedIndex,
        QUIZ_QUESTION: quizQuestion
      };
}
