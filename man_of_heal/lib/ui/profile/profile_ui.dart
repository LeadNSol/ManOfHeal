import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/models/profile_avatars.dart';
import 'package:man_of_heal/ui/components/black_rounded_container.dart';
import 'package:man_of_heal/ui/components/circular_avatar.dart';
import 'package:man_of_heal/ui/components/custom_header_row.dart';
import 'package:man_of_heal/ui/components/form_input_field_with_icon.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/student/pages/subscription/subscription_ui.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';
import 'package:man_of_heal/utils/validator.dart';

import '../../controllers/controllers_base.dart';
import '../components/primary_button.dart';


class ProfileUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: bodyNew(context),
      ),
    );
  }

  Widget bodyNew(context) {
    //feedBackController.fetchCurrentAdminFeedBack(authController.userModel!);
    /*  int daysLeft = AppConstant.daysBetween(
        subscriptionController.subsFirebase!.expiresAt!.toDate(),
        DateTime.now());*/
    return Stack(
      fit: StackFit.expand,
      children: [
        /// black background
        Positioned(
          top: 0,
          height: 220,
          left: 0,
          right: 0,
          child: BlackRoundedContainer(),
        ),
        Positioned(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              /// Header
              CustomHeaderRow(
                title: "Profile",
                hasProfileIcon: false,
                isAdmin: authController.admin.value,
              ),
              FormVerticalSpace(
                height: 120,
              ),

              ///profile pic & name & subscription for students
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///Profile icon with change icon
                  Stack(
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppThemes.DEEP_ORANGE.withOpacity(0.22),
                              offset: Offset(0, 0),
                              blurRadius: 10.78,
                            ),
                          ],
                        ),
                        child: Obx(
                          () => CircularAvatar(
                            padding: 2,
                            radius: 50,
                            imageUrl: authController.userModel!.photoUrl!,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: InkWell(
                          onTap: () {
                            Get.defaultDialog(
                              title: "Choose Profile Avatar",
                              titleStyle: AppThemes.dialogTitleHeader
                                  .copyWith(color: AppThemes.DEEP_ORANGE),
                              content: _profileIconsContent(),
                              //confirm: _btnSCameraAndGallery(),
                            );
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(Icons.add_a_photo,
                                  color: AppThemes.DEEP_ORANGE),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    50,
                                  ),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 0),
                                    color: AppThemes.DEEP_ORANGE.withOpacity(
                                      0.3,
                                    ),
                                    blurRadius: 10.78,
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  FormVerticalSpace(
                    height: 5,
                  ),
                  _nameAndRatingWidget(context),
                  FormVerticalSpace(
                    height: 15,
                  ),
                  Visibility(
                    visible: authController.admin.isFalse,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/icons/premium_member.png",
                        ),
                        FormVerticalSpace(
                          height: 10,
                        ),
                        subscriptionController.subsFirebase?.studentId == null
                            ? InkWell(
                                onTap: () => Get.to(() => SubscriptionUI()),
                                child: Text(
                                  "You haven't Subscribe any Plan \n Wants to become a Member?",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color: AppThemes.PREMIUM_OPTION_COLOR,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Text(
                                "${subscriptionController.subsFirebase!.planName!} Member \n "
                                "Days left: ${subscriptionController.getSubscriptionExpiry() > 0 ? subscriptionController.getSubscriptionExpiry() : "Expired"}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    color: AppThemes.PREMIUM_OPTION_COLOR,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                        FormVerticalSpace(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              /// card profile data, e.g. phone, email, address
              Obx(
                () => ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(5),
                  children: authController
                      .getProfileData()
                      .map(
                        (profile) => profileCards(profile["title"],
                            profile["subtitle"], profile["icon"]),
                      )
                      .toList(),
                ),
              ),

              FormVerticalSpace(),

              /// logout button
              Center(
                child: Container(
                  width: 290,
                  height: 45,
                  child: PrimaryButton(
                    buttonStyle: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        primary: AppThemes.DEEP_ORANGE,
                        shape: StadiumBorder(),
                        textStyle: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                    onPressed: () {
                      // authController.disposeGetXControllers();
                      authController.signOut();
                      // authController.dispose();
                      //Phoenix.rebirth(context);
                      Get.offAndToNamed("/welcome");
                    },
                    labelText: 'LOG OUT',
                  ),
                ),
              ),
              FormVerticalSpace(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Obx(() {
                    getBuildNumber();
                    return Text("version: ${appVersion.value}");
                  }),
                ),
              ),
              FormVerticalSpace(),
            ],
          ),
        ),
      ],
    );
  }

  final appVersion = "".obs;

  void getBuildNumber() {
    AppConstant.getBuildNumber().then((value) {
      debugPrint("Version: ${value.version+"-"+value.buildNumber}");

      appVersion.value = "${value.version+"-"+value.buildNumber}";
    });
  }

  Widget _nameAndRatingWidget(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30,
            ),
            Obx(
              () => Text(
                '${authController.userModel!.name ?? 'ABC NAME'}',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: () =>
                  showEditDialog("name", authController.userModel!.name),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(Icons.edit,
                      size: 20, color: AppThemes.DEEP_ORANGE.withOpacity(0.8)),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      50,
                    ),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      color: AppThemes.DEEP_ORANGE.withOpacity(
                        0.3,
                      ),
                      blurRadius: 10.78,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        authController.admin.isFalse
            ? Container()
            : Obx(
                () => RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.favorite,
                          size: 13,
                          color: AppThemes.DEEP_ORANGE,
                        ),
                      ),
                      TextSpan(
                          text:
                              " ${feedBackController.netAdminRating.value.toStringAsFixed(1)}",
                          style: AppThemes.normalBlack45Font)
                    ],
                  ),
                ),
              ),
        Obx(
          () => Text(
            '${authController.userModel!.address ?? "London, Uk"}',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 12, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget profileCards(title, subtitle, icon) {
    return Container(
      width: 290,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppThemes.DEEP_ORANGE.withOpacity(0.3)),
      ),
      margin: EdgeInsets.only(left: 30, top: 12, right: 30, bottom: 3),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
        title: Text(
          '$title',
          style: GoogleFonts.poppins(
              fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          //'+92 302-5580842',
          '$subtitle',
          style: GoogleFonts.poppins(
              fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        leading: SvgPicture.asset(icon),
        trailing: title.toLowerCase() == "email"
            ? null
            : InkWell(
                onTap: () => showEditDialog(title, subtitle),
                child: Icon(
                  Icons.edit,
                  size: 20,
                  color: AppThemes.DEEP_ORANGE.withOpacity(0.8),
                ),
              ),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showEditDialog(title, subtitle) {
    authController.editTextFieldController.text = subtitle;

    Get.defaultDialog(
        title: "Update $title",
        titleStyle:
            AppThemes.dialogTitleHeader.copyWith(color: AppThemes.DEEP_ORANGE),
        content: Form(
          key: _formKey,
          child: FormInputFieldWithIcon(
            controller: authController.editTextFieldController,
            iconPrefix: Icons.title,
            labelText: title,
            autofocus: false,
            iconColor: AppThemes.DEEP_ORANGE,
            textStyle: AppThemes.normalBlackFont,
            validator: title.toString().toLowerCase() == "phone"
                ? Validator().number
                : Validator().notEmpty,
            keyboardType: title.toString().toLowerCase() == "phone"
                ? TextInputType.phone
                : TextInputType.text,
            onChanged: (value) => null,
            onSaved: (value) => null,
          ),
        ),
        confirm: PrimaryButton(
            buttonStyle: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                primary: AppThemes.DEEP_ORANGE,
                shape: StadiumBorder(),
                textStyle: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w400)),
            labelText: "Update",
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                SystemChannels.textInput.invokeMethod(
                    'TextInput.hide'); //to hide the keyboard - if any
                await authController.updateCurrentUser(title);
                Get.back();
              }
            }));
  }

  Widget _profileIconsContent() {
    return Obx(
      () => Container(
        child: GridView.count(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
          children:
              List.generate(authController.profileAvatarsList.length, (index) {
            ProfileAvatars profileAvatar =
                authController.profileAvatarsList[index];
            return InkWell(
              onTap: () {
                authController.updateProfileAvatar(profileAvatar);
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.network(
                    '${profileAvatar.url!}',
                    width: 40.0,
                    height: 40.0,
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppThemes.DEEP_ORANGE.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        50,
                      ),
                    ),
                    color: Colors.white),
              ),
            );
          }),
        ),
      ),
    );
  }
}
