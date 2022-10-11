import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/student_answer_model.dart';
import 'package:man_of_heal/models/user_model.dart';
import 'package:man_of_heal/ui/components/black_rounded_container.dart';
import 'package:man_of_heal/ui/components/circular_avatar.dart';
import 'package:man_of_heal/ui/components/custom_container.dart';
import 'package:man_of_heal/ui/components/custom_header_row.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class QODAnswerDetails extends StatelessWidget {
  const QODAnswerDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppThemes.BG_COLOR,
        body: answerBody(context),
        //_answerBody(context),
      ),
    );
  }

  Widget answerBody(BuildContext context) {
    StdAnswerModel? stdAnswerModel = dailyActivityController.stdAnswerModel.value;
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 225,
          child: BlackRoundedContainer(),
        ),
        Positioned(
          child: Obx(
            ()=>ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                FormVerticalSpace(),
                CustomHeaderRow(
                  title: "Status",
                  hasProfileIcon: true,
                ),
                FormVerticalSpace(
                  height: AppConstant.getScreenHeight(context) * 0.12,
                ),
                CustomContainer(
                  hasOuterShadow: true,
                  height: AppConstant.getScreenHeight(context) * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AppConstant.textWidget("Answer", stdAnswerModel.answer,
                          AppThemes.normalBlackFont),

                      AppConstant.textWidget("Question",
                          stdAnswerModel.questionId, AppThemes.normalBlackFont),
                      Obx(
                        () => authController.admin.isTrue &&
                                stdAnswerModel.checkBy == null
                            ? approveAnswer()
                            :  stdAnswerModel.checkBy !=null?Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Answered By",
                                    style: AppThemes.headerItemTitle.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  FormVerticalSpace(
                                    height: 10,
                                  ),

                                  answerBy(stdAnswerModel),
                                ],
                              ):Container(),
                      ),

                      //FormVerticalSpace(height: 10,),
                      ///bottom footer
                      authController.admin.isTrue
                          ? _footerAdmin()
                          : _footerStudent()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget approveAnswer() {
    return Container(
      width: 200,
      child: PrimaryButton(
        labelText: 'Approve Answer',
        textStyle: AppThemes.buttonFont,
        onPressed: () {
          Get.defaultDialog(
            title: "Rate Answer",
            titleStyle: AppThemes.headerItemTitle,
            content: getContents(),
          );
        },
      ),
    );
  }

  Widget getContents() {
    final iconColor = AppThemes.DEEP_ORANGE;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: RatingBar(
            initialRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            onRatingUpdate: (value) {
              feedBackController.rating.value = value;
            },
            ratingWidget: RatingWidget(
              full: Image.asset(
                'assets/icons/heart.png',
                color: iconColor,
              ),
              half: Image.asset(
                'assets/icons/heart_half.png',
                color: iconColor,
              ),
              empty: Image.asset(
                'assets/icons/heart_border.png',
                color: iconColor,
              ),
            ),
          ),
        ),
        FormVerticalSpace(
          height: 5,
        ),
        Align(
          alignment: Alignment.center,
          child: Obx(
            () => Text(
              "Ratings: ${feedBackController.rating.value}",
              style: AppThemes.normalBlackFont,
            ),
          ),
        ),
        Center(
          child: Container(
            width: 150,
            child: PrimaryButton(
              buttonStyle: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                backgroundColor: AppThemes.DEEP_ORANGE,
                shape: StadiumBorder(),
              ),
              labelText: 'Submit',
              textStyle: AppThemes.buttonFont,
              onPressed: () {
                if (feedBackController.rating.value > 0) {
                 StdAnswerModel? stdAnswerModel = dailyActivityController.stdAnswerModel.value;
                  stdAnswerModel.answerRating =
                      feedBackController.rating.value.toString();
                  stdAnswerModel.checkBy = authController.userModel!.uid;
                  stdAnswerModel.checkingDate = Timestamp.now();
                  dailyActivityController.updateStudentAnswer(stdAnswerModel);
                  //Get.back();
                  //print('added');
                } else
                  AppConstant.displaySnackBar(
                      "Alert!", "Rating must not be Zero");
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget answerBy(StdAnswerModel model) {
    UserModel? userModel =
        authController.getAdminFromListById(model.checkBy!.trim());

    feedBackController.fetchCurrentAdminFeedBack(userModel: userModel);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircularAvatar(
          padding: 1,
          radius: 20,
          imageUrl: userModel!.photoUrl!,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${userModel.name}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppThemes.normalBlackFont,
            ),
            Obx(
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
                        text: " ${feedBackController.netAdminRating.value}",
                        style: AppThemes.normalBlack45Font)
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _footerAdmin() {
    StdAnswerModel? stdAnswerModel = dailyActivityController.stdAnswerModel.value;
    return Obx(
     ()=> Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Image.asset(
                    "assets/icons/estimated_time_icon.png",
                    width: 13,
                  ),
                ),
                TextSpan(
                  text: "  Start Time",
                  style: AppThemes.normalBlackFont
                      .copyWith(color: Colors.black, fontSize: 9),
                ),
              ],
            ),
          ),
          FormVerticalSpace(height: 5),
          Text(
            '${AppConstant.formattedDataTime("hh:mm a, MMM dd yyyy", stdAnswerModel.answerDate!)}',
            style: AppThemes.header2,
          ),
          FormVerticalSpace(height: 5),
          statusAtFooter(),
        ],
      ),
    );
  }

  Widget _footerStudent() {
    StdAnswerModel? stdAnswerModel = dailyActivityController.stdAnswerModel.value;
    return Obx(
      ()=> Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Image.asset(
                    "assets/icons/estimated_time_green_icon.png",
                    width: 13,
                  ),
                ),
                TextSpan(
                  text: " Checked Time",
                  style: AppThemes.normalBlackFont
                      .copyWith(color: Colors.black, fontSize: 9),
                ),
              ],
            ),
          ),
          FormVerticalSpace(height: 5),
          Text(
            '${AppConstant.formattedDataTime("hh:mm a, MMM dd yyyy", stdAnswerModel.checkBy != null ? stdAnswerModel.checkingDate! : stdAnswerModel.answerDate!)}',
            style: AppThemes.header2,
          ),
          FormVerticalSpace(
            height: 5,
          ),
          statusAtFooter(),
        ],
      ),
    );
  }

  statusAtFooter() {
    StdAnswerModel? stdAnswerModel = dailyActivityController.stdAnswerModel.value;
    return
     RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: "Answer Status:   ",
                style: AppThemes.header2.copyWith(color: Colors.black)),
            stdAnswerModel.checkBy != null
                ? TextSpan(
                    text: "Approved",
                    style: AppThemes.header2.copyWith(color: Colors.green))
                : TextSpan(
                    text: "Not Approved",
                    style: AppThemes.header2.copyWith(color: Colors.redAccent),
                  )
          ],
        ),
      );

  }
}
