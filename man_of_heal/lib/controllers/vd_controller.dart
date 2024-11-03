import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class VDController extends GetxController {
  var quizID = "".obs;

  PageController pageController = PageController();
  PageController pageReviewQuizController = PageController();
  CountDownController countDownController = CountDownController();

  var duration = 0.obs;

  var leaderboardList = <ScoreModel>[].obs;

  var attemptedQuizModel = QuizAttemptsModel().obs;

  late final AuthController authController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    authController = AppCommons.authController;
  }

  @override
  void onReady() {
    super.onReady();
    initData();
  }

  void initData() {
    getActiveQuiz();
    leaderboardList.bindStream(getLeaderData());
  }

  var quizQuestionsList = <QuizQuestion>[].obs;

  Stream<List<QuizQuestion>> getQuizQuestions(String? quizID) {
    return firebaseFirestore
        .collection(QUIZ_COLLECTION)
        .doc(quizID)
        .collection(QUIZ_QUESTION_COLLECTION)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => QuizQuestion.fromMap(e.data())).toList());
  }

  Future<QuizModel> getActiveQuiz() {
    return firebaseFirestore
        .collection(QUIZ_COLLECTION)
        .where(QuizModel.IS_ACTIVE, isEqualTo: true)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc[QuizModel.IS_ACTIVE]) {
          quizID.value = doc[QuizModel.QM_ID];
          duration.value = doc[QuizModel.DURATION];
          debugPrint("Duration Docs: ${doc[QuizModel.DURATION]}");
          debugPrint("Duration: ${duration.value}");
          quizQuestionsList.bindStream(getQuizQuestions(quizID.value));
        }
      });
      return QuizModel.fromDoc(querySnapshot.docs);
    });
  }

  var hasAlreadyAttemptTheQuiz = false.obs;
  var quizReviewDbList = [].obs;

  Future<void> findUserAttemptedQuiz() async {
    return await firebaseFirestore
        .collection(QUIZ_COLLECTION)
        .doc(quizID.value)
        .collection(QUIZ_ATTEMPTS_COLLECTION)
        .where(QuizAttemptsModel.STUDENT_ID,
            isEqualTo: AppCommons.userModel?.uid!)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc[QuizAttemptsModel.STUDENT_ID] ==
            AppCommons.userModel?.uid!) {
          hasAlreadyAttemptTheQuiz.value = true;
          return;
        } else
          hasAlreadyAttemptTheQuiz.value = false;
      });
    });
  }

  /* Future<List<QuizReviewModel>> fetchQuizReview(QuizAttemptsModel model) {
    for (QuizReviewModel? reviewModel in model.quizReviewList!) {
      firebaseFirestore
          .collection(AdminVdController.QUIZ_COLLECTION)
          .doc(model.quizId!)
          .collection(AdminVdController.QUIZ_QUESTION_COLLECTION)
          .doc(reviewModel!.quizQuestionsId!)
          .get()
          .then((value) => null);
    }
    return [];
  }*/

  Future<ScoreModel> getUserScore() {
    return firebaseFirestore
        .collection(SCORE_BOARD_COLLECTION)
        .doc(AppCommons.userModel!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> map =
            documentSnapshot.data() as Map<String, dynamic>;
        return ScoreModel.fromMap(map);
      }
      return ScoreModel();
    });
  }

  Future<void> postQuizAttempt(QuizAttemptsModel model) async {
    var ref = firebaseFirestore
        .collection(QUIZ_COLLECTION)
        .doc(model.quizId!)
        .collection(QUIZ_ATTEMPTS_COLLECTION);

    model.qamUId = ref.doc().id;
    await ref.doc(model.qamUId).set(model.toMap(), SetOptions(merge: true));
  }

  ///Leader board
  Future<void> createScoreBoard() async {
    // int noOfQuestions = quizQuestionsList.length;
    await getUserScore().then((ScoreModel model) {
      /*  if (model!.score!.isEqual(0)) {
        print('score is less than or equal 0');
      } else {*/

      int score;
      if (model.isBlank!)
        score = (numOfCorrectAns * 10);
      else
        score = model.score! + numOfCorrectAns * 10;

      model = ScoreModel(
          score: score,
          userId: AppCommons.userModel!.uid!,
          attemptedDate: Timestamp.now());

      firebaseFirestore
          .collection(SCORE_BOARD_COLLECTION)
          .doc(AppCommons.userModel!.uid)
          .set(model.toJson(), SetOptions(merge: true))
          .then((value) {
        //TDO: quiz attempt posting

        QuizAttemptsModel model = QuizAttemptsModel(
          attemptDate: Timestamp.now(),
          studentId: AppCommons.userModel!.uid,
          quizId: quizID.value,
        );

        postQuizAttempt(model).then((value) =>
            AppConstant.displaySuccessSnackBar(
                "Success", "Successfully submitted"));
      });
      //}
    });
  }

  String getUserName(id) {
    return authController.usersList.isNotEmpty
        ? authController.usersList
            .firstWhere((element) => element.uid == id)
            .name!
        : "";
  }

  String getPhotoUrl(id) {
    return authController.usersList.isNotEmpty
        ? authController.usersList
            .firstWhere((element) => element.uid == id)
            .photoUrl!
        : "https://cdn-icons-png.flaticon.com/512/3011/3011270.png";
  }

  Stream<List<ScoreModel>> getLeaderData() {
    return firebaseFirestore
        .collection(SCORE_BOARD_COLLECTION)
        .orderBy(ScoreModel.SCORE, descending: true)
        .snapshots()
        .map((event) => event.docs.map((e) {
              return ScoreModel.fromMap(e.data());
            }).toList());
  }

  List<QuizQuestion> get questions => quizQuestionsList;

  var isAnswered = false.obs;

  //bool get isAnswered => this._isAnswered;

  late int _correctAns = 0;

  int get correctAns => this._correctAns;

  int _selectedAns = 0;

  int get selectedAns => this._selectedAns;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;

  RxInt get questionNumber => this._questionNumber;

  var _numOfCorrectAns = 0.obs;

  int get numOfCorrectAns => this._numOfCorrectAns.value;
  List<QuizReviewModel> quizReviewList = [];

  void checkAns(
      QuizQuestion quizQuestion, int selectedIndex, int correctIndex) {
    // because once user press any option then it will run
    isAnswered.value = true;
    print('Correct question: ${quizQuestion.question!}');
    _correctAns = correctIndex;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns.value++;

    print('Correct: $_numOfCorrectAns');
    print('Correct Index: $correctIndex');
    print('Selected Index: $selectedIndex');
    // It will stop the counter
    //animationController.stop();
    //update();

    quizReviewList.add(QuizReviewModel(
        quizQuestion: quizQuestion,
        correctIndex: correctIndex,
        selectedIndex: selectedIndex));

    // Once user select an ans after 3s it will go to the next qn
    Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  var isLastQuestion = false.obs;

  void nextQuestion() {
    if (_questionNumber.value != questions.length) {
      isLastQuestion.value = false;
      isAnswered.value = false;
      pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      // animationController.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      //animationController.forward().whenComplete(nextQuestion);
      //obtainDuration(_questionNumber.value);
    } else {
      //_questionNumber.value = 1;
      // Get package provide us simple way to navigate another page
      //Get.to(()=>ScoreBoardUI());
      isLastQuestion.value = true;
    }
  }

  void updateTheQnNum(int index) {
    //setCardQuestion(questions[index].question!);
    _questionNumber.value = index + 1;
  }

  resetAllValues() {
    _questionNumber.value = 1;
    isAnswered.value = false;
    isLastQuestion.value = false;
    _correctAns = 0;
    _numOfCorrectAns.value = 0;
    _selectedAns = 0;
    quizReviewList.clear();
  }

  @override
  void onClose() {
    super.onClose();
    //animationController.dispose();
    //pageController.dispose();
    resetAllValues();
    //_timer.cancel();
  }
}
