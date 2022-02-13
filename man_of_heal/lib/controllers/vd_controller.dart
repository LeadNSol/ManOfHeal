import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/models/quiz_model.dart';
import 'package:man_of_heal/ui/student/pages/vignette_dissection/widgets/score_board_ui.dart';

class VDController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static VDController instance = Get.find<VDController>();

  late AnimationController animationController;
  late Animation _animation;

  Animation get animation => _animation;
  PageController pageController = PageController();

  RxInt duration = 0.obs;

  obtainDuration(int index) {
    duration.value = questions[index].duration!;
  }

  /* var percentValue = (10.0).obs;
  late Timer _timer;

  //var _start = 10.obs;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (percentValue.value == 0.0) {
          _timer.cancel();
        } else {
          percentValue.value--;
        }
      },
    );
  }*/

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //default obtaining list first question duration
    obtainDuration(0);
    //cardQuestion(questions[0].question);
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: duration.value));
    _animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    /*..addListener(() {
        update();
      });*/

    animationController.forward().whenComplete(nextQuestion);
  }

  @override
  void onReady() {
    super.onReady();
    cardQuestion.value = questions[0].question!;
  }

  List<QuizQuestion> getQuizQuestions() {
    return sample_data
        .map(
          (question) => QuizQuestion(
              qqId: question['id'],
              question: question['question'],
              options: question['options'],
              correctAnswer: question['correctAnswer'],
              duration: question['duration']),
        )
        .toList();
  }

  List<QuizQuestion> get questions => this.getQuizQuestions();

  var cardQuestion = 'question card here'.obs;

  setCardQuestion(String question) {
    cardQuestion.value = question;
  }

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

  void checkAns(
      QuizQuestion quizQuestion, int selectedIndex, int correctIndex) {
    // because once user press any option then it will run
    isAnswered.value = true;
    print('Correct question: ${quizQuestion.question!}');
    _correctAns = correctIndex;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns.value++;

    print('Correct: $_numOfCorrectAns');
    // It will stop the counter
    //animationController.stop();
    //update();

    // Once user select an ans after 3s it will go to the next qn
    Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != questions.length) {
      isAnswered.value = false;
      pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      animationController.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      animationController.forward().whenComplete(nextQuestion);
      //obtainDuration(_questionNumber.value);
    } else {
      // Get package provide us simple way to navigate another page
      Get.to(ScoreBoardUI());
    }
  }

  void updateTheQnNum(int index) {
    setCardQuestion(questions[index].question!);
    _questionNumber.value = index + 1;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    animationController.dispose();
    pageController.dispose();
    //_timer.cancel();
  }
}
