import 'package:cloud_firestore/cloud_firestore.dart';

class StdAnswerModel {
  static const UID = "uId",
      quesID = "questionId",
      checkBY = "checkBy",
      answerBY = "answerBy",
      answerDateTime = "answerDate",
      checkingDateTime = "checkingDate",
      answerText = "answer",
      ansRating = "answerRating";

  String? uId, questionId, checkBy, answerBy, answer, answerRating;
  Timestamp? checkingDate, answerDate;

  StdAnswerModel(
      {this.uId,
      this.questionId,
      this.checkBy,
      this.answerBy,
      this.checkingDate,
      this.answerDate,
      this.answer,
      this.answerRating});

  factory StdAnswerModel.fromMap(Map<String, dynamic> map) {
    return StdAnswerModel(
        uId: map[UID],
        questionId: map[quesID],
        checkBy: map[checkBY],
        answerBy: map[answerBY],
        answer: map[answerText],
        answerDate: map[answerDateTime],
        answerRating: map[ansRating],
        checkingDate: map[checkingDateTime]);
  }

  Map<String, dynamic> toMap() => {
        UID: uId,
        quesID: questionId,
        checkBY: checkBy,
        answerBY: answerBy,
        answerText: answer,
        answerDateTime: answerDate,
        checkingDateTime: checkingDate,
        ansRating: answerRating,
      };
}

class StudentModel {
  static const UID = "studentId", smRatings = "Ratings";

  String? studentId, ratings;

  StudentModel({this.studentId, this.ratings});

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(studentId: map[UID], ratings: map[smRatings]);
  }

  Map<String, dynamic> toMap() => {
        UID: studentId,
        smRatings: ratings,
      };
}
