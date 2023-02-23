import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/student_answer_model.dart';
import 'package:man_of_heal/ui/components/custom_container.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/ui/daily_activity/widgets/qod_answer_details.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';
import 'package:man_of_heal/utils/svgs.dart';

class SingleAnswerListItems extends StatelessWidget {
  const SingleAnswerListItems({
    Key? key,
    this.stdModel,
    this.isCalledFromAdmin = false,
  }) : super(key: key);

  final StdAnswerModel? stdModel;
  final bool? isCalledFromAdmin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dailyActivityController.stdAnswerModel(stdModel);
        Get.to(() => QODAnswerDetails());
      },
      child: CustomContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Answer',
                  style: AppThemes.headerItemTitle
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                _headerWidget(stdModel!),
              ],
            ),
            Container(
              width: 245,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${stdModel!.answer}',
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: AppThemes.normalBlack45Font,
                  ),
                ],
              ),
            ),
            FormVerticalSpace(height: 5),
            Text(
              'Question',
              style: AppThemes.headerItemTitle
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Container(
              width: 245,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: Text(
                '${stdModel!.questionId!}',
                maxLines: 2,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: AppThemes.normalBlack45Font,
              ),
            ),
            FormVerticalSpace(
              height: 10,
            ),
            _footerWidget(stdModel!),
          ],
        ),
      ),
    );
  }

  _headerWidget(StdAnswerModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isCalledFromAdmin!
            ? Container()
            : InkWell(
                onTap: () {
                  Get.defaultDialog(
                      title: "Delete Answer",
                      titleStyle: AppThemes.dialogTitleHeader,
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Are you sure you want to delete this answer?",
                              style: AppThemes.normalBlack45Font,
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
                                    buttonStyle: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 10.0),
                                      primary: AppThemes.DEEP_ORANGE,
                                      shape: StadiumBorder(),
                                    ),
                                    labelText: 'Yes',
                                    textStyle: AppThemes.buttonFont,
                                    onPressed: () async {
                                      await dailyActivityController
                                          .deleteStudentAnswerById(model);
                                      Get.back();
                                    },
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  child: PrimaryButton(
                                      buttonStyle: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        primary: AppThemes.DEEP_ORANGE,
                                        shape: StadiumBorder(),
                                      ),
                                      labelText: 'No',
                                      textStyle: AppThemes.buttonFont,
                                      onPressed: () => Get.back()),
                                ),
                              ],
                            )
                          ],
                        ),
                      ));
                },
                child: Image.asset(
                  "assets/icons/delete_icon.png",
                  width: 15,
                ),
              ),
        SizedBox(
          width: 15,
        ),
        Tooltip(
          message: "Copy answer",
          child: InkWell(
            onTap: () => AppConstant.copyToClipBoard(model.answer!),
            child: Image.asset(
              "assets/icons/copy_icon.png",
              width: 15,
            ),
          ),
        ),
      ],
    );
  }

  _footerWidget(StdAnswerModel model) {
    //UserModel? adminModel = authController.getAdminFromListById(model.checkBy!);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Asked By: ${authController.getUserFromListById(stdModel!.answerBy!)!.name!}",
          style: AppThemes.captionFont,
        ),
        model.checkBy != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    "assets/icons/tick_mark_icon.png",
                    width: 10,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  model.checkBy != null
                      ? Text(
                          'Approved',
                          style: GoogleFonts.poppins(
                              color: Colors.green,
                              fontWeight: FontWeight.w700,
                              fontSize: 8),
                        )
                      : Text(
                          'Not Approved',
                          style: GoogleFonts.poppins(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w700,
                              fontSize: 8),
                        ),
                ],
              )
            : Container()
      ],
    );
  }
}
