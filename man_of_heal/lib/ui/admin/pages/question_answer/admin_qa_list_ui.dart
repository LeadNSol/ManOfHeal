import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/controllers/custom_tabs_controller.dart';
import 'package:man_of_heal/ui/admin/pages/question_answer/widgets/completed/admin_completed_widget.dart';
import 'package:man_of_heal/ui/admin/pages/question_answer/widgets/in_progress/admin_inprogress_widget.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/custom_tabs.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class AdminQuestionAnswerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isVisible = false.obs;
    TextTheme textTheme = Theme.of(context).textTheme;

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
              style: textTheme.headline6!.copyWith(color: AppThemes.blackPearl),
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
                visible:
                    CustomTabsController.instance.searchIconVisibility.value &&
                        isVisible.value,
                child: TextField(
                  //controller: qaController.searchController,
                  onChanged: (search) => {qaController.handleSearch(search)},
                  decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(12.0),
                      //prefixIcon: new Icon(Icons.search),
                      border: InputBorder.none.copyWith(
                        borderSide: BorderSide(style: BorderStyle.solid),
                      ),
                      hintText: 'Search Questions ...'),
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
