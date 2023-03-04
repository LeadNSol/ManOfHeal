import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';
import 'package:man_of_heal/models/export_models.dart';

class SubscriptionBody extends GetView<SubscriptionController> {
  @override
  Widget build(BuildContext context) {
    /// btn state default
    authController.setBtnState(0);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ///white background
            Container(
              //height: 250,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),

            PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.updatePageInfo,
              itemCount: controller.onBoardingPages.length,
              itemBuilder: (context, index) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  FormVerticalSpace(
                    height: 50,
                  ),
                  SvgPicture.asset(
                      "assets/icons/subscription_${index + 1}_icon.svg"),
                  SizedBox(height: 80),
                  RichText(
                    text: TextSpan(
                      text: '\$${controller.onBoardingPages[index].price!} ',
                      style: AppThemes.header1.copyWith(fontSize: 51.82),
                      children: [
                        TextSpan(
                          text: ' /mo',
                          style: AppThemes.header3.copyWith(fontSize: 22),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      controller.onBoardingPages[index].description!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// dots in left side
            Positioned(
              bottom: 50,
              left: 20,
              child: Row(
                children: List.generate(
                  controller.onBoardingPages.length,
                  (index) => Obx(() {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: controller.selectedPageIndex.value == index
                            ? Colors.black
                            : Color(0xff707070),
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ),
            ),

            /// get started button.
            Positioned(
              right: 30,
              bottom: 40,
              child: Obx(() => _setupButton()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _setupButton() {
    if (authController.btnState! == 1)
      return Container(
        width: 45,
        height: 45,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppThemes.DEEP_ORANGE,
        ),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 2.5,
        ),
      );
    else if (authController.btnState! == 2)
      return Container(
          width: 45,
          height: 45,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppThemes.rightAnswerColor,
          ),
          child: Center(
              child: Icon(Icons.check, size: 30, color: AppThemes.white)));
    return Container(
      width: 130,
      child: PrimaryButton(
          buttonStyle: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            backgroundColor: AppThemes.DEEP_ORANGE,
            shape: StadiumBorder(),
          ),
          labelText: 'Get Started',
          textStyle: AppThemes.buttonFont,
          onPressed: () {
            // calling for 0 --- new, 1--- Renew
            if (!kIsWeb) {
              Subscription subscription = controller.subsFirebase!;
              if (subscription.paymentId != null) {
                if (Timestamp.now().compareTo(subscription.expiresAt!) <= 0) {
                  AppConstant.displaySuccessSnackBar(
                      "Subscription Alert!", "You have already Purchased");
                } else {
                  // calling for 0 --- new, 1--- Renew
                  controller.makePayment(controller.planPrice, 0);
                }
              } else {
                controller.makePayment(controller.planPrice, 0);
              }
            }
          }),
    );
  }
}
