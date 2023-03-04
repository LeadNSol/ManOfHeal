import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class StudentAnswerUI extends GetView<DailyActivityController> {
  const StudentAnswerUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppThemes.BG_COLOR,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppThemes.BG_COLOR,
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: AppThemes.blackPearl,
          ),
        ),
        title: Text(
          "My Answers",
          style: AppThemes.headerTitleBlackFont,
        ),
      ),
      body: buildBody(context),
    );
  }

  buildBody(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => controller.currentStdAnswerList.isNotEmpty
              ?
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          controller.currentStdAnswerList.length,
                      itemBuilder: (context, index) {
                        StdAnswerModel answerModel =
                            controller.currentStdAnswerList[index];
                        return SingleAnswerListItems(stdModel: answerModel);
                      }),
                )
              : Center(child: NoDataFound()),
        ),
      ],
    );
  }
}
