// import 'package:flutter/material.dart';
//
// class StandardSubscription extends StatefulWidget {
//   const StandardSubscription({Key? key}) : super(key: key);
//
//   @override
//   _StandardSubscriptionState createState() => _StandardSubscriptionState();
// }
//
// class _StandardSubscriptionState extends State<StandardSubscription> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         padding: EdgeInsets.zero,
//         children: [
//
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class StandardSubscription extends StatelessWidget {
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
              color: Colors.white,
            ),
          ),
          SafeArea(
            child: PageView.builder(
              controller: subscriptionController.pageController,
              onPageChanged: subscriptionController.selectedPageIndex,
              itemCount: subscriptionController.onBoardingPages.length,
              itemBuilder: (context, index) => Column(
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
                      text:
                          '\$${subscriptionController.onBoardingPages[index].price!} ',
                      style: textTheme.headline3!
                          .copyWith(color: Colors.black, fontSize: 50),
                      children: [
                        TextSpan(
                          text: '\t /mo',
                          style: textTheme.bodyText1!
                              .copyWith(color: Colors.black, fontSize: 22),
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
                      style: textTheme.bodyText1!.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
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
                          ? Colors.black
                          : Color(0xff707070),
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
                    primary: Color(0xffFC2125),
                    shape: StadiumBorder(),
                  ),
                  labelText: 'Get Started',
                  textStyle:
                      textTheme.bodyText1!.copyWith(color: AppThemes.white),
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
