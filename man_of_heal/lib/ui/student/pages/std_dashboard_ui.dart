import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/user_model.dart';
import 'package:man_of_heal/ui/components/circular_avatar.dart';
import 'package:man_of_heal/ui/components/custom_container.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/daily_activity/daily_activity_screen.dart';
import 'package:man_of_heal/ui/labs/widgets/lab_instruction_ui.dart';
import 'package:man_of_heal/ui/notifications/widgets/notification_badge_ui.dart';
import 'package:man_of_heal/ui/profile/profile_ui.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';

import 'vignette_dissection/instructions_page.dart';

class StudentDashboardUI extends StatefulWidget {
  const StudentDashboardUI({Key? key}) : super(key: key);

  @override
  State<StudentDashboardUI> createState() => _StudentDashboardUIState();
}

class _StudentDashboardUIState extends State<StudentDashboardUI> {
  @override
  Widget build(BuildContext context) {
    if (authController.userModel!.isTrailFinished != null &&
        !authController.userModel!.isTrailFinished!) {
      if (authController.isTrailDialogFirstTimeOpen() != null &&
          !authController.isTrailDialogFirstTimeOpen()) {
        Future.delayed(Duration.zero, () => showTrailNotifyDialog(context));
        authController.setIsTrialDialogFirstTimeOpen(true);
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppThemes.blackPearl,
        resizeToAvoidBottomInset: false,
        body: newDashboard(context),
      ),
    );
  }

  Widget newDashboard(context) {
    return Stack(
      children: [
        /// pink background
        Positioned(
          top: AppConstant.getScreenHeight(context) * 0.23,
          left: 0,
          child: Container(
            width: AppConstant.getScreenWidth(context),
            height: AppConstant.getScreenHeight(context),
            decoration: BoxDecoration(
              color: AppThemes.BG_COLOR,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
            ),
          ),
        ),

        /// headers
        Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Header profile icon and Dashboard Text...
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: kIsWeb ? 5 : 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Dashboard", style: AppThemes.headerTitleFont),
                        Text('Welcome ${authController.userModel!.name}',
                            style: GoogleFonts.montserrat(
                                fontSize: 10, color: Colors.white)),
                        FormVerticalSpace(
                          height: 5,
                        ),
                        Obx(
                          () => authController.userModel!.trialExpiryDate !=
                                      null &&
                                  authController.userModel!.isTrailFinished!
                              ? Container()
                              : trailPeriodCounter(AppThemes.white, 13),
                        ),
                      ],
                    ),
                  ),
                  NotificationBadgeUI(),
                  SizedBox(
                    width: 5,
                  ),
                  //profile icon
                  InkWell(
                    onTap: () {
                      Get.to(() => ProfileUI());
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white,
                      ),
                      child: Obx(
                        () => CircularAvatar(
                          padding: 1,
                          imageUrl: authController.userModel!.photoUrl!,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //FormVerticalSpace(),
              const Spacer(),
            ],
          ),
        ),

        ///QOQ and TOD
        Obx(
          ()=> CustomContainer(
            margin: const EdgeInsets.only(top: 120, left: 15, right: 15),
            height: kIsWeb ? 120 : 150,
            child: InkWell(
              onTap: () => Get.to(() => DailyActivityScreen()),
              child: Column(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Question Of The Day',
                        style: AppThemes.headerTitle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${dailyActivityController.model!.qOfDay!.isNotEmpty ? dailyActivityController.model!.qOfDay : AppConstant.noTODFound}',
                        style: AppThemes.normalBlackFont,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Term Of The Day',
                        style: AppThemes.headerTitle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${dailyActivityController.model!.termOfDay!.isNotEmpty ? dailyActivityController.model!.termOfDay : AppConstant.noTODFound}',
                        style: AppThemes.normalBlackFont,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.only(
              top: AppConstant.getScreenHeight(context) * (kIsWeb ? 0.4 : 0.3),
              left: 15,
              right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customDashboardItems(
                      context,
                      () => landingPageController.setStudentPage(1),
                      "assets/icons/questions_icon.svg",
                      "Questions"),
                  SizedBox(
                    width: 10,
                  ),
                  customDashboardItems(
                      context,
                      () => Get.to(() => DailyActivityScreen()),
                      "assets/icons/qod_icon.svg",
                      "QOD"),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customDashboardItems(
                      context,
                      () => Get.to(() => LabInstructionUI()),
                      "assets/icons/lab_icon.svg",
                      "Labs"),
                  SizedBox(
                    width: 10,
                  ),
                  customDashboardItems(context, () {
                    //Get.to(()=>VignetteDissectionUI());
                    Get.to(() => QuizInstructionsScreen());
                  }, "assets/icons/quiz_icon.svg", "Quiz"),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget trailPeriodCounter(color, double fontSize) {
    if (authController.userModel!.isTrailFinished == null) return Container();

    int endTime =
        authController.userModel!.trialExpiryDate!.millisecondsSinceEpoch;

    return CountdownTimer(
      endTime: endTime,
      widgetBuilder: (context, CurrentRemainingTime? time) {
        if (time == null) {
          UserModel userModel = authController.userModel!;
          userModel.isTrailFinished = true;
          authController.updateUser(userModel);
          return Text(
            'Trail Overs',
            style: GoogleFonts.poppins(
                fontSize: fontSize, color: color, fontWeight: FontWeight.w700),
          );
        }
        return Text('Trials ends in: ${AppConstant.getFormattedTime(time)}',
            style: GoogleFonts.poppins(
                fontSize: fontSize, color: color, fontWeight: FontWeight.w700));
      },
    );
  }


  showTrailNotifyDialog(context) {
    if (!Get.isDialogOpen!)
      Get.defaultDialog(
        title: "Trail Notifier",
        titleStyle: AppThemes.headerItemTitle,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: "Congratulations!\n",
                  style: AppThemes.normalORANGEFont,
                ),
                TextSpan(
                  text:
                      "You have got trials and have FREE access to Ask Questions for next 7 days!\n",
                  style: AppThemes.normalBlack45Font,
                ),
              ]),
            ),
            trailPeriodCounter(AppThemes.DEEP_ORANGE, 20),
          ],
        ),
      );
  }

  Widget customDashboardItems(context, onTap, image, name) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        width: 135,
        height: 122,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            border: Border.all(color: AppThemes.DEEP_ORANGE.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              width: 50,
              height: 50,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "$name",
              style: AppThemes.normalBlackFont,
            )
          ],
        ),
      ),
    );
  }

  //Top card item
  Widget customRichText(TextTheme textTheme, title, subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.headline6!.copyWith(color: AppThemes.DEEP_ORANGE),
        ),
        Text(
          subtitle,
          style: textTheme.subtitle2!.copyWith(fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
