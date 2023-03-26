import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class StudentHome extends GetView<LandingPageController> {
  @override
  Widget build(BuildContext context) {
    //_initControllers();
    final subscriptionController = Get.find<SubscriptionController>();
    return Obx(
      () => SafeArea(
        child: DoubleBackPressToExit(
          child: Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: false,
            body: controller.currentStudentPage,
            bottomNavigationBar: _bottomCircularNotchedBar(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (authController.userModel!.isTrailFinished!) {
                  Subscription? subscription =
                      subscriptionController.subsFirebase!;
                  if (subscription.paymentId != null) {
                    if (Timestamp.now().compareTo(subscription.expiresAt!) >
                        0) {
                      displayBottomSheet(subscription);
                    } else {
                      showQuestionBottomSheet();
                    }
                  } else
                    Get.to(() => SubscriptionUI());
                } else
                  showQuestionBottomSheet();
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppThemes.gradientColor_1,
                      AppThemes.gradientColor_2
                    ],
                  ),
                ),
                child: Icon(
                  Icons.add_rounded,
                  size: 30,
                ),
                // child: SvgPicture.asset("assets/icons/fab_icon.svg"),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showQuestionBottomSheet() {
    //qaController.questionController.clear();
    Get.bottomSheet(
      AskQuestionUI(callingFor: "new"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      backgroundColor: Colors.white,
    );
  }

  /// controller that required user ID's
  /// and common for both users,
  ///
  /*_initControllers() {
    Get.put(SubscriptionController());
    Get.put(QAController());
    Get.put(VDController());
  }*/

  _bottomCircularNotchedBar() {
    final _inactiveColor = Colors.grey;
    return BottomAppBar(
      //color: Colors.deepPurple,
      notchMargin: 8,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      elevation: 20,
      shape: CircularNotchedRectangle(),
      child: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.studentTabIndex.value,
          selectedItemColor: AppThemes.DEEP_ORANGE,
          selectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
          unselectedItemColor: _inactiveColor,
          onTap: onTapped,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline), label: "Favorite"),
          ],
        ),
      ),
    );
  }

  onTapped(int index) {
    controller.setStudentPage(index);
    //if (index == 1) landingPageController.setCalledFor("Answered");
  }

  void displayBottomSheet(Subscription subscription) {
    final subscriptionController = Get.find();
    Get.bottomSheet(
      Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Your current Subscription Plan is expired!",
              textAlign: TextAlign.center,
              style: AppThemes.dialogTitleHeader
                  .copyWith(color: AppThemes.DEEP_ORANGE),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "Details of current Subscription Plan\n",
                      style: AppThemes.headerItemTitle),
                  TextSpan(
                      text:
                          "Questions: ${subscription.questionQuota}\n Plan Bought at: \$${subscription.netAmount}\n",
                      style: AppThemes.normalBlack45Font),
                  TextSpan(
                      text:
                          "Expired at: ${AppConstant.formattedDataTime("yyyy-MMM-dd", subscription.expiresAt!)}",
                      style: AppThemes.normalBlack45Font),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 120,
                    child: PrimaryButton(
                      buttonStyle: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        backgroundColor: AppThemes.dodgerBlue,
                        shape: StadiumBorder(),
                      ),
                      labelText: 'Renew',
                      textStyle: AppThemes.buttonFont,
                      onPressed: () {
                        // subscriptionController.updatePageInfo(value)
                        if (!kIsWeb) {
                          subscriptionController.makePayment(
                              subscription.netAmount!.round().toString(), 1);
                        }
                        Get.back();
                      },
                    ),
                  ),
                  Container(
                    width: 120,
                    child: PrimaryButton(
                      buttonStyle: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        backgroundColor: AppThemes.rightAnswerColor,
                        shape: StadiumBorder(),
                      ),
                      labelText: 'Upgrade',
                      textStyle: AppThemes.buttonFont,
                      onPressed: () {
                        Get.to(() => SubscriptionUI());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
    );
  }
}
