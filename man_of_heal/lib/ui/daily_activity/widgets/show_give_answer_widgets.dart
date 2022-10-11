import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/daily_activity_model.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/ui/daily_activity/my_answers/student_answers_ui.dart';
import 'package:man_of_heal/ui/daily_activity/my_answers/widgets/answer_bottom_sheet_contents.dart';
import 'package:man_of_heal/ui/daily_activity/show_answers/admin_show_answers_ui.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class ShowGiveAnswerButtons extends StatelessWidget {
  const ShowGiveAnswerButtons({
    Key? key,
    this.showAnswerForCurrentDate = true,
    this.activityModel,
  }) : super(key: key);
  final bool? showAnswerForCurrentDate; //for admin
  final DailyActivityModel? activityModel; //for student
  @override
  Widget build(BuildContext context) {


    return Obx(() {
      if (authController.admin.isTrue) return _buildShowAnswersToAdminButton();
      if (activityModel != null && activityModel!.qOfDay!.isNotEmpty) {
        if (showAnswerForCurrentDate!)
          dailyActivityController.setCurrentDate(Timestamp.now());

        if (dailyActivityController.checkIfStdGiveAnswer()!)
          return _buildShowMyAnswerButton();
        else {
          return _buildGiveAnswerButton();
        }
      } else
        return Container();
    });
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
                dailyActivityController.setCurrentDate(Timestamp.now()),
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
