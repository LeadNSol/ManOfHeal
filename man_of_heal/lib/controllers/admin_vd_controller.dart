import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/notifications/enum_notification.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class AdminVdController extends GetxController {
  //static AdminVdController instance = Get.find();

  final NotificationController? notificationController;
  final AuthController? authController;

  AdminVdController({this.notificationController, this.authController});



  TextEditingController quizQuestionController = new TextEditingController();
  TextEditingController optionsController = new TextEditingController();
  TextEditingController quizTitleController = new TextEditingController();
  TextEditingController quizDescriptionController = new TextEditingController();

  var quizList = <QuizModel>[].obs;

  var optionList = <String>[].obs;

  var quizQuestionsList = <QuizQuestion>[].obs;

  var option = AppConstant.CHOOSE_OPTION.obs;

  var correctIndex = 0.obs;

  var pageNumber = 0.obs;
  var isLastPage = false.obs;
  late PageController pageController;

  // = PageController();

  void updatePageNumber(int value) {
    pageNumber.value = value;
    if (quizQuestionsList.length.isEqual(value + 1)) {
      isLastPage.value = true;
    } else
      isLastPage.value = false;
  }

  void setCorrectIndex(newValue) {
    correctIndex.value = newValue;
  }

  void setOption(value) {
    option.value = value;
  }

  var duration = 10.obs;
  var durationsList = [10, 15, 20, 25, 30, 35, 40];

  void setDuration(value) {
    duration.value = value;
  }

  @override
  void onReady() {
    super.onReady();
    quizList.bindStream(getQuiz());

    //pageController = PageController(initialPage: pageNumber.value);
  }

  bindQuizQuestionList(QuizModel? quizModel) {
    quizQuestionsList.bindStream(getQuizQuestions(quizModel!));
  }

  initDropDown() {
    optionList.isEmpty
        ? option.value = AppConstant.CHOOSE_OPTION
        : option.value = optionList[0];
  }

  void addOptions() {
    optionList.add(optionsController.text);
  }

  void nextQuestion(int index) {
    if (index != quizQuestionsList.length) {
      pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);
    }
  }

  void previousQuestion(int index) {
    if (index != quizQuestionsList.length) {
      pageController.previousPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);
    }
  }

  createQuiz() async {
    String uid = firebaseFirestore.collection(QUIZ_COLLECTION).doc().id;
    QuizModel quizModel = QuizModel(
      questionList: null,
      createdDate: Timestamp.now(),
      quizTitle: quizTitleController.text,
      duration: duration.value,
      quizDescription: quizDescriptionController.text,
      qmID: uid,
      isActive: false,
    );

    await firebaseFirestore
        .collection(QUIZ_COLLECTION)
        .doc(uid)
        .set(quizModel.toJson())
        .then((value) => {
              clearControllers(),
            });
  }

  clearControllers() {
    quizDescriptionController.clear();
    quizTitleController.clear();

    //quizQuestionController.clear();
    optionsController.clear();

    //optionList.clear();
  }

  Stream<List<QuizModel>> getQuiz() {
    quizList.clear();
    return firebaseFirestore.collection(QUIZ_COLLECTION).snapshots().map(
        (query) => query.docs
            .map((items) => QuizModel.fromMap(items.data()))
            .toList());
  }

  updateQuiz(QuizModel quizModel) async {
    quizList.forEach((element) {
      if (element.isActive!) {
        firebaseFirestore
            .collection(QUIZ_COLLECTION)
            .doc(element.qmID)
            .set({QuizModel.IS_ACTIVE: false}, SetOptions(merge: true));
      }
    });

    await firebaseFirestore
        .collection(QUIZ_COLLECTION)
        .doc(quizModel.qmID)
        .set({QuizModel.IS_ACTIVE: true}, SetOptions(merge: true))
        .whenComplete(() => {
              AppConstant.displaySuccessSnackBar(
                  "Submitted!", "Quiz is successfully Submitted"),
              sendNotificationToStudent(quizModel),
            })
        .onError((error, stackTrace) =>
            AppConstant.displaySnackBar("Submission Error", error));
  }

  void sendNotificationToStudent(QuizModel model) async {
    UserModel sender = authController!.userModel!;
    print(
        "Notifications: Sender name: ${sender.name}, Token: ${sender.userToken}");

    NotificationModel model = NotificationModel(
        senderName: sender.name,
        //receiverToken: value.userToken,
        title: "Quiz Updates",
        body: "A new Quiz is Active now!",
        type: NotificationEnum.quiz.name,
        isTopicBased: true,
        isRead: false,
        receiverToken: "Quiz"
        //receiverId: questionModel.studentId,
        );
    notificationController?.sendPushNotification(model);
    //notificationController.addNotificationsToDB(model);
  }

  createQuestion(QuizModel quizModel) async {
    String _uuid =
        firebaseFirestore.collection(QUIZ_QUESTION_COLLECTION).doc().id;
    QuizQuestion question = QuizQuestion(
      qqId: _uuid,
      question: quizQuestionController.text,
      options: optionList.toList(),
      correctAnswer: correctIndex.value,
    );

    await firebaseFirestore
        .collection(QUIZ_COLLECTION)
        .doc(quizModel.qmID)
        .collection(QUIZ_QUESTION_COLLECTION)
        .doc(_uuid)
        .set(question.toJson())
        .then((value) => {
              quizQuestionController.clear(),
              optionsController.clear(),
              optionList.clear(),
              print('Quiz question added'),
              duration.value = 10,
            });
  }

  Stream<List<QuizQuestion>> getQuizQuestions(QuizModel? quizModel) {
    return firebaseFirestore
        .collection(QUIZ_COLLECTION)
        .doc(quizModel!.qmID!)
        .collection(QUIZ_QUESTION_COLLECTION)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => QuizQuestion.fromMap(e.data())).toList());
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    //pageController.dispose();
    optionList.clear();
  }
}
