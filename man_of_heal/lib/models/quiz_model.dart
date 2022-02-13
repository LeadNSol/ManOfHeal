import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModel {
  static const QM_ID = "qmID";
  static const QUIZ_TITLE = "quizTitle";
  static const CREATED_DATE = "createdDate";
  static const IS_ATTEMPTED = "isAttempted";
  static const QUESTIONS_LIST = "questionsList";

  String? qmID;
  String? quizTitle;
  Timestamp? createdDate;
  bool? isAttempted;
  List<QuizQuestion>? questionList;

  QuizModel(
      {this.qmID,
      this.quizTitle,
      this.createdDate,
      this.isAttempted,
      this.questionList});

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
        qmID: map[QM_ID],
        quizTitle: map[QUIZ_TITLE],
        createdDate: map[CREATED_DATE] ?? null,
        isAttempted: map[IS_ATTEMPTED] ?? false,
        questionList: map[QUESTIONS_LIST] ?? null);
  }

  Map<String, dynamic> toJson() => {
        QM_ID: this.qmID,
        QUIZ_TITLE: this.quizTitle,
        CREATED_DATE: this.createdDate,
        IS_ATTEMPTED: this.isAttempted,
        QUESTIONS_LIST: this.questionList
      };
}

class QuizQuestion {
  String? qqId;
  int? correctAnswer;
  List<String>? options;
  String? question;
  int? duration;
  int? wrongScore;
  int? correctScore;

  QuizQuestion(
      {this.qqId,
      this.correctAnswer,
      this.options,
      this.question,
      this.duration});
}

const List sample_data = [
  {
    "qqId": 1,
    "question":
        "Thalamus is the largest relay center for all sensory inputs_________________?",
    "options": ['Touch', 'Olfaction', 'Hearing', 'Pressure'],
    "correctAnswer": 1,
    "duration": 10,
    "wrongScore": 2,
    "correctScore": 10
  },
  {
    "qqId": 2,
    "question": "The total volume of CSF is_______________?",
    "options": ['50 ml', '100 ml', '150 ml', '275 ml'],
    "correctAnswer": 2,
    "duration": 12,
    "wrongScore": 2,
    "correctScore": 10
  },
  {
    "qqId": 3,
    "question":
        "In grey matter of cerebellum are the following nuclei_____________?",
    "options": [
      'Nucleus Globosus',
      'Nucleus Emboliform',
      'Nucleus dentatus',
      'All of the above'
    ],
    "correctAnswer": 3,
    "duration": 13,
    "wrongScore": 2,
    "correctScore": 10
  },
  {
    "qqId": 4,
    "question":
        "In an adult, the spinal cord end at the level of_______________?",
    "options": ['Lower border of L1', 'L2', 'L3', 'L4'],
    "correctAnswer": 0,
    "duration": 110,
    "wrongScore": 2,
    "correctScore": 10
  },
  {
    "qqId": 5,
    "question": "Unpaired structure in the brain_______________?",
    "options": [
      'Middle cerebral artery',
      'Vertebral artery',
      'Basilar artery',
      'Anterior cerebral artery'
    ],
    "correctAnswer": 2,
    "duration": 110,
    "wrongScore": 2,
    "correctScore": 10
  },
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
