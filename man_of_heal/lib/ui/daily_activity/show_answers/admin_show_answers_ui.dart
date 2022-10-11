import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/student_answer_model.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/not_found_data_widget.dart';
import 'package:man_of_heal/ui/daily_activity/widgets/qod_single_answer_list_items.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class AdminShowAnswersUI extends StatelessWidget {
  const AdminShowAnswersUI({Key? key}) : super(key: key);

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
          "Student Answers",
          style: AppThemes.headerTitleBlackFont,
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: TextField(
            cursorColor: AppThemes.DEEP_ORANGE,
            controller: dailyActivityController.searchController,
            onChanged: (search) => {
              dailyActivityController.handleAdminSearch(search.toLowerCase())
            },
            textInputAction: TextInputAction.search,
            decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(12.0),
                prefixIcon: new Icon(
                  Icons.search,
                  color: AppThemes.DEEP_ORANGE,
                ),
                border: InputBorder.none.copyWith(
                  borderSide: BorderSide(style: BorderStyle.solid),
                ),
                labelStyle: AppThemes.normalBlackFont,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppThemes.DEEP_ORANGE,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppThemes.DEEP_ORANGE,
                    width: 1.0,
                  ),
                ),
                hintText: 'Search in Answers ...'),
          ),
        ),
        FormVerticalSpace(
          height: 10,
        ),
        Obx(
          () => dailyActivityController.searchAnswersList.isNotEmpty
              ? _buildSTDAnswerListView(
              dailyActivityController.searchAnswersList)
              : dailyActivityController.allStudentsAnswers.isNotEmpty
                  ? _buildSTDAnswerListView(
                      dailyActivityController.allStudentsAnswers)
              : NoDataFound(),
        ),
      ],
    );
  }

  _buildSTDAnswerListView(List<StdAnswerModel> list) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            StdAnswerModel? stdModel = list[index];
            return SingleAnswerListItems(
              stdModel: stdModel,
              isCalledFromAdmin: true,
            );
          }),
    );
  }
}
