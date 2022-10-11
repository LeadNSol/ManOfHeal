import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  static const ID = "qID";
  static const QUESTION = "question";
  static const CATEGORY = "categoryId";
  static const STUDENT_ID = "studentId";
  static const CREATED_DATE = "createdDate";
  static const MODIFIED_DATE = "modifiedDate";
  static const Q_IS_DELETED = "isDeleted";
  static const TO_BE_ANSWERED_IN = "toBeAnsweredIn";
  static const IS_FAVORITE = "isFavorite";
  static const IS_SOMEONE_ANSWER = "isSomeoneAnswering";
  static const ANSWER_MODEL = "answer";

  String? qID;
  String? question;
  String? category;
  String? studentId;
  Timestamp? qCreatedDate;
  Timestamp? qModifiedDate;
  Timestamp? toBeAnsweredIn;
  AnswerModel? answerMap;
  bool? isFav;
  bool? isDeleted;
  bool? isSomeoneAnswering;

  QuestionModel({
    this.qID,
    this.question,
    this.category,
    this.studentId,
    this.qCreatedDate,
    this.qModifiedDate,
    this.toBeAnsweredIn,
    this.isDeleted = false,
    this.isFav = false,
    this.isSomeoneAnswering = false,
    this.answerMap,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> data) {
    return QuestionModel(
        qID: data[ID],
        question: data[QUESTION],
        category: data[CATEGORY],
        studentId: data[STUDENT_ID],
        isDeleted: data[Q_IS_DELETED] ?? false,
        qCreatedDate: data[CREATED_DATE] ?? '',
        qModifiedDate: data[MODIFIED_DATE] ?? '',
        toBeAnsweredIn: data[TO_BE_ANSWERED_IN] ?? '',
        isFav: data[IS_FAVORITE] ?? false,
        isSomeoneAnswering: data[IS_SOMEONE_ANSWER] ?? false,
        answerMap: data[ANSWER_MODEL] != null
            ? AnswerModel.fromMap(data[ANSWER_MODEL])
            : null);

    /*this.qID = data[ID];
    this.question = data[QUESTION];
    this.categoryId = data[CATEGORY_ID];
    this.studentId = data[STUDENT_ID];
    this.qCreatedDate = data[CREATED_DATE];
    this.qModifiedDate = data[MODIFIED_DATE];
    this.answerModel = data[ANSWER_MODEL] ?? null;*/
  }

  Map<String, dynamic> toJson() => {
        ID: this.qID,
        QUESTION: this.question,
        CATEGORY: this.category,
        STUDENT_ID: this.studentId,
        CREATED_DATE: this.qCreatedDate,
        MODIFIED_DATE: this.qModifiedDate,
        Q_IS_DELETED: this.isDeleted,
        TO_BE_ANSWERED_IN: this.toBeAnsweredIn,
        ANSWER_MODEL: this.answerMap,
        IS_FAVORITE: this.isFav,
        IS_SOMEONE_ANSWER: this.isSomeoneAnswering,
      };
}

class AnswerModel {
  static const ANSWER = "answer";
  static const ADMIN_ID = "adminID";
  static const ANS_CREATED_DATE = "ansCreated";
  static const ANS_MODIFIED_DATE = "ansModified";

  String? answer;
  String? adminID;
  Timestamp? createdDate;
  Timestamp? modifiedDate;

  AnswerModel({this.answer, this.adminID, this.createdDate, this.modifiedDate});

  AnswerModel.fromMap(Map<String, dynamic> data) {
    this.answer = data[ANSWER];
    this.adminID = data[ADMIN_ID];
    this.createdDate = data[ANS_CREATED_DATE];
    this.modifiedDate = data[ANS_MODIFIED_DATE];
  }

  Map<String, dynamic> toJson() => {
        ANSWER: answer,
        ADMIN_ID: adminID,
        ANS_CREATED_DATE: createdDate,
        ANS_MODIFIED_DATE: modifiedDate
      };
}

enum QAHeaderChips { QUESTIONS, ANSWERED }
