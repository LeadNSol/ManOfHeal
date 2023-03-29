import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/notifications/enum_notification.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class LabController extends GetxController with StateMixin {
  final AuthController? authController;
  final NotificationController? notificationController;
  LabController({this.authController, this.notificationController});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController shortDescController = TextEditingController();
  final TextEditingController longDescController = TextEditingController();

  //var labList = <LabModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    getLabDataNew();
    //labList.bindStream(getLabData());
    if (authController!.admin.isFalse)
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

  getLabDataNew() async {
    final colRef = firebaseFirestore
        .collection(LAB_COLLECTION)
        .orderBy(LabModel.CREATED_DATE, descending: true);
    try {
      var querySnap = await colRef.get();

      if (querySnap.docs.isNotEmpty) {
        change(
            querySnap.docs
                .map((query) => LabModel.fromMap(query.data()))
                .toList(),
            status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } catch (e) {
      change(null, status: RxStatus.error('Error fetching Labs $e'));
    }
  }

  Future<void> createLab() async {
    String _uuid = firebaseFirestore.collection(LAB_COLLECTION).doc().id;

    LabModel labModel = LabModel(
        lUID: _uuid,
        title: titleController.text,
        adminId: authController!.userModel!.uid,
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
            getLabDataNew(),
            sendNotificationToStudent(labModel),
          },
        );
  }

  void sendNotificationToStudent(LabModel model) async {
    UserModel sender = authController!.userModel!;

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
    notificationController?.sendPushNotification(model);
    //notificationController.addNotificationsToDB(model);
  }

  _clearControllers() {
    titleController.clear();
    shortDescController.clear();
    longDescController.clear();
  }

  @override
  void onClose() {
    _clearControllers();
    super.onClose();
  }
}
