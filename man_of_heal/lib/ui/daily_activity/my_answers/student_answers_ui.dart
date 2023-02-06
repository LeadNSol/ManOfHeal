import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/student_answer_model.dart';
import 'package:man_of_heal/ui/components/not_found_data_widget.dart';
import 'package:man_of_heal/ui/daily_activity/widgets/qod_single_answer_list_items.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class StudentAnswerUI extends StatelessWidget {
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
          () => dailyActivityController.currentStdAnswerList.isNotEmpty
              ?
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          dailyActivityController.currentStdAnswerList.length,
                      itemBuilder: (context, index) {
                        StdAnswerModel answerModel =
                            dailyActivityController.currentStdAnswerList[index];
                        return SingleAnswerListItems(stdModel: answerModel);
                      }),
                )
              : Center(child: NoDataFound()),
        ),
      ],
    );
  }
}
