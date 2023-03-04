import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/notifications/enum_notification.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class DailyActivityController extends GetxController {
  //static DailyActivityController instance = Get.find();

  final AuthController? authController;
  final NotificationController? notificationController;
  final FeedBackController? feedbackController;

  DailyActivityController(
      {this.authController,
      this.notificationController,
      this.feedbackController});

  static const DAILY_ACTIVITY = "daily_activity";
  static const studentAnswersCollection = "studentAnswers";
  static const stdSubCollection = "answers";

  final TextEditingController termOfDayController = TextEditingController();
  final TextEditingController qOfDayController = TextEditingController();
  final TextEditingController studentAnswerController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  //Rxn<DailyActivityModel> daModel = Rxn<DailyActivityModel>();

  var tod = AppConstant.noTODFound.obs;
  var qod = AppConstant.noQODFound.obs;

  var _dailyActivityModel = DailyActivityModel().obs;

  DailyActivityModel? get model => _dailyActivityModel.value;
  var currentStdAnswerList = <StdAnswerModel>[].obs;

  var allStudentsAnswers = <StdAnswerModel>[].obs;

  var _currentDate = "".obs;

  setCurrentDate(Timestamp date) {
    String sDate = AppConstant.formattedDataTime("dd-MM-yyyy", date);
    _currentDate.value = sDate;
    allStudentsAnswers.bindStream(streamAllStudentsAnswers(sDate));
    currentStdAnswerList
        .bindStream(getCurrentStudentAnswersByDate(date: sDate));
  }

  /// for re-active approach and visibility of approve button
  var stdAnswerModel = StdAnswerModel().obs;

  @override
  void onReady() {
    String date = AppConstant.formattedDataTime("dd-MM-yyyy", Timestamp.now());
    getDailyActivity(date);

    //ever(allStudents, handleAllStudents);
    super.onReady();
  }

  ///
  /// Admin Student Answer Section
  ///
  Stream<List<StdAnswerModel>> streamAllStudentsAnswers(String? date) {
    allStudentsAnswers.clear();
    return firebaseFirestore
        .collection(DAILY_ACTIVITY)
        .doc(date)
        .collection(studentAnswersCollection)
        .snapshots()
        .map((event) => event.docs
            .map((e) =>
                e.exists ? StdAnswerModel.fromMap(e.data()) : StdAnswerModel())
            .toList());
  }

  updateStudentAnswer(StdAnswerModel model) async {
    await firebaseFirestore
        .collection(DAILY_ACTIVITY)
        .doc(_currentDate.value)
        .collection(studentAnswersCollection)
        .doc(model.uId)
        .set(model.toMap(), SetOptions(merge: true))
        .then((value) => {
              stdAnswerModel.refresh(),
              Get.back(),
              AppConstant.displaySuccessSnackBar(
                  "Update", "Answer status is Approved"),
            });
  }

  var studentsInUserList = <UserModel>[].obs;

  handleAllStudents(List<StudentModel> list) {
    studentsInUserList.clear();
    if (list.isNotEmpty) {
      for (var value in list) {
        print("HandleAllStudents: " + value.studentId!);
        for (UserModel model in authController!.usersList) {
          if (model.uid!.contains(value.studentId!)) {
            studentsInUserList.add(model);
          }
        }
      }
    } else {
      print("HandleAllStudents: Empty");
    }
  }

  var searchAnswersList = <StdAnswerModel>[].obs;

  handleAdminSearch(String query) {
    searchAnswersList.clear();
    if (allStudentsAnswers.isNotEmpty) {
      if (query.isNotEmpty) {
        StdAnswerModel model = allStudentsAnswers.firstWhere(
            (element) => element.answer!.toLowerCase().contains(query));
        searchAnswersList.add(model);
      }
    }
    searchAnswersList.refresh();
  }

  ///
  /// Student Answer Sections
  ///

  createStudentAnswer(DailyActivityModel? model) async {
    if (model != null && model.daUID != null) {
      String userID = authController!.userModel!.uid!;
      var colSubRef = firebaseFirestore
          .collection(DAILY_ACTIVITY)
          .doc(model.daUID!)
          .collection(studentAnswersCollection);
      String uid = colSubRef.doc().id;

      StdAnswerModel stdAnswerModel = StdAnswerModel(
        questionId: model.qOfDay!,
        answerDate: Timestamp.now(),
        answerBy: userID,
        answer: studentAnswerController.text,
        uId: uid,
      );
      await colSubRef.doc(uid).set(stdAnswerModel.toMap()).whenComplete(() => {
            clearControllers(),
            Get.back(),
            AppConstant.displaySuccessSnackBar("Answer Alert!",
                "You have Answered Q: ${model.qOfDay!} Successfully!"),
            //sendNotificationToStudent(model!)
          });
    }
  }

  Stream<List<StdAnswerModel>> getCurrentStudentAnswersByDate({String? date}) {
    return firebaseFirestore
        .collection(DAILY_ACTIVITY)
        .doc(date)
        .collection(studentAnswersCollection)
        .where(StdAnswerModel.answerBY,
            isEqualTo: authController!.userModel!.uid)
        .snapshots()
        .map((event) => event.docs
            .map((e) =>
                e.exists ? StdAnswerModel.fromMap(e.data()) : StdAnswerModel())
            .toList());
  }

  bool? checkIfStdGiveAnswer() {
    if (currentStdAnswerList.isNotEmpty) {
      for (StdAnswerModel answerModel in currentStdAnswerList) {
        if (answerModel.answerBy!.contains(authController!.userModel!.uid!)) {
          return true;
        }
      }
    }
    return false;
  }

  var stdAnswerSearchList = <StdAnswerModel>[].obs;

  handleAnswerSearch(String query) {
    stdAnswerSearchList.clear();
    if (currentStdAnswerList.isNotEmpty) {
      stdAnswerSearchList.addAll(currentStdAnswerList
          .where((element) => element.answer!.toLowerCase().contains(query)));
    }
  }

  deleteStudentAnswerById(StdAnswerModel model) async {
    await firebaseFirestore
        .collection(studentAnswersCollection)
        .doc(model.answerBy)
        .collection(stdSubCollection)
        .doc(model.uId)
        .delete()
        .whenComplete(() => AppConstant.displaySuccessSnackBar("Delete",
            "Answer: ${model.answer!.substring(0, model.answer!.length - 10)} ... Deleted!"));
  }

  getDailyActivity(String date) {
    _dailyActivityModel.bindStream(streamDailyActivityByDate(date));
  }

  addDailyActivity() async {
    String date = AppConstant.formattedDataTime("dd-MM-yyyy", Timestamp.now());

    DailyActivityModel daModel = DailyActivityModel(
      daUID: date,
      termOfDay: termOfDayController.text,
      qOfDay: qOfDayController.text,
      createdDate: Timestamp.now(),
      createdBy: firebaseAuth.currentUser!.uid,
    );

    await firebaseFirestore
        .collection(DAILY_ACTIVITY)
        .doc(date)
        .set(daModel.toJson())
        .then((value) => {
              clearControllers(),
              print("Daily Activity Added"),
              sendNotificationToStudent(daModel),
            });
  }

  void sendNotificationToStudent(DailyActivityModel model) async {
    UserModel sender = authController!.userModel!;
    print(
        "Notifications: Sender name: ${sender.name}, Token: ${sender.userToken}");

    NotificationModel model = NotificationModel(
        senderName: sender.name,
        //receiverToken: value.userToken,
        title: "Daily Activity",
        body: "A new Question and Term of day were added",
        type: NotificationEnum.daily_activity.name,
        isTopicBased: true,
        isRead: false,
        receiverToken: "daily_activity"
        //receiverId: questionModel.studentId,
        );
    notificationController?.sendPushNotification(model);
    //notificationController.addNotificationsToDB(model);
  }

  Future<DailyActivityModel> getDailyActivityByDate(Timestamp timestamp) {
    print('DateQOD: ${DateTime.now()}');
    print('DateQOD: ${timestamp.toDate().toString()}');
    String date = AppConstant.formattedDataTime("dd-MM-yyyy", timestamp);
    return firebaseFirestore
        .collection(DAILY_ACTIVITY)
        .doc(date)
        .get()
        .then((DocumentSnapshot snap) => DailyActivityModel.fromDoc(snap));
  }

  Stream<DailyActivityModel> streamDailyActivityByDate(String date) {
    return firebaseFirestore
        .collection(DAILY_ACTIVITY)
        .doc(date)
        .snapshots()
        .map((event) => event.exists
            ? DailyActivityModel.fromMap(event.data()!)
            : DailyActivityModel());
    // .then((DocumentSnapshot snap) => DailyActivityModel.fromDoc(snap));
  }

  void clearControllers() {
    termOfDayController.clear();
    qOfDayController.clear();
    studentAnswerController.clear();
    searchController.clear();
  }

  clearObjectsAndLists() {
    currentStdAnswerList.clear();
    allStudentsAnswers.clear();
    stdAnswerSearchList.clear();
    searchAnswersList.clear();

    stdAnswerModel.close();
    _dailyActivityModel.close();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    clearControllers();
    clearObjectsAndLists();
    super.onClose();
  }
}
