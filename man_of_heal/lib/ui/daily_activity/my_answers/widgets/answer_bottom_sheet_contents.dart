import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class AnswerBottomSheetContents extends GetView<DailyActivityController> {
  const AnswerBottomSheetContents({
    Key? key,
    this.dailyActivityModel,
  }) : super(key: key);
  final DailyActivityModel? dailyActivityModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Give Answer",
                style: AppThemes.dialogTitleHeader,
              ),
            ),
            FormVerticalSpace(),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Q: ${dailyActivityModel != null ? dailyActivityModel!.qOfDay! : ""}",
                style: AppThemes.captionFont,
                maxLines: 3,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            FormVerticalSpace(
              height: 10,
            ),
            Container(
              height: 150,
              child: FormInputFieldWithIcon(
                controller: controller.studentAnswerController,
                iconPrefix: Icons.note,
                labelText: 'Answer body',
                isExpanded: true,
                autofocus: false,
                iconColor: AppThemes.DEEP_ORANGE,
                textStyle: AppThemes.normalBlackFont,
                // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                maxLength: 1000,
                //validator: Validator().notEmpty,
                onChanged: (value) => null,
                onSaved: (value) => null,
              ),
            ),
            FormVerticalSpace(),
            Center(
              child: Container(
                width: 120,
                child: PrimaryButton(
                  buttonStyle: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    backgroundColor: AppThemes.DEEP_ORANGE,
                    shape: StadiumBorder(),
                  ),
                  labelText: 'Submit',
                  textStyle: AppThemes.buttonFont,
                  onPressed: () async {
                    await controller.createStudentAnswer(dailyActivityModel!);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
