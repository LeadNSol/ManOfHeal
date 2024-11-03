import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/components/base_widget.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

import 'profile_controller.dart';

class ProfileUI extends StatelessWidget {

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      resizeToAvoidBottomInset: true,
      statusBarIconBrightness: Brightness.light,
      child: bodyNew(context),
    );
  }

  Widget bodyNew(context) {
    //feedBackController.fetchCurrentAdminFeedBack(authController.userModel!);
    /*  int daysLeft = AppConstant.daysBetween(
        subscriptionController.subsFirebase!.expiresAt!.toDate(),
        DateTime.now());*/
    return Stack(
      fit: StackFit.passthrough,
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
              FormVerticalSpace(height: 40),
              /// Header
              CustomHeaderRow(
                title: "Profile",
                hasProfileIcon: false,
                isAdmin: AppCommons.isAdmin,
              ),
              FormVerticalSpace(height: 80),

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
                            imageUrl: AppCommons.userModel!.photoUrl!,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: InkWell(
                          onTap: () {
                            Get.bottomSheet(_profileIconsContent(),
                                backgroundColor: AppThemes.white);

                            /* Get.defaultDialog(
                              title: "Choose Profile Avatar",
                              titleStyle: AppThemes.dialogTitleHeader
                                  .copyWith(color: AppThemes.DEEP_ORANGE),
                              content: _profileIconsContent(),
                              //confirm: _btnSCameraAndGallery(),
                            );*/
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
                  FormVerticalSpace(height: 5),
                  _nameAndRatingWidget(context),
                  FormVerticalSpace(
                    height: 15,
                  ),
                  if(!AppCommons.isAdmin)
                  Column(
                    children: [
                      Image.asset(
                        "assets/icons/premium_member.png",
                      ),
                      FormVerticalSpace(
                        height: 10,
                      ),
                      controller.getSubsModel()?.studentId == null
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
                              "${controller.getSubsModel()?.planName ?? ""} Member \n "
                              "Days left: ${controller.getSubscriptionExpiry() > 0 ? controller.getSubscriptionExpiry() : "Expired"}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  color: AppThemes.PREMIUM_OPTION_COLOR,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                      FormVerticalSpace(height: 15),
                    ],
                  ),
                ],
              ),

              /// card profile data, e.g. phone, email, address
              Obx(
                () => ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(5),
                  children: controller
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
                    onPressed: () {
                      // authController.disposeGetXControllers();
                      AppCommons.authController.signOut();
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
                    return Text("version: ${controller.appVersion.value}");
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
                '${AppCommons.userModel!.name ?? 'ABC NAME'}',
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
                  showEditDialog("name", AppCommons.userModel!.name),
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
        !AppCommons.isAdmin
            ? Container()
            : RichText(
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
                  " ${controller.getAdminRating().toStringAsFixed(1)}",
                  style: AppThemes.normalBlack45Font)
            ],
          ),
        ),
        Obx(
          () => Text(
            '${AppCommons.userModel!.address ?? "London, Uk"}',
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
    controller.editTextFieldController.text = subtitle;

    Get.defaultDialog(
        title: "Update $title",
        titleStyle:
            AppThemes.dialogTitleHeader.copyWith(color: AppThemes.DEEP_ORANGE),
        content: Form(
          key: _formKey,
          child: FormInputFieldWithIcon(
            controller: controller.editTextFieldController,
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
            labelText: "Update",
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                SystemChannels.textInput.invokeMethod(
                    'TextInput.hide'); //to hide the keyboard - if any
                await controller.updateCurrentUser(title);
                Get.back();
              }
            }));
  }

  Widget _profileIconsContent() {
    print(">>>ProfileAvatars: ${controller.profileAvatarsList.length}");
    return Obx(
      () => GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.all(10),
        shrinkWrap: true,
        children:
            List.generate(controller.profileAvatarsList.length, (index) {
          ProfileAvatars profileAvatar =
              controller.profileAvatarsList[index];
          return InkWell(
            onTap: () {
              controller.updateProfileAvatar(profileAvatar);
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
    );
  }
}
