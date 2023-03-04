import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class FeedBackController extends GetxController {
  final AuthController? authController;
  final NotificationController? notificationController;

  FeedBackController(
      {required this.authController, required this.notificationController});

  var remarksController = TextEditingController();
  var rating = 0.0.obs;

  var currentAdminFeedBackList = <FeedbackModel>[].obs;

  //var isOverFlowVisible = false.obs;
  final isSeeMoreClicked = false.obs;




  //TDO: get admin total rating
  var netAdminRating = 0.0.obs;

  //TDO: checkCurrent Student User in FeedBack List
  var haveCurrentUserInList = false.obs;

  @override
  void onReady() {
    super.onReady();

    fetchCurrentAdminFeedBack();
  }

  void fetchCurrentAdminFeedBack({UserModel? userModel}) {
    currentAdminFeedBackList.bindStream(geUserFeedback(userModel: userModel));
    ever(currentAdminFeedBackList, handleAdminData);
  }

  void handleAdminData(List<FeedbackModel> list) {
    String? uid = firebaseAuth.currentUser != null
        ? firebaseAuth.currentUser!.uid
        : authController!.userModel != null
            ? authController!.userModel!.uid!
            : "";
    debugPrint("geUserFeedback(): List ${list.length}");
    double totalRating = 0.0;

    var isStudentRatedAdmin = false;
    list.forEach((element) {
      if (element.ratings != null) totalRating += element.ratings!;
      if (element.studentId! == uid) {
        isStudentRatedAdmin = true;
      }
    });

    haveCurrentUserInList.value = isStudentRatedAdmin;

    if (totalRating > 0.0)
      netAdminRating.value = totalRating / list.length;
    else
      netAdminRating.value = 0.0;
  }

  Stream<List<FeedbackModel>> geUserFeedback({UserModel? userModel}) {
    String? uid = userModel != null
        ? userModel.uid
        : firebaseAuth.currentUser?.uid != null
            ? firebaseAuth.currentUser!.uid
            : authController!.userModel!.uid!;

    return firebaseFirestore
        .collection(USERS)
        .doc(uid)
        .collection(userFeedBackCollections)
        .snapshots()
        .map((event) => event.docs
            .map((e) =>
                e.exists ? FeedbackModel.fromMap(e.data()) : FeedbackModel())
            .toList());
  }

  Future<void> createFeedBack(
      QuestionModel questionModel, UserModel userModel) async {
    var ref = firebaseFirestore
        .collection(USERS)
        .doc(userModel.uid!)
        .collection(userFeedBackCollections);

    FeedbackModel model = FeedbackModel(
      ratings: rating.value,
      remarks: remarksController.text,
      dateTime: Timestamp.now(),
      adminId: questionModel.answerMap!.adminID,
      studentId: questionModel.studentId!,
    );

    await ref.doc(questionModel.studentId!).set(model.toMap()).whenComplete(() {
      AppConstant.displaySuccessSnackBar("Feed Back",
          "You're feedback is Successfully submitted against Instructor: ${userModel.name}!");
      remarksController.clear();
    });
  }

  UserModel? getFeedbackUser(String? studentId) {
    return authController!.getUserFromListById(studentId!);
  }

  @override
  void onClose() {
    // TDO: implement onClose
    super.onClose();
  }
}
