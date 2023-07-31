import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class SubscriptionController extends GetxController {
  late Map<String, dynamic>? paymentIntentData;

  Rxn<Subscription>? _subsFirebase = Rxn<Subscription>();

  Subscription? get subsFirebase => _subsFirebase?.value;

  var searchController = TextEditingController();

  //Subscription get subsFirebase => Get.find();

  //Rx<Subscription> subsFirebase = Subscription().obs;

  var selectedPageIndex = 0.obs;
  var isQuestionQuotaIsFinished = false.obs;
  var _planPrice = ''.obs;
  var _planName = "".obs;
  var _questionsCanAsk = 1.obs;

  String get planPrice => _planPrice.value;

  String get planName => _planName.value;

  int get noOfQuestionCanBeAsked => _questionsCanAsk.value;

  bool get isLastPage => selectedPageIndex.value == onBoardingPages.length - 1;
  var pageController = PageController();

  void updatePageInfo(int value) {
    selectedPageIndex.value = value;
    _planPrice.value = onBoardingPages[value].price!;

    _planName.value = onBoardingPages[value].planName!;
    _questionsCanAsk.value = onBoardingPages[value].noOfQuestions!;
  }

  forwardAction() {
    if (isLastPage) {
      //go to home page
    } else
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  }

  List<OnBoardingInfo> onBoardingPages = [
    OnBoardingInfo(
        planName: "Standard",
        imageAsset: "subscription_1_icon.svg",
        price: STANDARD_PLAN_PRICE.toString(),
        noOfQuestions: 2,
        description: standardPlanText),
    OnBoardingInfo(
        planName: "Premium",
        imageAsset: "subscription_2_icon.svg",
        price: PREMIUM_PLAN_PRICE.toString(),
        noOfQuestions: 4,
        description: premiumPlanText),
  ];

  var subscriptionList = <Subscription>[].obs;
  var stdSubscriptionList = <StudentSubscription>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    initSubscription();
    //handleStudentData(subscriptionList);
  }

  initSubscription() {
    //subscriptionList.clear();
    _planPrice(onBoardingPages[0].price!);
    _subsFirebase?.bindStream(_getCurrentUserSubscription());
    subscriptionList.bindStream(getAllSubscriptions());
    ever(subscriptionList, handleStudentData);
  }

  void handleStudentData(List<Subscription> list) {
    stdSubscriptionList.clear();
    if (list.isNotEmpty) {
      for (Subscription subscription in list) {
        UserModel? userStudent =
            authController.getUserFromListById(subscription.studentId!);
        StudentSubscription studentSubscription =
            StudentSubscription(subscription, userStudent);
        stdSubscriptionList.add(studentSubscription);
      }
    } else
      noDataFound("No Data Found!");
  }

  var searchList = [].obs;
  var noDataFound = "".obs;

  handleSearch(String? search) {
    searchList.clear();
    if (stdSubscriptionList.length > 0) {
      stdSubscriptionList.forEach((element) {
        if (element.userModel!.name!.toLowerCase().contains(search!.trim()))
          searchList.add(element);
      });
    } else
      noDataFound("No Data Found for Searching...");
  }

  Timestamp _getExpiryDateTime() {
    DateTime? _cDate = DateTime.now();
    _cDate = new DateTime(_cDate.year, _cDate.month + 1, _cDate.day,
        _cDate.hour, _cDate.minute, _cDate.second);
    // Timestamp? _expiryTimeStamp = Timestamp.fromDate(_cDate);
    return Timestamp.fromDate(_cDate);
  }

  createSubscription(String paymentId) async {
    CollectionReference colRef =
        firebaseFirestore.collection(SUBSCRIPTION_COLLECTION);

    Subscription subscription = Subscription(
      planName: planName,
      netAmount: double.parse(planPrice),
      paymentId: paymentId,
      //noOfAskedQuestion: questionQuota, already done
      questionQuota: noOfQuestionCanBeAsked,
      studentId: firebaseAuth.currentUser!.uid,
      status: Status.New.name,
      expiresAt: _getExpiryDateTime(),
      createAt: Timestamp.now(),
      modifiedAt: Timestamp.now(),
    );

    await colRef
        .doc(firebaseAuth.currentUser!.uid)
        .set(subscription.toJson(), SetOptions(merge: true))
        .then((value) {
      authController.setBtnState(2);
      print('Subscription $planName was subscribed!.');
      _subsFirebase?.bindStream(_getCurrentUserSubscription());
      AppConstant.displaySuccessSnackBar("Success", "Paid Successfully");
    });
  }

  Future<void> renewSubscription(String paymentID) async {
    Subscription model = subsFirebase!;
    model.paymentId = paymentID;
    model.isRenewed = true;
    model.expiresAt = _getExpiryDateTime();
    model.modifiedAt = Timestamp.now();
    model.status = Status.Renewed.name;

    await firebaseFirestore
        .collection(SUBSCRIPTION_COLLECTION)
        .doc(model.studentId)
        .set(model.toJson(), SetOptions(merge: true))
        .whenComplete(() => {
              AppConstant.displaySuccessSnackBar(
                  "Success", "Your Plan is Renewed Successfully"),
              authController.setBtnState(2)
            });
  }

  Future<void> upgradeSubscription(String paymentId) async {
    // createSubscription(paymentId, true);
  }

  Stream<Subscription> _getCurrentUserSubscription() {
    String? uid = firebaseAuth.currentUser?.uid != null
        ? firebaseAuth.currentUser!.uid
        : authController.userModel != null
            ? authController.userModel!.uid!
            : "";

    debugPrint("Subscription: $uid");

    return firebaseFirestore
        .collection(SUBSCRIPTION_COLLECTION)
        .doc(uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists)
        return Subscription.fromMap(snapshot.data()!);
      else
        return Subscription();
    });
  }

  Stream<List<Subscription>> getAllSubscriptions() {
    return firebaseFirestore
        .collection(SUBSCRIPTION_COLLECTION)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) {
              if (e.exists)
                return Subscription.fromMap(e.data());
              else
                return Subscription();
            }).toList());
  }

  //next question cycle completion after three days i.e. 72 hours
  void updateSubscriptionOnNextQuestionTimerEnds() async {
    subsFirebase?.noOfAskedQuestion = subsFirebase?.questionQuota;
    subsFirebase?.status = Status.Recycled.name;

    await firebaseFirestore
        .collection(SUBSCRIPTION_COLLECTION)
        .doc(firebaseAuth.currentUser!.uid)
        .update(subsFirebase!.toJson())
        .then((value) => print('subscription noOfQuestion updated'));
  }

  Future<Subscription> checkUserSubscriptionById() async {
    return await firebaseFirestore
        .collection(SUBSCRIPTION_COLLECTION)
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists)
        return Subscription.fromMap(snapshot.data() as Map<String, dynamic>);
      else
        return Subscription();
    });

    /*if(snapshot.exists){
            AppConstant.displaySuccessSnackBar("Subscription", "You have already Purchased"),
          }else
            makePayment(amount)*/
  }

  Future<void> makePayment(amount, callingFor) async {
    authController.setBtnState(1);
    paymentIntentData = await createPaymentIntent(amount, "USD");
    await Stripe.instance
        .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          // applePay: true,
          //googlePay: true,
          //testEnv: true,
          style: ThemeMode.dark,
          //merchantCountryCode: 'US',
          merchantDisplayName: 'ANNIE',
        ))
        .then((value) {});

    displayPaymentSheet(callingFor);
  }

  displayPaymentSheet(int callingFor) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());

        if (callingFor == 0) {
          createSubscription(paymentIntentData!['id'].toString());
        } else if (callingFor == 1) {
          renewSubscription(paymentIntentData!['id'].toString());
        }
        paymentIntentData = null;
      }).onError((error, stackTrace) {
        authController.setBtnState(0);
        print('Exception/DISPLAY PAYMENT SHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      authController.setBtnState(0);
      print('Exception/DISPLAY PAYMENT SHEET==> $e');
      Get.defaultDialog(middleText: "Cancelled!");
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    print("Called: $amount");
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      //print(body);
      var response = await Http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ${AppConstant.SECRET_KEY}',
            'Content-Type': 'application/x-www-form-urlencoded'
          });

      var json = jsonDecode(response.body);

      debugPrint('Create Intent response ===> ${response.body.toString()}');
      if (json["error"] != null) {
        authController.setBtnState(0);
        AppConstant.displaySnackBar(
            "Payment Error", "${json["error"]["message"]}");
      }

      return json;
    } catch (err) {
      authController.setBtnState(0);
      print('err charging user: ${err.toString()}');
      AppConstant.displaySnackBar("Payment Error", "Something went wrong!");
    }
  }

  calculateAmount(String amount) {
    final a = ((double.parse(amount)) * 100).round();
    return a.toString();
  }

  int getSubscriptionExpiry() {
    return AppConstant.daysBetween(
        subsFirebase!.expiresAt!.toDate(), DateTime.now());
  }

  @override
  void onClose() {
    // TDO: implement onClose
    super.onClose();
  }
}
