import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/models/quiz_model.dart';
import 'package:man_of_heal/utils/firebase.dart';

class AdminVdController extends GetxController {
  static AdminVdController instance = Get.find();
  static const QUIZ_COLLECTION = "quiz_collection";
  TextEditingController quizQuestionController = new TextEditingController();

  var quizList = <QuizModel>[].obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    quizList.bindStream(getQuiz());
  }

  createQuiz() async {
    String uid = firebaseFirestore.collection(QUIZ_COLLECTION).doc().id;
    QuizModel quizModel = QuizModel(
      questionList: null,
      createdDate: Timestamp.now(),
      quizTitle: quizQuestionController.text,
      qmID: uid,
      isAttempted: false,
    );

    await firebaseFirestore
        .collection(QUIZ_COLLECTION)
        .doc(uid)
        .set(quizModel.toJson())
        .then((value) => {
              quizQuestionController.clear(),
            });
  }

  Stream<List<QuizModel>> getQuiz() {
    return firebaseFirestore.collection(QUIZ_COLLECTION)
        .snapshots()
        .map((query) => query.docs
            .map((items) => QuizModel.fromMap(items.data()))
            .toList());
  }
}
