import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class ShowGiveAnswerButtons extends StatelessWidget{
   ShowGiveAnswerButtons({
    Key? key,
    this.showAnswerForCurrentDate = true,
    this.activityModel,
  }) : super(key: key);
  final bool? showAnswerForCurrentDate; //for admin
  final DailyActivityModel? activityModel; //for student

  final DailyActivityController controller = Get.put(DailyActivityController());

  @override
  Widget build(BuildContext context) {

      if (AppCommons.isAdmin) return _buildShowAnswersToAdminButton();
      if (activityModel != null && activityModel!.qOfDay!.isNotEmpty) {
        if (showAnswerForCurrentDate!)
          controller.setCurrentDate(Timestamp.now());

      return Obx(()=> controller.checkIfStdGiveAnswer()!? _buildShowMyAnswerButton(): _buildGiveAnswerButton());

      } else
        return Container();

  }

  _buildShowAnswersToAdminButton() {
    if(activityModel!.qOfDay!.isEmpty)
      return Container();

    return PrimaryButton(
        buttonStyle: ElevatedButton.styleFrom(
          backgroundColor: AppThemes.dodgerPurple,
          shape: StadiumBorder(),
        ),
        labelText: 'Show Answers',
        textStyle: AppThemes.buttonFont,
        onPressed: () => {
              if (showAnswerForCurrentDate!)
                controller.setCurrentDate(Timestamp.now()),
              Get.to(() => AdminShowAnswersUI())
            });
  }

  _buildShowMyAnswerButton() {
    return PrimaryButton(
        buttonStyle: ElevatedButton.styleFrom(
          backgroundColor: AppThemes.dodgerPurple,
          shape: StadiumBorder(),
        ),
        labelText: 'Show my Answer',
        textStyle: AppThemes.normalBlackFont
            .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        onPressed: () => Get.to(() => StudentAnswerUI()));
  }

  _buildGiveAnswerButton() {
    return PrimaryButton(
        buttonStyle: ElevatedButton.styleFrom(
          backgroundColor: AppThemes.dodgerPurple,
          shape: StadiumBorder(),
        ),
        labelText: 'Give Answer',
        textStyle: AppThemes.normalBlackFont
            .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        onPressed: () => {showStudentAnswerBottomSheet()});
  }

  void showStudentAnswerBottomSheet() {
    Get.bottomSheet(
      AnswerBottomSheetContents(dailyActivityModel: activityModel),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      backgroundColor: Colors.white,
    );
  }
}
