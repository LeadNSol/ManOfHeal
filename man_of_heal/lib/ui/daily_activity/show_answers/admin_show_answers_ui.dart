import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class AdminShowAnswersUI extends GetView<DailyActivityController> {
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
            controller: controller.searchController,
            onChanged: (search) => {
              controller.handleAdminSearch(search.toLowerCase())
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
          () => controller.searchAnswersList.isNotEmpty
              ? _buildSTDAnswerListView(
              controller.searchAnswersList)
              : controller.allStudentsAnswers.isNotEmpty
                  ? _buildSTDAnswerListView(
                      controller.allStudentsAnswers)
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
