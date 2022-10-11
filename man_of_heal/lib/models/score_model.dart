import 'package:cloud_firestore/cloud_firestore.dart';

class ScoreModel {
  static const SM_ID = "smID";
  static const USERID = "userId";
  static const USERNAME = "userName";
  static const USER_PHOTO_URL = "user_photo_url";
  static const QUIZ_ID = "quizId";
  static const CORRECT = "correct";
  static const WRONG = "wrong";
  static const SCORE = "score";
  static const NO_OF_QUESTIONS = "noOfQuestions";
  static const ATTEMPTED_DATE = "attemptedDate";

  String? smID, userId, quizId;
  int? correct, wrong, score, noOfQuestions;
  Timestamp? attemptedDate;
  String? photoUrl;

  ScoreModel(
      { //this.smID,
      this.userId,
      /* this.quizId,
      this.noOfQuestions = 0,
      this.correct = 0,
      this.wrong = 0,*/
      this.photoUrl,
      this.score = 0,
      this.attemptedDate});

  factory ScoreModel.fromMap(Map<String, dynamic> map) {

    return ScoreModel(
      /*smID: map[SM_ID],
      noOfQuestions: map[NO_OF_QUESTIONS],
       quizId: map[QUIZ_ID],
      correct: map[CORRECT],
      wrong: map[WRONG],*/
      //photoUrl: map[USER_PHOTO_URL],
      userId: map[USERID],
      score: map[SCORE],
      attemptedDate: map[ATTEMPTED_DATE] ?? null,
    );
  }

  Map<String, dynamic> toJson() => {
        /*  SM_ID: this.smID,
       NO_OF_QUESTIONS: this.noOfQuestions,
       QUIZ_ID: this.quizId,
        CORRECT: this.correct,
        WRONG: this.wrong,*/
        SCORE: this.score,
        USERID: this.userId,
        ATTEMPTED_DATE: this.attemptedDate
      };
}
