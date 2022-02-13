import 'package:cloud_firestore/cloud_firestore.dart';

class Subscription {
  static const SUBS_ID = "subs_uId";
  static const PLAN_NAME = "plan_name";
  static const STUDENT_ID = "student_id";
  static const STATUS = "status";
  static const PAYMENT_ID = "payment_id";
  static const NO_OF_ASKED_Q = "noOfAskedQuestion";
  static const QUESTION_QUOTA = "question_quota";
  static const NET_AMOUNT = "net_amount";
  static const IS_UPGRADED = "isUpgraded";
  static const IS_RENEWED = "isRenewed";
  static const EXPIRES_AT = "expires_at";
  static const CREATE_AT = "create_at";
  static const MODIFIED_AT = "modified_at";
  static const NEXT_QUESTION_AT = "nextQuestion_at";
  static const QUESTION_CREATED_AT = "questionCreated_at";

  String? subUID;
  String? planName;
  String? studentId;

  String? paymentId; //stripe payment id
  String? status;
  int? noOfAskedQuestion;
  int? questionQuota;
  double? netAmount;

  bool? isUpgrade = false;
  bool? isRenewed = false;

  Timestamp? expiresAt; // will expired after 1 month from current date
  Timestamp? nextQuestionAt; // next question will be in 72 hours
  Timestamp? questionCreatedAt; // questionCreatedTime
  Timestamp? createAt;
  Timestamp? modifiedAt;

  Subscription(
      {this.subUID,
      this.planName,
      this.studentId,
      this.paymentId,
      this.status,
      this.noOfAskedQuestion,
      this.questionQuota,
      this.netAmount,
      this.isUpgrade,
      this.isRenewed,
      this.expiresAt,
      this.nextQuestionAt,
      this.questionCreatedAt,
      this.createAt,
      this.modifiedAt});

  factory Subscription.fromMap(Map<String, dynamic> data) {
    return Subscription(
        subUID: data[SUBS_ID] ?? null,
        planName: data[PLAN_NAME],
        studentId: data[STUDENT_ID],
        paymentId: data[PAYMENT_ID],
        status: data[STATUS],
        noOfAskedQuestion: data[NO_OF_ASKED_Q],
        questionQuota: data[QUESTION_QUOTA] ?? 0,
        netAmount: data[NET_AMOUNT] ?? 0,
        isRenewed: data[IS_RENEWED] ?? false,
        isUpgrade: data[IS_UPGRADED] ?? false,
        expiresAt: data[EXPIRES_AT] ?? null,
        createAt: data[CREATE_AT] ?? null,
        modifiedAt: data[MODIFIED_AT] ?? null,
        nextQuestionAt: data[NEXT_QUESTION_AT] ?? null,
        questionCreatedAt: data[QUESTION_CREATED_AT] ?? null);
  }

  Map<String, dynamic> toJson() => {
        SUBS_ID: this.subUID ?? null,
        PLAN_NAME: this.planName,
        STUDENT_ID: this.studentId,
        PAYMENT_ID: this.paymentId ?? '',
        STATUS: this.status,
        NO_OF_ASKED_Q: this.noOfAskedQuestion ?? this.questionQuota,
        QUESTION_QUOTA: this.questionQuota,
        NET_AMOUNT: this.netAmount,
        IS_UPGRADED: this.isUpgrade ?? false,
        IS_RENEWED: this.isRenewed ?? false,
        EXPIRES_AT: this.expiresAt,
        CREATE_AT: this.createAt,
        MODIFIED_AT: this.modifiedAt,
        NEXT_QUESTION_AT: this.nextQuestionAt ?? null,
        QUESTION_CREATED_AT: this.questionCreatedAt ?? null
      };
}

enum Status { New, Recycled, Expired, Upgraded, Renewed }
