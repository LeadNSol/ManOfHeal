import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class CustomHeaderRow extends StatelessWidget {
  //const CustomHeaderRow({Key? key}) : super(key: key);

  final String? title;
  final bool? hasProfileIcon;
  final bool? isAdmin;

  CustomHeaderRow({this.title, this.hasProfileIcon, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios_new),
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$title',
              style: AppThemes.headerTitleFont,
            ),
          ),
        ),
        hasProfileIcon!
            ? Expanded(
                child: InkWell(
                  onTap: () => Get.toNamed(AppRoutes.profileRoute),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white,
                      ),
                      child: Obx(
                        () => CircularAvatar(
                          padding: 1,
                          imageUrl: authController.userModel!.photoUrl!,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : isAdmin!
                ? Padding(
                    padding: const EdgeInsets.only(right: 3.0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 35,
                            height: 35,
                            child: InkWell(
                              onTap: () =>
                                  Get.to(() => AdminStdSubscriptionUI()),
                              child: Image.asset(
                                "assets/icons/premium_member.png",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 30,
                            height: 30,
                            child: InkWell(
                              onTap: () =>
                                  Get.to(() => FeedBackUI()),
                              child: Icon(
                                Icons.feedback_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () => Get.to(() => UserManagementUI()),
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  )
                : Expanded(child: Container())
      ],
    );
  }
}
