import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/ui/auth/welcome_back_ui.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/utils/app_themes.dart';

import '../../controllers/controllers_base.dart';
import '../components/primary_button.dart';

class ProfileUI extends StatelessWidget {
  final profileData = [
    {
      "title": "Phone",
      "subtitle":
          "${authController.userModel.value!.phone ?? 'no phone number'}",
      "icon": "assets/icons/phone_icon.svg"
    },
    {
      "title": "Email",
      "subtitle": "${authController.userModel.value!.email}",
      "icon": "assets/icons/email_icon.svg"
    },
    {
      "title": "Address",
      "subtitle":
          "${authController.userModel.value!.address ?? 'example street, example city, Pakistan'}",
      "icon": "assets/icons/address_icon.svg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 20,
            ),
          ),
          backgroundColor: AppThemes.blackPearl,
          elevation: 0,
          title: Text('Profile'),
        ),
        body: body(context),

        /*Container(
            child: Center(
              child: PrimaryButton(
                onPressed: () {
                  authController.signOut();
                  Get.offAll(SignInUI());
                },
                labelText: 'Sign Out',
              ),
            ),
          )*/
      ),
    );
  }

  Widget body(context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var profileCardTopPos;
    authController.admin.isFalse
        ? profileCardTopPos = 0.23
        : profileCardTopPos = 0.15;
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  //Background rounded bottom left, right black color

                  Container(
                    decoration: BoxDecoration(
                      color: AppThemes.blackPearl,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight / 1.25,
              color: Colors.white70,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  /* */
                  Positioned(
                    top: constraints.maxHeight * profileCardTopPos,
                    left: 0,
                    child: Container(
                      width: constraints.maxWidth,
                      //height: double.infinity,
                      child: Column(
                        children: [
                          ListView(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.all(5),
                            children: profileData
                                .map(
                                  (profile) => profileCards(
                                      textTheme,
                                      profile["title"],
                                      profile["subtitle"],
                                      profile["icon"]),
                                )
                                .toList(),
                          ),
                          FormVerticalSpace(
                            height: 60,
                          ),
                          Container(
                            width: 290,
                            height: 45,
                            child: PrimaryButton(
                              buttonStyle: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  primary: AppThemes.DEEP_ORANGE,
                                  shape: StadiumBorder(),
                                  textStyle: textTheme.headline5),
                              onPressed: () {
                                authController.signOut();
                                Get.offAll(WelcomeBackUI());
                              },
                              labelText: 'Log Out',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -constraints.maxHeight * 0.07,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      AppThemes.DEEP_ORANGE.withOpacity(0.22),
                                  blurRadius: 13,
                                  spreadRadius: 2,
                                  blurStyle: BlurStyle.outer // Shadow position
                                  ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                                "https://cdn-icons-png.flaticon.com/128/3011/3011270.png"),
                          ),
                        ),
                        FormVerticalSpace(
                          height: 15,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                '${authController.userModel.value!.name ?? 'ABC NAME'}\n',
                            style: textTheme.headline6!
                                .copyWith(color: Colors.black),
                            children: [
                              TextSpan(
                                text: "Lower Dir, Pakistan",
                                style: textTheme.caption!.copyWith(
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        FormVerticalSpace(
                          height: 10,
                        ),
                        Visibility(
                          visible: authController.admin.isFalse,
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/icons/premium_member.png",
                              ),
                              FormVerticalSpace(
                                height: 10,
                              ),
                              Text(
                                "Premium Member",
                                style: textTheme.bodyText1!.copyWith(
                                    color: AppThemes.PREMIUM_OPTION_COLOR),
                              ),
                              FormVerticalSpace(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget profileCards(TextTheme textTheme, title, subtitle, icon) {
    return Container(
      width: 290,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppThemes.DEEP_ORANGE.withOpacity(0.3)),
      ),
      margin: EdgeInsets.only(left: 30, top: 12, right: 30, bottom: 3),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(left: 10.0, right: 0.0),
        title: Text(
          '$title',
          style: textTheme.bodyText1!.copyWith(color: Colors.black87),
        ),
        subtitle: Text(
          //'+92 302-5580842',
          '$subtitle',
          style: textTheme.bodyText1!.copyWith(color: Colors.black87),
        ),
        leading: SvgPicture.asset(icon),
      ),
    );
  }
}
