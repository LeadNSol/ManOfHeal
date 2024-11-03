import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/components/base_widget.dart';
import 'package:man_of_heal/ui/components/custom_floating_action_button.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class UserManagementUI extends StatelessWidget {
  UserManagementUI({Key? key}) : super(key: key);

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      backgroundColor: AppThemes.BG_COLOR,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: AppThemes.blackPearl,
      child: body(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingButton: AppCommons.userModel != null &&
              AppCommons.userModel!.userType!.contains("superAdmin")
          ? Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(
                  right: 20,
                  bottom: AppConstant.getScreenHeight(context) * 0.25),
              child: CustomFloatingActionButton(
                onPressed: () => addInstructors(),
                // highlightElevation: 40,
                // elevation: 10,
                // hoverElevation: 12,
                //
        ),
            )
          : null,
    );
  }

  Widget body(context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          height: 225,
          top: 0,
          left: 0,
          right: 0,
          child: BlackRoundedContainer(),
        ),
        Positioned(
          child: Column(
            children: [
              FormVerticalSpace(height: 40,),

              CustomHeaderRow(
                title: "Admin",
                hasProfileIcon: true,
              ),
              FormVerticalSpace(
                height: AppConstant.getScreenWidth(context) *
                    (kIsWeb ? 0.07 : 0.25),
              ),
              CustomContainer(
                height: 90,
                child: Center(
                  child: Text(
                    "INSTRUCTORS",
                    style: AppThemes.normalBlack45Font.copyWith(fontSize: 30),
                  ),
                ),
              ),
              Obx(
                () => authController.adminUsersList.isEmpty
                    ? NoDataFound()
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: authController.adminUsersList.length,
                          itemBuilder: (_, index) {
                            UserModel? userModel =
                                authController.adminUsersList[index];
                            return SingleUserListItems(
                              userModel: userModel,
                              calledFor: 0,
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void addInstructors() {
    authController.setBtnState(0);
    Get.bottomSheet(
      _displayListUsers(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _displayListUsers(){
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Choose Instructor (Admin)",
                style: AppThemes.headerTitleBlackFont,
              ),
            ),
          ),
          Expanded(
            child: Obx(
                  () => ListView.builder(
                shrinkWrap: true,
                itemCount: authController.usersList.length,
                itemBuilder: (_, index) {
                  UserModel userModel = authController.usersList[index];
                  if (userModel.isAdmin!) return Container();
                  return SingleUserListItems(
                    userModel: userModel,
                    calledFor: 1,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }


}

class SingleUserListItems extends StatelessWidget {
  SingleUserListItems({Key? key, this.userModel, this.calledFor = 0})
      : super(key: key);

  final UserModel? userModel;

  /*
   * @calledFor 0. default calling
   *  1. called for selection of instructor
   * 2. called for Student answer section i.e. display students
   * */
  final int? calledFor;

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CustomContainer(
        child: Row(
          children: [
            Expanded(
              child: CircularAvatar(
                padding: 3,
                imageUrl: userModel?.photoUrl!,
                radius: calledFor == 2 ? 30 : 20,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel!.name??"",
                    style: AppThemes.header2
                        .copyWith(color: AppThemes.DEEP_ORANGE),
                  ),
                  userModel!.userType != null
                      ? Text(
                          userModel!.userType!,
                          style: AppThemes.normalBlackFont
                              .copyWith(fontSize: 11, color: Colors.blue[300]!),
                        )
                      : Container(),
                  Text(
                    userModel!.email??"",
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppThemes.normalBlackFont.copyWith(fontSize: 11),
                  ),
                  Text(
                    userModel!.phone??"",
                    style: AppThemes.normalBlackFont.copyWith(fontSize: 11),
                  ),
                  Text(
                    userModel!.address ?? "",
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppThemes.normalBlackFont.copyWith(fontSize: 11),
                  ),
                  calledFor == 2
                      ? Container()
                      : _textWidget(
                          "created at",
                          AppConstant.formattedDataTime(
                              "yyyy-MMM-dd", userModel!.createdDate ?? Timestamp.now())),
                ],
              ),
            ),
            if (authController.userModel != null &&
                authController.userModel!.userType!
                    .contains(UserGroup.superAdmin.name))
            calledFor == 1
                ? Expanded(
                    child: InkWell(
                      onTap: () =>showSelectAdminConfirmationDialog(userModel!),
                      child: Text(
                        "Select as Admin",
                        style: AppThemes.normalORANGEFont.copyWith(
                            fontSize: 12, color: AppThemes.rightAnswerColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : (userModel!.userType != null &&
                        userModel!.userType == UserGroup.superAdmin.name)
                    ? Container()
                    : calledFor == 2
                        ? Container()
                        : showRemoveBtn()
          ],
        ),
      ),
    );
  }

  Widget showRemoveBtn() {
    return userModel!.userType != UserGroup.superAdmin.name
        ? Expanded(
            child: InkWell(
              onTap: () => showDeleteConfirmationDialog(userModel!),
              child: Text(
                "Remove",
                style: AppThemes.normalORANGEFont.copyWith(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          )
        : Container();
  }

  Widget _textWidget(title, value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: "$title: ",
              style: AppThemes.normalBlackFont.copyWith(fontSize: 11)),
          TextSpan(
              text: value,
              style: AppThemes.normalBlack45Font.copyWith(fontSize: 11))
        ],
      ),
    );
  }

  void showDeleteConfirmationDialog(UserModel userModel) {
    Get.defaultDialog(
      title: "Delete User!",
      titleStyle:
          AppThemes.dialogTitleHeader.copyWith(color: AppThemes.DEEP_ORANGE),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Are you sure you want to delete this ${userModel.name!}?",
              style: AppThemes.normalBlackFont,
            ),
            FormVerticalSpace(),
            buildDeleteDialogUI(),
            FormVerticalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  width: 100,
                  child: PrimaryButton(
                      labelText: 'No',
                      textStyle: AppThemes.buttonFont,
                      onPressed: () => Get.back()),
                ),
                Container(
                  width: 100,
                  child: PrimaryButton(
                    labelText: 'Yes',
                    textStyle: AppThemes.buttonFont,
                    onPressed: () {
                      userModel.isAdmin = false;
                      userModel.userType = UserGroup.student.name;
                      authController.updateUser(userModel);
                      Get.back();
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showSelectAdminConfirmationDialog(UserModel userModel) {
    Get.defaultDialog(
      title: "Admin Selection!",
      titleStyle:
      AppThemes.dialogTitleHeader.copyWith(color: AppThemes.DEEP_ORANGE),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "This operation will wiped out all activities of `${userModel.name}` as Student.\nAre you sure to select `${userModel.name!}` as Admin (Instructor)?",
              style: AppThemes.normalBlackFont,
            ),
            FormVerticalSpace(),
            buildLabInstructionIcon(),
            FormVerticalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Container(
                  width: 100,
                  child: PrimaryButton(
                      labelText: 'No',
                      textStyle: AppThemes.buttonFont,
                      onPressed: () => Get.back()),
                ),
                Container(
                  width: 100,
                  child: PrimaryButton(
                    labelText: 'Yes',
                    textStyle: AppThemes.buttonFont,
                    onPressed: () {
                      userModel.isAdmin = true;
                      userModel.userType = UserGroup.admin.name;
                      authController.updateUser(userModel);
                      Get.back();
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
