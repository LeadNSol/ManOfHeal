import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/utils/app_themes.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timeago/timeago.dart' as timeAgo;

const USERS = "users";
const ADMIN = "admins";
const PROFILE_AVATARS = "profile_avatars";
const USER_NOTIFICATION = "notifications";
const DEFAULT_IMAGE_URL =
    "https://cdn-icons-png.flaticon.com/128/3011/3011270.png";

const TRIAL_DIALOG = "TrialDialog";

const QA_COLLECTION = "questions_answers";
const QUIZ_COLLECTION = "quiz_collection";
const QUIZ_QUESTION_COLLECTION = "quiz_question_collection";
const CATEGORIES = "categories";
const CHOOSE_CATEGORY = "Choose Category";
const userFeedBackCollections = "feed_backs";

const LAB_COLLECTION = "lab_collections";

const SUBSCRIPTION_COLLECTION = "subscriptions";

const SCORE_BOARD_COLLECTION = "score_board_collection";
const QUIZ_ATTEMPTS_COLLECTION = "quiz_attempts";

const STANDARD_PLAN_PRICE = 99;
const PREMIUM_PLAN_PRICE = 179.99;

class AppConstant {
  AppConstant._();

  //static const ADMIN_QUESTION_TOPIC = "QuestionsAdmin"; //for notification for all admins
  static const CHOOSE_OPTION = "Choose Correct Options";
  static const String loremIpsum =
      "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo";
  static const String noQODFound = "No Question of the day updated yet!";
  static const String noTODFound = "No Term of the day updated yet!";

  ///stripe test
  ///
  ///publishable key
  static const PUBLISHABLE_KEY =
      "pk_test_51KdtNAHqJCPRIXprSlMz57nwZf7iDT7Wn59LYaU8jhflk9kDhOdm740B5peXYc2tYIYJjtBM8WWOKi6b8Cd1tLz700aPpzaLUp";
  static const SECRET_KEY =
      "sk_test_51KdtNAHqJCPRIXprP3T8H3eIbJyxY883o7nGiyeiFxpcU017yPMeLu0n4aRPjWjXeoajnF1HxxSmGjRhy9xQXgLr00t7bOyMJd";

  static int getSecondsFromNowOnwardDate(Timestamp? timestamp) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp!.millisecondsSinceEpoch);
    //Timestamp.fromDate(date)
    //return dateTime.difference(new DateTime.now()).inMilliseconds;
    return DateTime.now()
        .add(dateTime.difference(new DateTime.now()))
        .toUtc()
        .millisecondsSinceEpoch;
  }

  static String formattedDataTime(String customFormat, Timestamp timestamp) {
    var date =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);

    return DateFormat(customFormat).format(date);
  }

  static String getFormattedTime(CurrentRemainingTime? time) {
    return "${time!.days != null && time.days! > 0 ? "${time.days} days &" : ""}"
        "${time.hours != null ? time.hours! < 10 ? "0${time.hours}:" : "${time.hours}:" : ""}"
        "${time.min != null ? time.min! < 10 ? "0${time.min}:" : "${time.min}:" : ""}"
        "${time.sec! < 10 ? "0${time.sec}" : time.sec}";
  }

  static Size getSize(BuildContext context) {
    //debugPrint('Size = ' + MediaQuery.of(context).size.toString());
    return MediaQuery.of(context).size;
  }

  static double getScreenHeight(BuildContext context) {
    //debugPrint('Height = ' + getSize(context).height.toString());
    return getSize(context).height;
  }

  static double getScreenWidth(BuildContext context) {
    //debugPrint('Width = ' + getSize(context).width.toString());
    return getSize(context).width;
  }

  static Widget textWidget(title, body, style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title',
          style: AppThemes.headerItemTitle,
        ),
        FormVerticalSpace(
          height: 10,
        ),
        Text(
          '$body',
          textAlign: TextAlign.start,
          style: style,
        ),
      ],
    );
  }

  static displaySnackBar(title, message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        duration: Duration(milliseconds: 1800),
        //backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        backgroundColor: AppThemes.DEEP_ORANGE,
        dismissDirection: DismissDirection.horizontal,
        //colorText: Get.theme.snackBarTheme.actionTextColor
        colorText: AppThemes.white);
  }

  static displayNormalSnackBar(title, message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(milliseconds: 1500),
        dismissDirection: DismissDirection.horizontal,
        snackStyle: SnackStyle.FLOATING,
        //backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        backgroundColor: AppThemes.dodgerBlue,
        //colorText: Get.theme.snackBarTheme.actionTextColor
        colorText: AppThemes.white);
  }

  static displaySuccessSnackBar(title, message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(milliseconds: 1500),
        dismissDirection: DismissDirection.horizontal,
        //backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        backgroundColor: AppThemes.rightAnswerColor,
        //colorText: Get.theme.snackBarTheme.actionTextColor
        colorText: AppThemes.white);
  }

  static String getAgoDateTime(Timestamp? timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp!.toDate());
    return timeAgo.format(now.subtract(difference));
  }

  static Future<void> copyToClipBoard(String value) async {
    await Clipboard.setData(ClipboardData(text: value)).then((value) =>
        AppConstant.displaySuccessSnackBar(
            "Copy alert!", "Copied to Clipboard!"));
  }

  static Future<PackageInfo> getBuildNumber() async {
    PackageInfo? packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }

/* String _convertAgoDate(Timestamp? timestamp) {
    */ /*final timeAgoFromNow =
        new DateTime.now().subtract(new Duration());*/ /*

    DateTime dateTime =
    DateTime.fromMicrosecondsSinceEpoch(timestamp!.microsecondsSinceEpoch);
    final timeAgoFromNow =
    new DateTime.now().subtract(new DateTime.now().difference(dateTime));

    initialTime!.value =
        new DateTime.now().difference(timeAgoFromNow).inSeconds;
    print(
        'Time ago: $timeAgoFromNow new: ${new DateTime.now().difference(timeAgoFromNow).inSeconds}');
    return timeAgo.format(timeAgoFromNow);
  }

  int _convertFromNowDate(Timestamp? timestamp) {
    DateTime dateTime =
    DateTime.fromMillisecondsSinceEpoch(timestamp!.microsecondsSinceEpoch);
    final timeAheadFromNow =
    new DateTime.now().add(dateTime.difference(new DateTime.now()));
    //print('Time ahead from now: ${timeAgo.format(timeAheadFromNow)}');
    int seconds = dateTime.difference(new DateTime.now()).inSeconds;

    // print('Time ahead from now: ${dateTime.subtract(new DateTime.now()).inSeconds)}');
    print('total seconds: ${dateTime.toLocal()}');
    print('total seconds: ${timestamp.seconds}');
    print('total seconds: ${seconds}');
    return seconds;
  }

  int secondsBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours * 3600).round();
  }*/

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);

    print("Diff: Date: ${to.difference(from).inDays}");
    return from.difference(to).inDays > 0 ? from.difference(to).inDays : 0;
    return (to.difference(from).inHours / 24).round();
  }
}
