import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/ui/notifications/notifications_ui.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class NotificationBadgeUI extends StatelessWidget {
  const NotificationBadgeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = 36.0;
    double badgeSize = iconSize / 2;
    return Stack(
      children: [
        InkWell(
          onTap: () {
            notificationController.notificationCount.value = 0;
            Get.to(() => NotificationUI());
          },
          child: Icon(
            Icons.notifications,
            size: iconSize,
            color: Colors.white,
          ),
        ),
        Obx(
          () => notificationController.notificationCount.value > 0
              ? Positioned(
                  top: 3,
                  right: 1,
                  child: Container(
                    width: badgeSize,
                    decoration: new BoxDecoration(
                      color: AppThemes.DEEP_ORANGE,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${notificationController.notificationCount.value}',
                        style: AppThemes.normalBlackFont
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                )
              : Container(),
        ),
      ],
    );
  }
}
