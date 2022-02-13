import 'package:get/get.dart';
import 'package:man_of_heal/bindings/authBinding.dart';
import 'package:man_of_heal/bindings/qa_binding.dart';
import 'package:man_of_heal/ui/admin/pages/admin_dashboard_ui.dart';
import 'package:man_of_heal/ui/admin/pages/question_answer/admin_qa_list_ui.dart';
import 'package:man_of_heal/ui/admin/pages/vignette_dissection/admin_vd_ui.dart';
import 'package:man_of_heal/ui/auth/forgot_password_ui.dart';
import 'package:man_of_heal/ui/auth/sign_up_ui.dart';
import 'package:man_of_heal/ui/auth/sing_in_ui.dart';
import 'package:man_of_heal/ui/auth/welcome_back_ui.dart';
import 'package:man_of_heal/ui/labs/labs_ui.dart';
import 'package:man_of_heal/ui/profile/profile_ui.dart';
import 'package:man_of_heal/ui/splash/splash_ui.dart';
import 'package:man_of_heal/ui/student/pages/question_answer/qa_list_ui.dart';
import 'package:man_of_heal/ui/student/pages/std_dashboard_ui.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => SplashUI(), binding: AuthBinding()),
    GetPage(name: '/welcome-back', page: () => WelcomeBackUI()),
    GetPage(name: '/signIn', page: () => SignInUI()),
    GetPage(name: '/signup', page: () => SignUpUI()),
    GetPage(name: '/forgot-password', page: () => ForgotPassword()),
    GetPage(name: '/profile', page: () => ProfileUI()),
    GetPage(name: '/', page: () => AdminDashboardUI()),
    GetPage(name: '/', page: () => StudentDashboardUI()),
    GetPage(name: '/vignette', page: () => AdminVignetteDissectionUI()),
    GetPage(
        name: '/admin-qa',
        page: () => AdminQuestionAnswerList(),
        binding: QABinding()),
    GetPage(
        name: '/question-answer',
        page: () => QuestionAnswerList(),
        binding: QABinding()),
    GetPage(name: '/lab-value', page: () => LabsUI()),
  ];

/*//Admin routes
  static final adminRoutes = [
    GetPage(name: '/', page: () => AdminDashboardUI()),
    GetPage(name: '/vignette', page: () => AdminVignetteDissection()),
    GetPage(name: '/question-answer', page: () => AdminQuestionAnswerList()),
    GetPage(name: '/lab-value', page: () => AdminLabValueExplanation()),
    GetPage(name: '/profile', page: () => ProfileUI())
  ];

  //Student routes
  static final studentRoutes = [
    GetPage(name: '/', page: () => StudentDashboardUI()),
    GetPage(name: '/question-answer', page: () => QuestionAnswerList()),
    GetPage(name: '/profile', page: () => ProfileUI())
  ];*/
}
