import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/models/on_boarding_info.dart';
import 'package:man_of_heal/models/subscription_model.dart';
import 'package:man_of_heal/utils/firebase.dart';

class SubscriptionController extends GetxController {
  static SubscriptionController instance = Get.find();

  var subscriptionCollection = "subscriptions";
  Rxn<Subscription> subsFirebase = Rxn<Subscription>();

  //Rx<Subscription> subsFirebase = Subscription().obs;

  var selectedPageIndex = 0.obs;

  bool get isLastPage => selectedPageIndex.value == onBoardingPages.length - 1;
  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {
      //go to home page
    } else
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  }

  List<OnBoardingInfo> onBoardingPages = [
    OnBoardingInfo(
        imageAsset: "subscription_1_icon.svg",
        price: '20',
        description: 'Now you can pick this basic plan right from your mobile.'),
    OnBoardingInfo(
        imageAsset: "subscription_2_icon.svg",
        price: '30',
        description: 'We are maintain safety and We will keep your data safe.'),
  ];

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    //_getCurrentUserSubscription();
    subsFirebase.bindStream(_getCurrentUserSubscription());
  }

  createSubscription(planName, price, questionQuota) async {
    DateTime? _cDate = DateTime.now();
    print('current date: $_cDate');
    _cDate = new DateTime(_cDate.year, _cDate.month + 1, _cDate.day,
        _cDate.hour, _cDate.minute, _cDate.second);
    print('one month after date: $_cDate');
    Timestamp? _expiryTimeStamp = Timestamp.fromDate(_cDate);

    CollectionReference colRef =
        firebaseFirestore.collection(subscriptionCollection);

    Subscription subscription = Subscription(
      planName: planName,
      netAmount: price.toDouble(),
      //noOfAskedQuestion: questionQuota, already done
      questionQuota: questionQuota,
      studentId: firebaseAuth.currentUser!.uid,
      status: Status.New.name,
      expiresAt: _expiryTimeStamp,
      createAt: Timestamp.now(),
      modifiedAt: Timestamp.now(),
    );

    await colRef
        .doc(firebaseAuth.currentUser!.uid)
        .set(subscription.toJson())
        .then((value) => print('Subscription $planName was subscribed!.'));
  }

  Stream<Subscription> _getCurrentUserSubscription() {
    return firebaseFirestore
        .collection(subscriptionCollection)
        .doc(firebaseAuth.currentUser!.uid)
        .snapshots()
        .map((snapshot) => Subscription.fromMap(snapshot.data()!));
  }

  //next question cycle completion after three days i.e. 72 hours
  void onCompletionOfThreeDays(Subscription subscription) async {
    subscription.noOfAskedQuestion = subscription.questionQuota;
    subscription.status = Status.Recycled.name;

    await firebaseFirestore
        .collection(subscriptionCollection)
        .doc(firebaseAuth.currentUser!.uid)
        .update(subscription.toJson())
        .then((value) => print('subscription noOfQuestion updated'));
  }
}
