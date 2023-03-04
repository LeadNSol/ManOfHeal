import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/ui/admin/pages/admin_dashboard_ui.dart';
import 'package:man_of_heal/ui/admin/pages/question_answer/admin_qa_list_ui.dart';
import 'package:man_of_heal/ui/daily_activity/my_answers/student_answers_ui.dart';
import 'package:man_of_heal/ui/daily_activity/show_answers/admin_show_answers_ui.dart';
import 'package:man_of_heal/ui/student/pages/question_answer/qa_list_ui.dart';
import 'package:man_of_heal/ui/student/pages/std_dashboard_ui.dart';

class LandingPageController extends GetxController {
  static LandingPageController instance = Get.find();

  final Rx<int> adminTabIndex = 0.obs;
  final Rx<int> studentTabIndex = 0.obs;
  final itemColor = Colors.grey.obs;

  // QuestionAnswerList calling from bottom navigation or dashboard
  // for showing Answered section
  var calledFor = "Questions".obs;

  List<Widget> adminPages = [
    AdminDashboardUI(),
    AdminQuestionAnswerList(),
  ];

  Widget get currentAdminPage => adminPages[adminTabIndex.value];

  List<Widget> studentPages = [
    StudentDashboardUI(),
    QuestionAnswerList(),
  ];

  Widget get currentStudentPage => studentPages[studentTabIndex.value];

  //Widget get currentPage => stdPages[tabIndex.value];

  void setAdminPage(int _index) {
    adminTabIndex(_index);
  }

  void setStudentPage(int _index) {
    //_index == 1 ? calledFor.value = "Answered" : calledFor.value = "Dashboard";
    //
    studentTabIndex(_index);
  }

  void setCalledFor(calledForValue) {
    calledFor(calledForValue);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    studentTabIndex(0);
    adminTabIndex(0);
    super.onClose();
  }
}
