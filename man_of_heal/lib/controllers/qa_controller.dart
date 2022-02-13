import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/category_model.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/models/subscription_model.dart';
import 'package:man_of_heal/utils/firebase.dart';

class QAController extends GetxController {
  static QAController instance = Get.find();

  static const QA_COLLECTION = "questions_answers";
  static const CATEGORIES = "categories";

  final TextEditingController? dialogAnswerController = TextEditingController();
  final TextEditingController? answerController = TextEditingController();

  TextEditingController categoryController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  //admin question answer list
  var allQAList = <QuestionModel>[].obs;

  // student question answer list
  var qaList = <QuestionModel>[].obs;

  //var qaList = <QuestionModel>[].obs;
  var categoriesList = <Category>[].obs;

  var selectedCategory = "Default".obs;

  void setSelectedCategory(String? category) {
    selectedCategory.value = category!;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    qaList.bindStream(getCurrentUserAllQAs());
    //answerList.bindStream(getCurrentUserAllQAs());
    allQAList.bindStream(getAllQAs());
    categoriesList.bindStream(getAllCategories());
  }

  handleSearch(searchQuery) async {
    if (searchQuery.isEmpty) {
      print('calling normal');
      //qaList.bindStream(getCurrentUserAllQAs(QAHeaderChips.values[selectedChip]));
      qaList.bindStream(getCurrentUserAllQAs());
    } else {
      print('calling search');
      qaList.bindStream(searchQuestions(searchQuery));
    }
  }

  void createQuestion() async {
    String _uuid = firebaseFirestore.collection(QA_COLLECTION).doc().id;
    DateTime? _currentTimeDate = DateTime.now();
    Timestamp _currentTimeStamp = Timestamp.fromDate(_currentTimeDate);
    print('${_currentTimeDate.add(new Duration(hours: 24))}');
    Timestamp? _afterThreeDaysTimeDate =
        Timestamp.fromDate(_currentTimeDate.add(new Duration(hours: 24)));

    QuestionModel _newQuestion = QuestionModel(
        qID: _uuid,
        category: selectedCategory.value.toString(),
        //to get from spinner
        question: questionController.text,
        studentId: firebaseAuth.currentUser!.uid,
        answerMap: null,
        isDeleted: false,
        toBeAnsweredIn: _afterThreeDaysTimeDate,
        qCreatedDate: _currentTimeStamp,
        qModifiedDate: _currentTimeStamp);
    await firebaseFirestore
        .collection(QA_COLLECTION)
        .doc(_uuid)
        .set(_newQuestion.toJson())
        .then((value) => {
              questionController.clear(),
              // spinner would be set to default here,
              print('question was posted'),
              _updateSubscription(_currentTimeStamp)
            });
  }

  void _updateSubscription(Timestamp questionCreatedTime) async {
    if (!subscriptionController.subsFirebase.isBlank!) {
      DateTime? _currentTimeDate = DateTime.now();
      Timestamp? _nextQuestionCycle =
          Timestamp.fromDate(_currentTimeDate.add(new Duration(hours: 1)));

      Subscription subscription = subscriptionController.subsFirebase.value!;
      subscription.noOfAskedQuestion = subscription.noOfAskedQuestion! - 1;
      subscription.nextQuestionAt = _nextQuestionCycle;
      subscription.questionCreatedAt = questionCreatedTime;

      await firebaseFirestore
          .collection(subscriptionController.subscriptionCollection)
          .doc(firebaseAuth.currentUser!.uid)
          .update(subscription.toJson())
          .then((value) => print('subscription noOfQuestion updated'));
    } else {
      print('No subscription for current user was found!');
    }
  }

  void answerTheQuestionById(questionModel) {
    AnswerModel _answer = AnswerModel(
        adminID: firebaseAuth.currentUser!.uid,
        createdDate: Timestamp.now(),
        modifiedDate: Timestamp.now(),
        answer: dialogAnswerController!.text);
    firebaseFirestore
        .collection(QA_COLLECTION)
        .doc(questionModel!.qID)
        .update({QuestionModel.ANSWER_MODEL: _answer.toJson()}).then((value) =>
            {
              print('${questionModel.qID} is answered!'),
              dialogAnswerController!.clear()
            });
  }

  //QuestionModel?
  void updateAnswerOfTheQuestionById(questionModel) {
    AnswerModel _updatedAnswer = AnswerModel(
        adminID: questionModel!.answerMap!.adminID,
        createdDate: questionModel!.answerMap!.createdDate,
        answer: dialogAnswerController!.text,
        modifiedDate: Timestamp.now());

    firebaseFirestore
        .collection(QA_COLLECTION)
        .doc(questionModel!.qID)
        .update({QuestionModel.ANSWER_MODEL: _updatedAnswer.toJson()}).then(
            (value) => {
                  print('${questionModel.qID} answer is updated!'),
                  dialogAnswerController!.clear()
                });
  }

