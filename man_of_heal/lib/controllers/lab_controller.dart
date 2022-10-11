import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/lab_model.dart';
import 'package:man_of_heal/models/notification_model.dart';
import 'package:man_of_heal/models/user_model.dart';
import 'package:man_of_heal/ui/notifications/enum_notification.dart';
import 'package:man_of_heal/utils/firebase.dart';

class LabController extends GetxController {
  static LabController instance = Get.find();
  static const LAB_COLLECTION = "lab_collections";

  final TextEditingController titleController = TextEditingController();
  final TextEditingController shortDescController = TextEditingController();
  final TextEditingController longDescController = TextEditingController();

  var labList = <LabModel>[].obs;

  /* @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    labList.bindStream(getLabData());
  }*/

  @override
  void onReady() {
    super.onReady();
    labList.bindStream(getLabData());
    if (authController.admin.isFalse)
      FirebaseMessaging.instance
          .subscribeToTopic(NotificationEnum.labs.name)
          .then((value) => print("Notification: Subscribed to Labs Topic"));
  }

  Stream<List<LabModel>> getLabData() {
    return firebaseFirestore
        .collection(LAB_COLLECTION)
        .orderBy(LabModel.CREATED_DATE, descending: true)
        .snapshots()
        .map((snaps) =>
            snaps.docs.map((query) => LabModel.fromMap(query.data())).toList());
  }

  Future<void> createLab() async {
    String _uuid = firebaseFirestore.collection(LAB_COLLECTION).doc().id;

    LabModel labModel = LabModel(
        lUID: _uuid,
        title: titleController.text,
        adminId: authController.userModel!.uid,
        shortDescription: shortDescController.text,
        longDescription: longDescController.text,
        imageIconUrl: "",
        createdDate: Timestamp.now());

    await firebaseFirestore
        .collection(LAB_COLLECTION)
        .doc(_uuid)
        .set(labModel.toJson())
        .then(
          (value) => {
            _clearControllers(),
            print("Lab was added"),
            sendNotificationToStudent(labModel),
          },
        );
  }

  void sendNotificationToStudent(LabModel model) async {
    UserModel sender = authController.userModel!;
    print(
        "Notifications: Sender name: ${sender.name}, Token: ${sender.userToken}");

    NotificationModel model = NotificationModel(
      senderName: sender.name,
      //receiverToken: value.userToken,
      title: "Lab Value Explanation",
      body: "A new Lab data was added",
      type: NotificationEnum.labs.name,
      isTopicBased: true,
      isRead: false,
      receiverToken: "Labs"
      //receiverId: questionModel.studentId,
    );
    notificationController.sendPushNotification(model);
    //notificationController.addNotificationsToDB(model);
  }

  _clearControllers() {
    titleController.clear();
    shortDescController.clear();
    longDescController.clear();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _clearControllers();
    super.onClose();
  }
}
