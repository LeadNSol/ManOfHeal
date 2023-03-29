import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';

class CustomTabsController extends GetxController {
  //static CustomTabsController instance = Get.find();

  final AuthController? authController;

  CustomTabsController(this.authController);

  var selectedPage = 0.obs;

  PageController pageController = PageController();
  PageController adminSubsPageController = PageController();

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

  /*
  * Admin Subscription UI @pageNum
  * */
  void onAdminSubscriptionPageChange(int pageNum) {
    selectedPage.value = pageNum;
    setAdminSubscriptionToolBar();
    adminSubsPageController.animateToPage(
      pageNum,
      duration: Duration(milliseconds: 500),
      curve: Curves.linearToEaseOut,
    );
  }

  setAdminSubscriptionToolBar() {
    if (selectedPage.value == 1) {
      searchIconVisibility.value = true;
      pageTitle.value = "Subscribers";
    } else {
      searchIconVisibility.value = false;
      pageTitle.value = "Un-Subscribers";
    }
  }

  setToolbar() {
    if (selectedPage.value == 1) {
      searchIconVisibility.value = true;
      pageTitle.value = authController!.admin.isFalse ? "Answers" : "Completed";
    } else {
      searchIconVisibility.value = false;
      pageTitle.value =
          authController!.admin.isFalse ? "Ask Question" : "Questions";
    }
  }

  @override
  void onInit() {
    // pageController = PageController();
    super.onInit();
  }

  @override
  void onReady() {
    // pageController = PageController();
    /*landingPageController.calledFor.value == "Questions"
        ? onPageChange(0)
        : onPageChange(1);*/
    super.onReady();
  }

  @override
  void onClose() {
    //
    pageController.dispose();
    super.onClose();
  }
}
