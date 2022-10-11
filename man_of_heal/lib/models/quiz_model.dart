import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModel {
  static const QM_ID = "qmID";
  static const QUIZ_TITLE = "quizTitle";
  static const QUIZ_DESCRIPTION = "quizDescription";
  static const CREATED_DATE = "createdDate";
  static const IS_ACTIVE = "isActive";
  static const QUESTIONS_LIST = "questionsList";
  static const DURATION = "duration";

  String? qmID;
  String? quizTitle;
  String? quizDescription;
  Timestamp? createdDate;
  bool? isActive;
  int? duration;
  List<QuizQuestion>? questionList;

  QuizModel(
      {this.qmID,
      this.quizTitle,
      this.quizDescription = '',
      this.createdDate,
      this.duration,
      this.isActive,
      this.questionList});

  factory QuizModel.fromDoc(data) {
    print('Student User: before $data');

    data!.forEach((element) {
      Map<String, dynamic> map = element.data();
      return QuizModel.fromMap(map);
    });
    return QuizModel();
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
        qmID: map[QM_ID],
        quizTitle: map[QUIZ_TITLE],
        quizDescription: map[QUIZ_DESCRIPTION] ?? '',
        createdDate: map[CREATED_DATE] ?? null,
        isActive: map[IS_ACTIVE] ?? false,
        duration: map[DURATION] ?? 10,
        questionList: map[QUESTIONS_LIST] ?? null);
  }

  Map<String, dynamic> toJson() => {
        QM_ID: this.qmID,
        QUIZ_TITLE: this.quizTitle,
        QUIZ_DESCRIPTION: this.quizDescription,
        CREATED_DATE: this.createdDate,
        IS_ACTIVE: this.isActive,
        DURATION: this.duration,
        QUESTIONS_LIST: this.questionList
      };
}

class QuizQuestion {
  static const QQ_ID = "qqId";
  static const CORRECT_ANSWER = "correctAnswer";
  static const OPTIONS = "options";
  static const QUESTION = "question";

  static const WRONG_SCORE = "wrongScore";
  static const CORRECT_SCORE = "correctScore";

  String? qqId;
  int? correctAnswer;
  List<String>? options;
  String? question;

  int? wrongScore;
  int? correctScore;

  QuizQuestion(
      {this.qqId,
      this.correctAnswer,
      this.options,
      this.question,
      this.correctScore = 10,
      this.wrongScore = 2});

  factory QuizQuestion.fromMap(Map<String, dynamic> map) {
    return QuizQuestion(
      qqId: map[QQ_ID],
      correctAnswer: map[CORRECT_ANSWER] ?? 0,
      options: List.from(map[OPTIONS]),
      question: map[QUESTION],
      correctScore: map[CORRECT_SCORE] ?? 10,
      wrongScore: map[WRONG_SCORE] ?? 2,
    );
  }

  Map<String, dynamic> toJson() => {
        QQ_ID: this.qqId,
        QUESTION: this.question,
        OPTIONS: this.options,
        CORRECT_ANSWER: this.correctAnswer,
        CORRECT_SCORE: this.correctScore,
        WRONG_SCORE: this.wrongScore,
      };
}

const List sample_data = [
  {
    "qqId": 6,
    "question": "External ear cartilage is___________________?",
    "options": ['Hyaline', 'Elastic', 'Fibrous', 'All of the above'],
    "correctAnswer": 1,
    "duration": 110,
    "wrongScore": 2,
    "correctScore": 10
  },
];
