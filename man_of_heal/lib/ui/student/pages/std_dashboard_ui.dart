import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/ui/daily_acitivity_screen.dart';
import 'package:man_of_heal/ui/daily_activity/daily_activity_ui.dart';
import 'package:man_of_heal/ui/labs/labs_ui.dart';
import 'package:man_of_heal/ui/profile/profile_ui.dart';
import 'package:man_of_heal/ui/student/pages/vignette_dissection/vignette_dissection_ui.dart';
import 'package:man_of_heal/utils/app_themes.dart';

import 'vignette_dissection/instructions_page.dart';

class StudentDashboardUI extends StatelessWidget {
  //const StudentDashboardUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppThemes.BG_COLOR,
        resizeToAvoidBottomInset: false,
        body: dashBoard(context),
      ),
    );
  }

  Widget dashBoard(context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            // top header with black background...
            Expanded(
              flex: 2,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  //Background rounded bottom left, right black color
                  Container(
                    decoration: BoxDecoration(
                      color: AppThemes.blackPearl,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Header profile icon and Dashboard Text...
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Dashboard \n',
                                style: textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppThemes.white),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          'Welcome ${authController.userModel.value!.name}',
                                      style: textTheme.caption!.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppThemes.white)),
                                ],
                              ),
                            ),

                            //profile icon
                            InkWell(
                              onTap: () {
                                Get.to(ProfileUI());
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Image.network(
                                      "https://cdn-icons-png.flaticon.com/128/3011/3011270.png"),
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

                  Positioned(
                    top: constraints.maxHeight * 0.28,
                    child: Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      decoration: BoxDecoration(
                        color: AppThemes.BG_COLOR,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            /*
                           *  Question and Term of the day Section
                          *
                           * */
                            Positioned(
                              top: -constraints.maxWidth * 0.14,
                              left: constraints.maxWidth * 0.028,
                              child: GestureDetector(
                                onTap: () {
                                  print('question of the day.');
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => DailyActivityScreen()));
                                },
                                child: Container(
                                  width: constraints.maxWidth * 0.89,
                                  height: constraints.maxWidth * 0.40,
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                    color: AppThemes.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppThemes.DEEP_ORANGE
                                              .withOpacity(0.22),
                                          blurRadius: 13,
                                          spreadRadius: 2,
                                          offset: Offset(0, 1),
                                          blurStyle:
                                              BlurStyle.inner // Shadow position
                                          ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        customRichText(
                                            textTheme,
                                            "Question of the day",
                                            "In medicine the MMR vaccination gives "
                                                "protection against which diseases?"),
                                        customRichText(
                                            textTheme,
                                            "Term of the day",
                                            "Term of the day will goes here!"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            /*
                            * Dashboard Items
                             * */
                            Positioned(
                              top: constraints.maxWidth / 4,
                              left: constraints.maxWidth * 0.05,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                height: constraints.maxWidth,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        customDashboardItems(context, () {
                                          //answerAndQuestion screen is on 1 position at students page list
                                          landingPageController
                                              .setCalledFor("Questions");
                                          landingPageController
                                              .setStudentPage(1);
                                        },
                                            constraints,
                                            "assets/icons/questions_icon.svg",
                                            "Questions"),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        customDashboardItems(context, () {
                                          Get.to(DailyActivityUI());
                                        }, constraints,
                                            "assets/icons/qod_icon.svg", "QOD"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        customDashboardItems(
                                            context,
                                            () => Get.to(LabsUI()),
                                            constraints,
                                            "assets/icons/lab_icon.svg",
                                            "Labs"),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        customDashboardItems(context, () {
                                          //Get.to(VignetteDissectionUI());
                                          Get.to(QuizInstructionsScreen());
                                        },
                                            constraints,
                                            "assets/icons/quiz_icon.svg",
                                            "Quiz"),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget customDashboardItems(context, onTap, constraints, image, name) {
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
              height: 10,
            ),
            Text(
              "$name",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.bold),
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
