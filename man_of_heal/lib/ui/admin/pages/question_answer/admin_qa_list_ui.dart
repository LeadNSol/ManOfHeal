import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/ui/admin/pages/question_answer/widgets/completed/admin_completed_widget.dart';
import 'package:man_of_heal/ui/admin/pages/question_answer/widgets/in_progress/admin_inprogress_widget.dart';
import 'package:man_of_heal/ui/components/custom_tabs.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class AdminQuestionAnswerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isVisible = false.obs;
// resetting the tabs while back to this screen...
    customTabsController.selectedPage.value = 0;
    customTabsController.setToolbar();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppThemes.BG_COLOR,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppThemes.BG_COLOR,
          elevation: 0,
          title: Obx(
            () => Text(
              customTabsController.pageTitle.value,
              style: AppThemes.headerTitleBlackFont,
            ),
          ),
          actions: [
            Obx(
              () => Visibility(
                visible: customTabsController.searchIconVisibility.value,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: InkWell(
                    onTap: () {
                      isVisible.value = !isVisible.value;
                    },
                    child: SvgPicture.asset(
                      "assets/icons/search_icon.svg",
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Obx(
              () => Visibility(
                visible: customTabsController.searchIconVisibility.value &&
                    isVisible.value,
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10, left: 10),
                      child: TextField(
                        controller: qaController.searchController,
                        cursorColor: AppThemes.DEEP_ORANGE,
                        textInputAction: TextInputAction.search,
                        onChanged: (search) =>
                            {qaController.setAdminSearchQuery(search)},
                        decoration: InputDecoration(
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
                            hintText: 'Search Answers ...'),
                      ),
                    ),
                    Positioned(
                      top: 1,
                      right: 10,
                      bottom: 1,
                      child: Container(
                        //width: 50,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            border: Border.all(
                                color: AppThemes.DEEP_ORANGE.withOpacity(0.9),
                                width: 0.5,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(5)),
                        child: DropdownButton(
                          //isExpanded: true,
                          style: AppThemes.normalBlackFont,
                          hint: Text('${qaController.selectedCategory.value}'),
                          onChanged: (newValue) => qaController
                              .setAdminSelectedCategory(newValue as String),
                          items: qaController.searchFilterList.map((category) {
                            // String category = categoryModel.category!;
                            return DropdownMenuItem(
                              child: Text(
                                '$category',
                              ),
                              value: category,
                            );
                          }).toList(),
                          value: qaController.selectedCategory.value,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FormVerticalSpace(
              height: 10,
            ),
            CustomTabs(),
            Expanded(
              child: PageView(
                // physics: BouncingScrollPhysics(),
                onPageChanged: (int page) {
                  customTabsController.onPageChange(page);
                },
                controller: customTabsController.pageController,
                children: [
                  AdminInProgressQuestions(),
                  AdminCompletedQuestion()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
