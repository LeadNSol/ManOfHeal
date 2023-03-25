import 'package:get/get.dart';
import 'package:man_of_heal/bindings/export_bindings.dart';
import 'package:man_of_heal/bindings/profile_binding.dart';
import 'package:man_of_heal/ui/export_ui.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object

  static const initRoute = "/";
  static const signInRoute = "/signIn";
  static const signUpRoute = "/signUp";
  static const welcomeRoute = "/welcome";
  static const forgotPasswordRoute = "/forgotPassword";
  static const profileRoute = "/profile";
  static const stdDashboard = '/student-dashboard';
  static const adminDashboard = '/admin-dashboard';
  static const adminVignetteD = '/admin-vd';
  static const stdVignetteD = '/std-vd';
  static const adminQAList = '/admin-qaList';
  static const stdQAList = '/std-qaList';
  static const labsRoute = '/labsValue';

  static final routes = [
    GetPage(
        name: initRoute, page: () => SplashUI()),
    //binding: AuthBinding()

    GetPage(
        name: welcomeRoute,
        page: () => WelcomeBackUI(), binding: AuthBinding()),

    GetPage(name: '/signIn', page: () => SignInUI(), binding: AuthBinding()),
    GetPage(name: '/signup', page: () => SignUpUI(), binding: AuthBinding()),
    GetPage(name: '/forgotPassword', page: () => ForgotPassword()),
    GetPage(
        name: profileRoute, page: () => ProfileUI(), binding: ProfileBinding()),
    GetPage(
        name: adminDashboard,
        page: () => AdminHome(),
        bindings: [
         // AuthBinding(),
          DashboardBinding(),
        ]),
    GetPage(
        name: stdDashboard,
        page: () => StudentHome(),
        binding: DashboardBinding()),
    GetPage(
      name: adminVignetteD,
      page: () => AdminVignetteDissectionUI(),
      binding: DashboardBinding()

    ),
    GetPage(name: adminQAList, page: () => AdminQuestionAnswerList(), binding: DashboardBinding()),
    GetPage(name: stdQAList, page: () => QuestionAnswerList()),
    GetPage(name: labsRoute, page: () => LabsUI(), binding: DashboardBinding()),
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
