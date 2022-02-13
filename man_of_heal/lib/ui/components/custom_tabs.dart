import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/controllers/custom_tabs_controller.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class CustomTabs extends StatelessWidget {
  final CustomTabsController _tabsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            child: Obx(
              () => Container(
                color: AppThemes.TABS_BG_COLOR,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Tabs(
                      text: authController.admin.isFalse
                          ? "Questions"
                          : "In Progress",
                      selectedPage: _tabsController.selectedPage.value,
                      pageNumber: 0,
                      onPressed: () {
                        //landingPageController.calledFor("Questions");
                        _tabsController.onPageChange(0);
                      },
                    ),
                    Tabs(
                      text: authController.admin.isFalse
                          ? "Answered"
                          : "Completed",
                      selectedPage: _tabsController.selectedPage.value,
                      pageNumber: 1,
                      onPressed: () {
                        //landingPageController.calledFor("Answered");
                        _tabsController.onPageChange(1);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Tabs extends StatelessWidget {
  final String? text;
  final int? selectedPage;
  final int? pageNumber;
  final void Function()? onPressed;

  Tabs({this.text, this.selectedPage, this.pageNumber, this.onPressed});

  @override
  Widget build(BuildContext context) {
    //landingPageController.setCalledFor(text);
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: selectedPage == pageNumber ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: EdgeInsets.symmetric(
          vertical: selectedPage == pageNumber ? 12.0 : 0,
          horizontal: selectedPage == pageNumber ? 20.0 : 0,
        ),
        margin: EdgeInsets.symmetric(
          vertical: selectedPage == pageNumber ? 0 : 12.0,
          horizontal: selectedPage == pageNumber ? 0 : 20.0,
        ),
        child: Text(
          text ?? "Tab Button",
          style: TextStyle(
            color: selectedPage == pageNumber
                ? Colors.black
                : AppThemes.DEEP_ORANGE,
          ),
        ),
      ),
    );
  }
}
