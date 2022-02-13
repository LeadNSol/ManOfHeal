import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';

class CustomTabsController extends GetxController {
  static CustomTabsController instance = Get.find();

  var selectedPage = 0.obs;
  late PageController pageController;
  var searchIconVisibility = false.obs;
  var pageTitle = "Questions".obs;
  var initialPage = 0.obs;

  void onPageChange(int pageNum) {
    selectedPage.value = pageNum;
    setToolbar();
    //pageNum = 1;

    pageController.animateToPage(
      pageNum,
      duration: Duration(milliseconds: 700),
      curve: Curves.linearToEaseOut,
    );
  }

  setToolbar() {
    if (selectedPage.value == 1) {
      searchIconVisibility.value = true;
      pageTitle.value = authController.admin.isFalse ? "Answers" : "Completed";
    } else {
      searchIconVisibility.value = false;
      pageTitle.value =
          authController.admin.isFalse ? "Ask Question" : "Questions";
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    pageController = PageController();

    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    pageController = PageController();
    /*landingPageController.calledFor.value == "Questions"
        ? onPageChange(0)
        : onPageChange(1);*/
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    pageController.dispose();
    super.onClose();
  }
}