  //fetching All Questions with Answer (if given) for the Admin.
  Stream<List<QuestionModel>> getAllQAs() => firebaseFirestore
      .collection(QA_COLLECTION)
      .where("isDeleted", isEqualTo: false)
      .orderBy(QuestionModel.CREATED_DATE, descending: true)
      .snapshots()
      .map((query) => query.docs
          .map((items) => QuestionModel.fromMap(items.data()))
          .toList());

/*  Stream<List<QuestionModel>> getCurrentUserAllQAs() {
    return firebaseFirestore
        .collection(QA_COLLECTION)
        .where(QuestionModel.STUDENT_ID,
            isEqualTo: firebaseAuth.currentUser?.uid)
        .where(QuestionModel.Q_IS_DELETED, isEqualTo: false)
        .where(QuestionModel.ANSWER_MODEL, isNotEqualTo: null)
        .orderBy(QuestionModel.CREATED_DATE, descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => QuestionModel.fromMap(e.data())).toList());
  }*/

  Stream<List<QuestionModel>> getCurrentUserAllQAs() {
    return firebaseFirestore
        .collection(QA_COLLECTION)
        .where(QuestionModel.STUDENT_ID,
            isEqualTo: firebaseAuth.currentUser?.uid)
        .where(QuestionModel.Q_IS_DELETED, isEqualTo: false)
        //.where(QuestionModel.ANSWER_MODEL, isEqualTo: null)
        .orderBy(QuestionModel.CREATED_DATE, descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => QuestionModel.fromMap(e.data())).toList());
  }

  Stream<List<QuestionModel>> getCurrentUserAllQAsByChip(QAHeaderChips chips) {
    print('Chips   $chips');
    CollectionReference reference = firebaseFirestore.collection(QA_COLLECTION);
    Query query = reference
        .where(QuestionModel.STUDENT_ID,
            isEqualTo: firebaseAuth.currentUser?.uid)
        .where("isDeleted", isEqualTo: false)
        .orderBy(QuestionModel.CREATED_DATE, descending: true);
    return query
        .where(QuestionModel.ANSWER_MODEL, isEqualTo: null)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((e) => QuestionModel.fromMap(e.data() as Map<String, dynamic>))
            .toList());
    /* switch (chips) {
      case QAHeaderChips.QUESTIONS:
        // print('Questions $chips');
        return query
            .where(QuestionModel.ANSWER_MODEL, isEqualTo: null)
            .snapshots()
            .map((snapshot) => snapshot.docs
                .map((e) => QuestionModel.fromMap(e.data()))
                .toList());

      case QAHeaderChips.ANSWERED:
        //print('Answered $chips');
        return query.snapshots().map((snapshot) =>
            snapshot.docs.map((e) => QuestionModel.fromMap(e.data())).toList());
    }*/
  }

  Stream<List<QuestionModel>> searchQuestions(String query) {
    return firebaseFirestore
        .collection(QA_COLLECTION)
        .where(QuestionModel.QUESTION, isGreaterThanOrEqualTo: query)
        //.startAt([query])
        //.endAt([query + '\uf8ff'])
        .snapshots()
        .map((query) {
      // print('query ${query.docs.toList().length}');
      return query.docs.map(
        (items) {
          print('Question: ${items.data()['question']}');
          return QuestionModel.fromMap(items.data());
        },
      ).toList();
    });
  }

  Stream<List<Category>> getAllCategories() {
    //print('Reference not empty');
    CollectionReference reference = firebaseFirestore.collection(CATEGORIES);

    return reference.snapshots().map((query) => query.docs
        .map((items) => Category.fromMap(items.data() as Map<String, dynamic>))
        .toList());
  }

  deleteQuestionById(QuestionModel? questionModel) async {
    await firebaseFirestore
        .collection(QA_COLLECTION)
        .doc(questionModel!.qID)
        .update(questionModel.toJson())
        .then((value) {
      print('${questionModel.qID} question is updated means deleted!');
    });
  }

  createCategory() async {
    String? _uuid = firebaseFirestore.collection(CATEGORIES).id;
    Category _newCategory = Category(
        cUID: _uuid,
        category: categoryController.text,
        createdBy: firebaseAuth.currentUser!.uid,
        createdDate: Timestamp.now());

    await firebaseFirestore
        .collection(CATEGORIES)
        .doc(_uuid)
        .set(_newCategory.toJson())
        .then((value) =>
            {categoryController.clear(), print('Category was added!')});
  }
}
