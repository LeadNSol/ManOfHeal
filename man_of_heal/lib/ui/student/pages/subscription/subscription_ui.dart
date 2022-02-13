import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class SubscriptionUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      /*  appBar: AppBar(
        title: Text('Monthly Subscriptions'),
        elevation: 0,
      ),*/
      body: Stack(
        children: [
          Container(
            //height: 250,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [AppThemes.gradientColor_1, AppThemes.gradientColor_2],
              ),
            ),
          ),
          SafeArea(
            child: PageView.builder(
              controller: subscriptionController.pageController,
              onPageChanged: subscriptionController.selectedPageIndex,
              itemCount: subscriptionController.onBoardingPages.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () => Get.back(),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
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
                          text:
                              '\$${subscriptionController.onBoardingPages[index].price!} ',
                          style: textTheme.headline3!
                              .copyWith(color: AppThemes.white, fontSize: 50),
                          children: [
                            TextSpan(
                              text: '\t /mo',
                              style: textTheme.bodyText1!.copyWith(
                                  color: AppThemes.white, fontSize: 22),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 64.0),
                        child: Text(
                          subscriptionController
                              .onBoardingPages[index].description!,
                          textAlign: TextAlign.center,
                          style: textTheme.bodyText1!
                              .copyWith(color: Colors.white),
                        ),
                      ),

                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            child: Row(
              children: List.generate(
                subscriptionController.onBoardingPages.length,
                (index) => Obx(() {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: subscriptionController.selectedPageIndex.value ==
                              index
                          ? Colors.white
                          : Colors.deepOrange,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: 40,
            child: Container(
              width: 100,
              child: PrimaryButton(
                  buttonStyle: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    primary: AppThemes.white,
                    shape: StadiumBorder(),
                  ),
                  labelText: 'Get Started',
                  textStyle: textTheme.bodyText1!
                      .copyWith(color: AppThemes.blackPearl),
                  onPressed: () {}),
            ),
          ),
        ],
      ),
    );
  }

  Widget _subscriptionPlans(_title, _noOfQuestions, _price, onPress) {
    return Container(
      width: 170,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            FormVerticalSpace(
              height: 10,
            ),
            Container(
              child: Text(
                _title,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            FormVerticalSpace(),
            Container(
              child: Text(
                '$_noOfQuestions Question in 72 hours.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            FormVerticalSpace(
              height: 10,
            ),
            Container(
              child: Text(
                '\$$_price /month',
                style: TextStyle(fontSize: 20, color: Colors.deepPurple),
              ),
            ),
            FormVerticalSpace(
              height: 15,
            ),
            PrimaryButton(
              labelText: "Select",
              onPressed: () {
                subscriptionController.createSubscription(
                    _title, _price, _noOfQuestions);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
