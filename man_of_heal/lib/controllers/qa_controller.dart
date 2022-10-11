import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/notification_model.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/models/subscription_model.dart';
import 'package:man_of_heal/models/user_model.dart';
import 'package:man_of_heal/ui/notifications/enum_notification.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/firebase.dart';

class QAController extends GetxController {
  static QAController instance = Get.find();

  static const QA_COLLECTION = "questions_answers";

  final TextEditingController? dialogAnswerController = TextEditingController();
  final TextEditingController? answerController = TextEditingController();

  TextEditingController questionController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  //admin question answer list
  var allQAList = <QuestionModel>[].obs;

  // student question answer list
  var qaList = <QuestionModel>[].obs;

  @override
  void onReady() {
    super.onReady();

    initQA();
  }

  void initQA() {
    qaList.clear();
    allQAList.clear();

    allQAList.bindStream(getAllQAs());
    qaList.bindStream(getCurrentUserAllQAs());
    qaList.listen((p0) {
      handleQALists(p0);
    });

    ever(allQAList, handleAdminAllQAList);

    ever(categoryController.categoriesList, populateSearchFilterDropDown);
  }

  var answerList = [].obs;
  var questionsList = <QuestionModel>[].obs;
  var searchList = [].obs;

  var notFoundListItems = "".obs;

  handleQALists(List<QuestionModel> list) {
    debugPrint("Questions: handleQALists() ${questionsList.length}");
    answerList.clear();
    questionsList.clear();
    if (list.length > 0) {
      for (QuestionModel q in list) {
        if (q.answerMap != null)
          answerList.add(q);
        else
          questionsList.add(q);
      }
    } else
      notFoundListItems("No Data Found!");

    debugPrint("Questions: handleQALists() after ${questionsList.length}");
  }

  static const String CHOOSE_CATEGORY = "Choose Category";
  var searchFilterList = [].obs;
  var selectedCategory = CHOOSE_CATEGORY.obs;

  void setSelectedCategory(String newValue) {
    selectedCategory.value = newValue;
    handleSearch();
  }

  void setAdminSelectedCategory(String newValue) {
    selectedCategory.value = newValue;
    handleAdminSearch();
  }

  var searchQuery = "".obs;

  void setSearchQuery(String newValue) {
    searchQuery.value = newValue;
    handleSearch();
  }

  void setAdminSearchQuery(String newValue) {
    searchQuery.value = newValue;
    handleAdminSearch();
  }

  void populateSearchFilterDropDown(categoriesList) {
    searchFilterList.insert(0, CHOOSE_CATEGORY);
    if (categoriesList.isNotEmpty) {
      categoriesList.forEach((element) {
        searchFilterList.add(element.category!);
      });
    }
  }

  void handleSearch() async {
    searchList.clear();
    String dropDownValue = selectedCategory.value.toLowerCase();
    String search = searchQuery.value.toLowerCase();
    print("Search $search");
    for (QuestionModel model in answerList) {
      if (model.answerMap != null) {
        if (dropDownValue != CHOOSE_CATEGORY.toLowerCase()) {
          if (dropDownValue.contains(model.category!.toLowerCase())) {
            if (search.isEmpty) {
              searchList.add(model);
            } else if (model.answerMap!.answer!
                .toLowerCase()
                .contains(search)) {
              searchList.add(model);
            }
          }
        } else if (model.answerMap!.answer!.toLowerCase().contains(search)) {
          print("Search $search Called");
          searchList.add(model);
        }
      }
    }
    update();
  }

  var inProgressQList = <QuestionModel>[].obs;
  var completedQAList = <QuestionModel>[].obs;
  var adminSearchList = <QuestionModel>[].obs;

  handleAdminAllQAList(List<QuestionModel> list) {
    inProgressQList.clear();
    completedQAList.clear();
    if (list.length > 0) {
      for (QuestionModel q in list) {
        if (q.answerMap != null)
          completedQAList.add(q);
        else
          inProgressQList.add(q);
      }
      completedQAList.sort((a, b) =>
          b.answerMap!.createdDate!.compareTo(a.answerMap!.createdDate!));
    } else
      notFoundListItems("No Data Found!");
  }

