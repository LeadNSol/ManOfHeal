import 'package:cloud_firestore/cloud_firestore.dart';

class QuizAttemptsModel {
  static const QAM_UID = "qamUId";
  static const STUDENT_ID = "studentId";
  static const QUIZ_ID = "quizId";
  static const ATTEMPT_DATE = "attemptDate";
  static const QUIZ_REVIEW_LIST = "quiz_review_list";
  String? qamUId, studentId, quizId;
  Timestamp? attemptDate;
  //late List<QuizReviewModel>? quizReviewList;

  QuizAttemptsModel(
      {this.qamUId,
      this.studentId,
      this.attemptDate,
      this.quizId});

  /* QuizAttemptsModel.fromDoc(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    docs.map((e) =>
        e.exists ? QuizAttemptsModel.fromMap(e.data()) : QuizAttemptsModel());
  }
*/
  factory QuizAttemptsModel.fromMap(Map<String, dynamic> map) {

    return QuizAttemptsModel(
        qamUId: map[QAM_UID],
        quizId: map[QUIZ_ID],
        studentId: map[STUDENT_ID],
        attemptDate: map[ATTEMPT_DATE],
       // quizReviewList: map[QUIZ_REVIEW_LIST]
    );
  }

  Map<String, dynamic> toMap() => {
        QAM_UID: qamUId,
        STUDENT_ID: studentId,
        QUIZ_ID: quizId,
        ATTEMPT_DATE: attemptDate,
        /*QUIZ_REVIEW_LIST: quizReviewList!
            .map((quizReviewModel) => quizReviewModel.toJson())
            .toList(),*/

      };
}
