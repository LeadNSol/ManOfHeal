import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/auth_controller.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/feedback_model.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/models/user_model.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/firebase.dart';

class FeedBackController extends GetxController {
  static FeedBackController instance = Get.find();

  static const userFeedBackCollections = "feed_backs";

  var remarksController = TextEditingController();
  var rating = 0.0.obs;

  var currentAdminFeedBackList = <FeedbackModel>[].obs;

  //var isOverFlowVisible = false.obs;
  //TODO: get admin total rating
  var netAdminRating = 0.0.obs;

  //TODO: checkCurrent Student User in FeedBack List
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
        : authController.userModel != null
            ? authController.userModel!.uid!
            : "";
    debugPrint("geUserFeedback(): List ${list.length}");
    double totalRating = 0.0;

    var isStudentRatedAdmin = false;
    list.forEach((element) {
      if (element.ratings != null) totalRating += element.ratings!;
      if (element.studentId! == uid) {
        debugPrint("geUserFeedback(): innwe ${uid}");
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
            : authController.userModel!.uid!;

    debugPrint("geUserFeedback(): $uid");
    return firebaseFirestore
        .collection(AuthController.USERS)
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
    var ref = await firebaseFirestore
        .collection(AuthController.USERS)
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
}