  handleAdminSearch() async {
    adminSearchList.clear();
    String dropDownValue = selectedCategory.value.toLowerCase();
    String search = searchQuery.value.toLowerCase();

    for (QuestionModel model in completedQAList) {
      if (model.answerMap != null) {
        if (dropDownValue != CHOOSE_CATEGORY.toLowerCase()) {
          String category = categoryController.getCategoryById(model.category);
          if (dropDownValue.contains(category.toLowerCase())) {
            if (search.isEmpty) {
              adminSearchList.add(model);
            } else if (model.answerMap!.answer!
                .toLowerCase()
                .contains(search)) {
              adminSearchList.add(model);
            }
          }
        } else if (model.answerMap!.answer!.toLowerCase().contains(search)) {
          adminSearchList.add(model);
        }
      }
    }
    adminSearchList.refresh();
    /*if(adminSearchList.isEmpty){
      AppConstant.displayNormalSnackBar("Search Alert!", "No data found associated with Search!.");
    }*/
  }

  void createQuestion() async {
    String _uuid = firebaseFirestore.collection(QA_COLLECTION).doc().id;
    DateTime? _currentTimeDate = DateTime.now();
    Timestamp _currentTimeStamp = Timestamp.fromDate(_currentTimeDate);
    print('${_currentTimeDate.add(new Duration(hours: 24))}');
    Timestamp? _after24HoursTimeDate =
        Timestamp.fromDate(_currentTimeDate.add(new Duration(hours: 24)));

    QuestionModel _newQuestion = QuestionModel(
        qID: _uuid,
        category: categoryController.selectedCategoryUID.value.toString(),
        //to get from spinner
        question: questionController.text,
        studentId: firebaseAuth.currentUser!.uid,
        answerMap: null,
        isDeleted: false,
        toBeAnsweredIn: _after24HoursTimeDate,
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
              if (authController.userModel!.isTrailFinished!)
                _updateSubscription(_currentTimeStamp),
              landingPageController.setStudentPage(1),
              sendNotificationToAdmin(_newQuestion),
              //update(),
            });
  }

  void _updateSubscription(Timestamp questionCreatedTime) async {
    if (!subscriptionController.subsFirebase.isBlank!) {
      DateTime? _currentTimeDate = DateTime.now();
      Timestamp? _nextQuestionCycle =
          Timestamp.fromDate(_currentTimeDate.add(new Duration(minutes: 5)));
      //Timestamp.fromDate(_currentTimeDate.add(new Duration(hours: 72)));

      Subscription subscription = subscriptionController.subsFirebase!;
      subscription.noOfAskedQuestion = subscription.noOfAskedQuestion! - 1;
      subscription.nextQuestionAt = _nextQuestionCycle;
      subscription.questionCreatedAt = questionCreatedTime;

      await firebaseFirestore
          .collection(subscriptionController.subscriptionCollection)
          .doc(firebaseAuth.currentUser!.uid)
          .update(subscription.toJson())
          .then((value) => {
                _clearControllers(),
                //handleQALists(),
                Get.back(),
                AppConstant.displaySuccessSnackBar(
                    "Creation Alert!", "Question was posted Successfully"),
              });
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
        .update({QuestionModel.ANSWER_MODEL: _answer.toJson()}).then(
            (value) => {
                  Get.back(),
                  print('${questionModel.qID} is answered!'),
                  dialogAnswerController!.clear(),
                  AppConstant.displaySuccessSnackBar(
                      "Answer Alert!", "Answer was posted Successfully"),
                  sendNotificationToStudent(questionModel),
                });
  }

  void sendNotificationToStudent(QuestionModel questionModel) async {
    UserModel sender = authController.userModel!;
    print(
        "Notifications: Sender name: ${sender.name}, Token: ${sender.userToken}");
    // getReceiver
    authController.getUserById(questionModel.studentId!.trim()).then((value) {
      print(
          "Notifications: Receiver name: ${value.name}, Token: ${value.userToken}");

      NotificationModel model = NotificationModel(
        senderName: sender.name,
        receiverToken: value.userToken,
        title: "Question And Answer",
        body: questionModel.question!,
        type: NotificationEnum.qa.name,
        isTopicBased: false,
        isRead: false,
        receiverId: questionModel.studentId,
      );
      notificationController.sendPushNotification(model);
      notificationController.addNotificationsToDB(model);
    });
  }

  void sendNotificationToAdmin(QuestionModel questionModel) async {
    UserModel sender = authController.userModel!;
    NotificationModel model = NotificationModel(
        senderName: sender.name,
        title: "Question And Answer",
        body: "A New Question was Asked!",
        type: NotificationEnum.qa_admin.name,
        isTopicBased: true,
        receiverToken: "Topics");
    notificationController.sendPushNotification(model);
  }

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
  Stream<List<QuestionModel>> getAllQAs() {
    return firebaseFirestore
        .collection(QA_COLLECTION)
        .where("isDeleted", isEqualTo: false)
        .orderBy(QuestionModel.CREATED_DATE, descending: true)
        .snapshots()
        .map((query) => query.docs
            .map((items) => QuestionModel.fromMap(items.data()))
            .toList());
  }

  Stream<List<QuestionModel>> getCurrentUserAllQAs() {
    String? uid = authController.userModel != null
        ? authController.userModel!.uid
        : firebaseAuth.currentUser != null
            ? firebaseAuth.currentUser!.uid
            : "";

    return firebaseFirestore
        .collection(QA_COLLECTION)
        .where(QuestionModel.STUDENT_ID, isEqualTo: uid)
        .where(QuestionModel.Q_IS_DELETED, isEqualTo: false)
        .orderBy(QuestionModel.CREATED_DATE, descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((e) =>
                e.exists ? QuestionModel.fromMap(e.data()) : QuestionModel())
            .toList());
  }

  Stream<List<QuestionModel>> searchQuestions(String query) {
    return firebaseFirestore
        .collection(QA_COLLECTION)
        .where(AnswerModel.ANSWER, isGreaterThanOrEqualTo: query)
        /*.startAt([query])
        .endAt([query + '\uf8ff'])*/
        .snapshots()
        .map((query) {
      // print('query ${query.docs.toList().length}');
      return query.docs.map(
        (items) {
          print('Question: ${items.data()['answer']}');
          return QuestionModel.fromMap(items.data());
        },
      ).toList();
    });
  }

  updateQuestionById(QuestionModel? questionModel) async {
    await firebaseFirestore
        .collection(QA_COLLECTION)
        .doc(questionModel!.qID)
        .update(questionModel.toJson())
        .then((value) {
      print('${questionModel.qID} question is updated!');

      _clearControllers();
      //handleQALists();

      AppConstant.displaySuccessSnackBar(
          "Update Alert!", 'question is updated!');
    });
  }

  ///
  /// When someone working on Question answer
  ///

  var ansStatusQuesModel = QuestionModel().obs;

  updateQuestionStatusWhenAnswering(QuestionModel? questionModel) async {
    await firebaseFirestore
        .collection(QA_COLLECTION)
        .doc(questionModel!.qID)
        .set({
      QuestionModel.IS_SOMEONE_ANSWER: questionModel.isSomeoneAnswering!
    }, SetOptions(merge: true)).whenComplete(() {
      print('question is updated!');
      ansStatusQuesModel.bindStream(getAnsweringStatus(questionModel.qID!));
    });
  }

  Stream<QuestionModel> getAnsweringStatus(questionModelId) {
    return firebaseFirestore
        .collection(QA_COLLECTION)
        .doc(questionModelId)
        .snapshots()
        .map((event) => event.exists
            ? QuestionModel.fromMap(event.data()!)
            : QuestionModel());
  }

  updateFavQuestionById(QuestionModel? questionModel) async {
    questionModel!.isFav = !questionModel.isFav!;
    await firebaseFirestore
        .collection(QA_COLLECTION)
        .doc(questionModel.qID)
        .set({QuestionModel.IS_FAVORITE: questionModel.isFav!},
            SetOptions(merge: true)).whenComplete(() {
      print('${questionModel.qID} fav question is updated!');
    });
  }

  Future<void> copyToClipBoard(String value) async {
    await Clipboard.setData(ClipboardData(text: value)).then((value) =>
        AppConstant.displaySuccessSnackBar(
            "Copy alert!", "Copied to Clipboard!"));
  }

  void _clearControllers() {
    dialogAnswerController!.clear();
    questionController.clear();
    answerController!.clear();
    searchController.clear();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _clearControllers();

    super.onClose();
  }
}
