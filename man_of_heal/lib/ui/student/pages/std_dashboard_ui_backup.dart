import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/ui/profile/profile_ui.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class StudentDashboardUIBACKUP extends StatelessWidget {
  //const StudentDashboardUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:AppThemes.BG_COLOR,
        appBar: AppBar(
          backgroundColor: AppThemes.blackPearl,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        //body: VDBody(),
        body: dashBoard(context),

        /*Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'User email: ${authController.firebaseUser.value!.email} \n Type: ${authController.admin.value ? 'Admin' : 'Student'}',
              style: TextStyle(fontSize: 24),
            ),
            FormVerticalSpace(
              height: 25.0,
            ),
            Center(
              child: Text(
                'Student Dash Board coming Soon',
                style: TextStyle(fontSize: 18, color: Colors.deepPurple),
              ),
            )
          ],
        ),*/
      ),
    );
  }

  Widget dashBoard(context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        child: Column(
          children: [
            // top header with black background...
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  //Background rounded bottom left, right black color
                  Container(
                    decoration: BoxDecoration(
                      color: AppThemes.blackPearl,
                      /*borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),*/
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10),
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
                                      text: 'Welcome John Smith!',
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
                        Expanded(child: Center()),
                      ],
                    ),
                  )
                ],
              ),
            ),

            /*
            * gray container for...
            * */

            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight / 1.4,
              decoration: BoxDecoration(
                color: AppThemes.BG_COLOR,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
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
                      top: -constraints.maxHeight * 0.10,
                      child: Container(
                        width: constraints.maxWidth * 0.9,
                        height: constraints.maxWidth * 0.40,
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          color: AppThemes.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(4, 8),
                                blurStyle: BlurStyle.normal // Shadow position
                                ),
                          ],
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customRichText(
                                  textTheme,
                                  "Question of the day",
                                  "In medicine the MMR vaccination gives "
                                      "protection against which diseases?"),
                              customRichText(textTheme, "Term of the day",
                                  "Term of the day will goes here!"),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /*
                    * Dashboard Items
                    * */
                    Positioned(
                      top: constraints.maxWidth / 3,
                      left: constraints.maxWidth / 8.5,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: constraints.maxWidth / 1.5,
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
                                    constraints,
                                    "assets/icons/questions_icon.svg",
                                    "Questions"),
                                SizedBox(
                                  width: 10,
                                ),
                                customDashboardItems(context, constraints,
                                    "assets/icons/qod_icon.svg", "QOD"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customDashboardItems(context, constraints,
                                    "assets/icons/lab_icon.svg", "Labs"),
                                SizedBox(
                                  width: 10,
                                ),
                                customDashboardItems(context, constraints,
                                    "assets/icons/quiz_icon.svg", "Quiz"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget customDashboardItems(context, constraints, image, name) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: constraints.maxWidth * 0.3,
      height: constraints.maxWidth * 0.3,
      decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(color: AppThemes.DEEP_ORANGE.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            width: 35,
            height: 35,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "$name",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  //Top card item
  Widget customRichText(TextTheme textTheme, title, subtitle) {
    /* return RichText(
      text: TextSpan(
        text: '$title \n',
        style: textTheme.headline6!.apply(color: AppThemes.DEEP_ORANGE),
        children: <TextSpan>[
          TextSpan(
              text: '$subtitle!',
              style: textTheme.caption!.copyWith(color: Colors.black54)),
        ],
      ),
    );*/
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.headline6!.copyWith(color: AppThemes.DEEP_ORANGE),
        ),
        Text(
          subtitle,
          style: textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
