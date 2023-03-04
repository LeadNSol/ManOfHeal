import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/main.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class NotificationController extends GetxController {
  //static NotificationController instance = Get.find();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'Man_Of_Heal0002', // id
    'MOH', // title
    description: 'This channel is used for important notifications.',
    // description
    importance: Importance.high,
  );

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var notificationCount = 0.obs;
  var _token = "".obs;

  String? get userToken => _token.value;

  var notificationList = <NotificationModel>[].obs;

  @override
  onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings()
      ),
    );

    setupInteractedMessage();
   initData();
  }

  void initData(){
    notificationList.bindStream(getNotificationList());
    ever(notificationList, (callback) {
      notificationCount.value = 0;
      notificationList.forEach((element) {
        if (authController.admin.isFalse &&
            element.isRead != null &&
            !element.isRead!) {
          notificationCount.value += 1;
        }
      });
    });
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    FirebaseMessaging instance = FirebaseMessaging.instance;
    RemoteMessage? initialMessage = await instance.getInitialMessage();

    NotificationSettings settings = await instance.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      notificationCount++;
      // notificationList.add(initialMessage);

      print('Permission: User granted permission');
      // If the message also contains a data property with a "type" of "chat",
      // navigate to a chat screen
      if (initialMessage != null) {
        _handleMessage(initialMessage);
      }

      // Also handle any interaction when the app is in the background via a
      // Stream listener
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

      onAppBackgroundNotification();
    } else {
      print('Permission: User declined or has not accepted permission');
    }
  }

  void _handleMessage(RemoteMessage initialMessage) {
    print("Notification: Called _handleMessage()");
    switch (initialMessage.data["type"]) {
      case "qa":
        Get.to(() => QuestionAnswerList());
        break;
      case "qa_admin":
        Get.to(() => AdminQuestionAnswerList());
        break;
      case "labs":
        Get.to(() => LabInstructionUI());
        break;
      case "quiz":
        Get.to(() => QuizInstructionsScreen());
        break;
      default:
        Get.to(() => main());
    }
  }

  onAppBackgroundNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onAppBackgroundNotification()");
      showNotification(message);
    });
  }

  void showNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: android.smallIcon,
          ),
        ),
      );
    } else {
      print("Notification is null");
    }
  }

  Future<void> createAndroidNotificationChannel() async {
    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> updateIOSNotificationOptions() async {
    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }






  Future<void> sendPushNotification(NotificationModel model) async {
    if (model.receiverToken == null || !model.isTopicBased!) {
      print('NotificationS: Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        //Uri.parse('https://api.rnfirebase.io/messaging/send'),
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAgL6YMm4:APA91bGeq4dRqhQlsUsFOuKQpyHus0wdogqkxMF7Blh1j8HvU9GENAfo3aGWQbLJ1w08krZ0w8aQdYRdK92m-ybOMuVszXAy4yb6OZT7RJZoVTOTF7ReRqkSuC-SeLOR84MiGSBAOzuN'
        },
        body: model.isTopicBased!
            ? constructFCMTopicPayload(model)
            : constructFCMPayload(model),
      );
      print('NotificationS: FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  /// The API endpoint here accepts a raw FCM payload for demonstration purposes.
  String constructFCMPayload(NotificationModel model) {
    return jsonEncode({
      'to': model.receiverToken,
      'content_available': true,
      'priority': 'high',
      'data': {
        'type': model.type!,
      },
      'notification': {
        'title': model.title,
        'body':
            "Your Question: ${model.body!.substring(0, 15)}... was Answered",

        //'body': 'This notification (#$notificationCount ) was created via FCM!',
      },
    });
  }

  /// The API endpoint here accepts a raw FCM payload for demonstration purposes.
  String constructFCMTopicPayload(NotificationModel model) {
    var topic = "";
    switch (model.type) {
      case "labs":
        topic = NotificationEnum.labs.name;
        break;
      case "quiz":
        topic = NotificationEnum.quiz.name;
        break;
      case "daily_activity":
        topic = NotificationEnum.daily_activity.name;
        break;
      default:
        topic = NotificationEnum.qa_admin.name;
    }

    return jsonEncode({
      'to': "/topics/$topic",
      'priority': 'high',
      'content_available': true,
      'data': {
        'type': model.type!,
      },
      'notification': {
        'title': model.title,
        'body': model.body,
        //'body': 'This notification (#$notificationCount ) was created via FCM!',
      },
    });
  }




  Future<void> addNotificationsToDB(NotificationModel model) async {
    var docRef = firebaseFirestore
        .collection(USERS)
        .doc(model.receiverId)
        .collection(USER_NOTIFICATION)
        .doc();
    model.uID = docRef.id;
    model.sentTime = Timestamp.now();
    await docRef
        .set(model.toMap())
        .whenComplete(() => print("Notification: were added"));
  }

  Future<void> updateNotificationIsRead(NotificationModel model) async {
    model.isRead = true;
    await firebaseFirestore
        .collection(USERS)
        .doc(model.receiverId!.trim())
        .collection(USER_NOTIFICATION)
        .doc(model.uID)
        .set({
      NotificationModel.nIsRead: true
    }, SetOptions(merge: true)).whenComplete(
            () => print("Notification: Updated"));
  }

  Stream<List<NotificationModel>> getNotificationList() {
    var uid = authController.userModel?.uid != null
        ? authController.userModel!.uid!
        : firebaseAuth.currentUser?.uid;
    print("GetNotificationList()");
    return firebaseFirestore
        .collection(USERS)
        .doc(uid)
        .collection(USER_NOTIFICATION)
        .orderBy(NotificationModel.nSentTime, descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((e) => e.exists
                ? NotificationModel.fromMap(e.data())
                : NotificationModel())
            .toList());
  }

  Future<void> deleteNotification(NotificationModel model) async {
    await firebaseFirestore
        .collection(USERS)
        .doc(model.receiverId!.trim())
        .collection(USER_NOTIFICATION)
        .doc(model.uID)
        .delete()
        .whenComplete(() => print("Notification: delete"));
  }
}
