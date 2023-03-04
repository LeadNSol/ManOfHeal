import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class AdminQuestionAnswerList extends GetView<CustomTabsController> {
  @override
  Widget build(BuildContext context) {
    var isVisible = false.obs;
// resetting the tabs while back to this screen...
    controller.selectedPage.value = 0;
    controller.setToolbar();

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
              controller.pageTitle.value,
              style: AppThemes.headerTitleBlackFont,
            ),
          ),
          actions: [
            Obx(
              () => Visibility(
                visible: controller.searchIconVisibility.value,
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
              () => QASearchWidget(
                searchIconVisibility: controller.searchIconVisibility.value,
                isVisible: isVisible.value,
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
                  controller.onPageChange(page);
                },
                controller: controller.pageController,
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
