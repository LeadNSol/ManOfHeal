import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/lab_model.dart';
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
  }

  Stream<List<LabModel>> getLabData() {
    return firebaseFirestore
        .collection(LAB_COLLECTION)
        .orderBy(LabModel.CREATED_DATE, descending: true)
        .snapshots()
        .map((snaps) =>
            snaps.docs.map((query) => LabModel.fromMap(query.data())).toList());
  }

  createLab() async {
    String _uuid = firebaseFirestore.collection(LAB_COLLECTION).doc().id;

    LabModel labModel = LabModel(
        lUID: _uuid,
        title: titleController.text,
        adminId: authController.userModel.value!.uid,
        shortDescription: shortDescController.text,
        longDescription: longDescController.text,
        imageIconUrl: " ",
        createdDate: Timestamp.now());

    await firebaseFirestore
        .collection(LAB_COLLECTION)
        .doc(_uuid)
        .set(labModel.toJson())
        .then(
          (value) => {
            _clearControllers(),
            print("Lab was added"),
          },
        );
  }

  _clearControllers() {
    titleController.clear();
    shortDescController.clear();
    longDescController.clear();
  }
}
