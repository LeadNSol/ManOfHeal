import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class QuizInstructionsScreen extends GetView<VDController> {
  final instructionList = [
    "1 mark award for correct answer and no mark for incorrect answer.",
    "Tap on option to select the correct answer.",
    "Tap on the save button to save progress.",
    "Complete quiz before time ends."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.BG_COLOR,
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// black background
          Positioned(
              top: 0,
              height: 225,
              left: 0,
              right: 0,
              child: BlackRoundedContainer()),

          Positioned(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                FormVerticalSpace(
                  height: 50,
                ),
                CustomHeaderRow(
                  title: "Quiz Instructions",
                  hasProfileIcon: true,
                ),
                CustomContainer(
                  height: 130.0.sp,
                  margin: EdgeInsets.only(
                    left: 17.0.sp,
                    right: 17.0.sp,
                    top: 75.sp,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Instructions about quiz',
                            style: GoogleFonts.poppins(
                              fontSize: 17.46.sp,
                              color: Color(0xffFC2125),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Before start quiz, please carefully read instructions.',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.poppins(
                              fontSize: 14.28.sp,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.0.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 136.62.w,
                      height: 120.03.h,
                      margin: EdgeInsets.only(
                        right: 5.0.w,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 12.0.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.11.r),
                        color: Colors.white.withOpacity(0.5),
                        border: Border.all(
                          width: 1.0.w,
                          color: Color(0xffFC2125).withOpacity(0.5),
                        ),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const ClampingScrollPhysics(),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildQuestionMarkSvg(),
                              Obx(
                                () => Text(
                                  '${controller.quizQuestionsList.length} Questions',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffFC2125).withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0.h),
                          Text(
                            '10 points for correct answer',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 136.62.w,
                      height: 120.03.h,
                      margin: EdgeInsets.only(
                        left: 5.0.w,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 12.0.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.11.r),
                        color: Colors.white.withOpacity(0.5),
                        border: Border.all(
                          width: 1.0.w,
                          color: AppThemes.DEEP_ORANGE.withOpacity(0.5),
                        ),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const ClampingScrollPhysics(),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildTimerSvg(),
                              Obx(
                                () => Text(
                                  '${controller.duration.value} Mints',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        AppThemes.DEEP_ORANGE.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0.h),
                          Text(
                            'Total duration of quiz',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0.sp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: instructionList
                      .map((e) => singleInstructionItems(e))
                      .toList(),
                ),
                SizedBox(height: 20.0.sp),
                Center(
                  child: Container(
                    width: 300,
                    height: 50,
                    child: PrimaryButton(
                      labelText: 'Start quiz',
                      textStyle: AppThemes.buttonFont,
                      onPressed: () async {
                        if (controller.quizID.value != "") {
                          await controller.findUserAttemptedQuiz();
                          controller.resetAllValues();
                          if (controller.hasAlreadyAttemptTheQuiz.value) {
                            Get.to(() => LeaderBoardUI());
                            AppConstant.displayNormalSnackBar("Attempt Alert!",
                                "You have already Attempt the previous Quiz!");
                          } else {
                            Get.to(() => VignetteDissectionUI());
                          }
                        } else {
                          AppConstant.displayNormalSnackBar(
                              "Quiz Alert", "No Quiz is uploaded yet!");
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20.0.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SvgPicture buildTimerSvg() {
    return SvgPicture.string(
      // Icon ionic-ios-time
      '<svg viewBox="210.0 334.48 33.47 33.47" ><path transform="translate(206.63, 331.1)" d="M 20.109375 3.375 C 29.35350799560547 3.375 36.84375 10.86524200439453 36.84375 20.109375 C 36.84375 29.35350799560547 29.35350799560547 36.84375 20.109375 36.84375 C 10.8652400970459 36.84375 3.375 29.35350799560547 3.375 20.109375 C 3.375 10.8652400970459 10.8652400970459 3.375 20.109375 3.375 Z M 18.98302268981934 21.55754089355469 C 18.98302268981934 22.17703437805176 19.4898796081543 22.68389320373535 20.109375 22.68389320373535 L 27.83293151855469 22.68389320373535 C 28.45242500305176 22.68389320373535 28.95928382873535 22.17703437805176 28.95928382873535 21.55754089355469 C 28.95928382873535 20.93804740905762 28.45242500305176 20.43118858337402 27.83293151855469 20.43118858337402 L 21.23572540283203 20.43118858337402 L 21.23572540283203 9.811298370361328 C 21.23572540283203 9.191803932189941 20.72886848449707 8.684945106506348 20.109375 8.684945106506348 C 19.4898796081543 8.684945106506348 18.98302268981934 9.191803932189941 18.98302268981934 9.811298370361328 L 18.98302268981934 21.55754089355469 Z" fill="#fc2125" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
      width: 30.47.w,
      height: 30.47.h,
    );
  }

  SvgPicture buildQuestionMarkSvg() {
    return SvgPicture.string(
      // Icon awesome-question-circle
      '<svg viewBox="53.99 334.48 34.88 34.88" ><path transform="translate(53.42, 333.91)" d="M 35.4375 18 C 35.4375 27.63260269165039 27.62978935241699 35.4375 18 35.4375 C 8.370210647583008 35.4375 0.5625 27.63260078430176 0.5625 18 C 0.5625 8.37302303314209 8.370210647583008 0.5625 18 0.5625 C 27.62978935241699 0.5625 35.4375 8.373023986816406 35.4375 18 Z M 18.46792984008789 6.328125 C 14.63610935211182 6.328125 12.19218826293945 7.942289352416992 10.27307796478271 10.81110954284668 C 10.02445316314697 11.18278121948242 10.10763263702393 11.68403911590576 10.46397686004639 11.95425033569336 L 12.9037504196167 13.80417251586914 C 13.26972675323486 14.08169555664062 13.79116439819336 14.01567268371582 14.07550811767578 13.65496921539307 C 15.33157062530518 12.06182861328125 16.19282913208008 11.13799285888672 18.1046257019043 11.13799285888672 C 19.54104042053223 11.13799285888672 21.3177661895752 12.06246185302734 21.3177661895752 13.45535278320312 C 21.3177661895752 14.50835227966309 20.4484920501709 15.04912662506104 19.03022003173828 15.84428977966309 C 17.37618827819824 16.77149963378906 15.1875 17.92553901672363 15.1875 20.8125 L 15.1875 21.09375 C 15.1875 21.55971145629883 15.56528949737549 21.9375 16.03125 21.9375 L 19.96875 21.9375 C 20.43471145629883 21.9375 20.8125 21.55971145629883 20.8125 21.09375 L 20.8125 21.00002288818359 C 20.8125 18.99878883361816 26.6615161895752 18.91546821594238 26.6615161895752 13.5 C 26.6615161895752 9.421733856201172 22.4311637878418 6.328125 18.46792984008789 6.328125 Z M 18 23.765625 C 16.21652412414551 23.765625 14.765625 25.21652412414551 14.765625 27 C 14.765625 28.78340530395508 16.21652412414551 30.234375 18 30.234375 C 19.78347587585449 30.234375 21.234375 28.78340530395508 21.234375 27 C 21.234375 25.21652412414551 19.78347587585449 23.765625 18 23.765625 Z" fill="#fc2125" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
      width: 30.88.sp,
      height: 30.88.sp,
    );
  }

  Widget singleInstructionItems(text) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10.0.h,
        right: 30.0.w,
        left: 30.0.w,
      ),
      child: Text(
        '• $text',
        textAlign: TextAlign.justify,
        style: GoogleFonts.poppins(
          fontSize: 14.0.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
