import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/components/base_widget.dart';
import 'package:man_of_heal/ui/components/custom_floating_action_button.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class StudentHome extends StatelessWidget {
  final SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  final LandingPageController controller = Get.put(LandingPageController());
  @override
  Widget build(BuildContext context) {
    //_initControllers();

    return Obx(
      () => BaseWidget(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        child: controller.currentStudentPage,
        bottomNaviBar: _bottomCircularNotchedBar(),
        floatingButton: CustomFloatingActionButton(
          onPressed: () {
            if (AppCommons.userModel!.isTrailFinished!) {
              final subscription = subscriptionController.subsFirebase;
              if (subscription?.paymentId != null) {
                final isExpired =
                    Timestamp.now().compareTo(subscription!.expiresAt!) > 0;
                if (isExpired) {
                  showSubscriptionBottomSheet(subscription);
                } else {
                  showQuestionBottomSheet();
                }
              } else {
                Get.to(() => SubscriptionUI());
              }
            } else {
              showQuestionBottomSheet();
            }
          },
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

  _bottomCircularNotchedBar() {
    final _inactiveColor = Colors.grey;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        BottomAppBar(
          notchMargin: 8,
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          child: SizedBox(
            width: double.infinity,
              height:
                  50), // Sets height for BottomAppBar to match BottomNavigationBar
        ),
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: Obx(
            () => BottomNavigationBar(
              currentIndex: controller.studentTabIndex.value,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: AppThemes.DEEP_ORANGE,
              selectedLabelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 10),
              unselectedLabelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 10),
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
        ),
      ],
    );

    // return BottomAppBar(
    //   color: AppThemes.rightAnswerColor,
    //   notchMargin: 8,
    //   //color: Colors.transparent,
    //   //clipBehavior: Clip.antiAliasWithSaveLayer,
    //   elevation: 5,
    //   shape: CircularNotchedRectangle(),
    //   child: Obx(
    //     () => BottomNavigationBar(
    //       currentIndex: controller.studentTabIndex.value,
    //       backgroundColor: Colors.transparent,
    //       elevation: 0,
    //       selectedItemColor: AppThemes.DEEP_ORANGE,
    //       selectedLabelStyle: GoogleFonts.poppins(
    //         fontWeight: FontWeight.w500, fontSize: 10),
    //       unselectedLabelStyle: GoogleFonts.poppins(
    //         fontWeight: FontWeight.w500, fontSize: 10),
    //       unselectedItemColor: _inactiveColor,
    //       onTap: onTapped,
    //       items: [
    //         BottomNavigationBarItem(
    //             icon: Icon(Icons.home_outlined), label: "Home"),
    //         BottomNavigationBarItem(
    //             icon: Icon(Icons.favorite_outline), label: "Favorite"),
    //       ],
    //     ),
    //   ),
    // );
  }

  onTapped(int index) {
    controller.setStudentPage(index);
    //if (index == 1) landingPageController.setCalledFor("Answered");
  }

  void showSubscriptionBottomSheet(Subscription subscription) {
    // final subscriptionController = Get.find();
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
