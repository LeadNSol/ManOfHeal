import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../utils/export_utils.dart';

class ProfileController extends GetxController {
  final SubscriptionController? subscriptionController;
  final FeedBackController? feedBackController;


  var editTextFieldController = TextEditingController();

  ProfileController({this.subscriptionController, this.feedBackController});
  ///Profile Avatars.
  var profileAvatarsList = <ProfileAvatars>[].obs;




  @override
  void onReady() {
    // TDO: implement onInit
    super.onReady();
    getAppVersion();
    profileAvatarsList.bindStream(getProfileAvatars());
  }


  Stream<List<ProfileAvatars>> getProfileAvatars() {
    return firebaseFirestore.collection(PROFILE_AVATARS).snapshots().map(
            (event) =>
            event.docs.map((e) => ProfileAvatars.fromMap(e.data())).toList());
  }

  updateProfileAvatar(ProfileAvatars profileAvatar) async {
    await firebaseFirestore.collection(USERS).doc(AppCommons.userModel!.uid!).set(
        {UserModel.PHOTO_URL: profileAvatar.url!},
        SetOptions(merge: true)).whenComplete(() {
      Get.back();
      AppConstant.displaySuccessSnackBar(
          "Success!", "Profile Avatar Successfully Updated!");
    });
  }


  List getProfileData() {
    UserModel?  userModel = AppCommons.userModel;
    var profileData = [
      {
        "title": "Phone",
        "subtitle":
        userModel!.phone ?? 'no phone number',
        "icon": "assets/icons/phone_icon.svg"
      },
      {
        "title": "Email",
        "subtitle":
        userModel.email ?? "example@gmail.com",
        "icon": "assets/icons/email_icon.svg"
      },
      {
        "title": "Address",
        "subtitle": userModel.address ?? 'e.g. street, e.g. city, e.g. Country',
        "icon": "assets/icons/address_icon.svg"
      },
    ];
    return profileData;
  }

  // var subscriptionModel = Subscription().obs;

  Subscription? getSubsModel() {
    return subscriptionController?.subsFirebase;
  }

  int getSubscriptionExpiry() {
    return subscriptionController!.getSubscriptionExpiry();
  }

  double getAdminRating() {
    return feedBackController?.netAdminRating.value ?? 0;
  }


  final appVersion = "".obs;

   getAppVersion() async{
    PackageInfo? packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = "${packageInfo.version + "-" + packageInfo.buildNumber}";
  }

  Future<void> updateCurrentUser(String title) async {
    String value = editTextFieldController.text.trim();
    await firebaseFirestore.collection(USERS).doc(AppCommons.userModel!.uid!).set(
        {title.toLowerCase(): value}, SetOptions(merge: true)).whenComplete(() {
      editTextFieldController.clear();
    });
  }


  @override
  void onClose() {
    // TDO: implement onClose
    super.onClose();
    feedBackController?.dispose();
    subscriptionController?.dispose();
  }
}
