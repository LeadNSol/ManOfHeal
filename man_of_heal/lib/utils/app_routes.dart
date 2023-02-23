import 'package:get/get.dart';
import 'package:man_of_heal/ui/export_ui.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object

  static const initRoute = "/";
  static const signInRoute = "/signIn";
  static const signUpRoute = "/signUp";
  static const welcomeRoute = "/welcome";
  static const forgotPasswordRoute = "/forgotPassword";
  static const profileRoute = "/profile";

  static final routes = [
    GetPage(name: initRoute, page: () => SplashUI()), //binding: AuthBinding()
    GetPage(name: '/welcome', page: () => WelcomeBackUI()),
    GetPage(name: '/signIn', page: () => SignInUI()),
    GetPage(name: '/signup', page: () => SignUpUI()),
    GetPage(name: '/forgotPassword', page: () => ForgotPassword()),
    GetPage(name: '/profile', page: () => ProfileUI()),
    GetPage(name: '/AdminDashboard', page: () => AdminDashboardUI()),
    GetPage(name: '/StudentDashboard', page: () => StudentDashboardUI()),
    GetPage(name: '/vignette', page: () => AdminVignetteDissectionUI(), ),
    GetPage(name: '/admin-qa', page: () => AdminQuestionAnswerList()),
    GetPage(name: '/question-answer', page: () => QuestionAnswerList()),
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
