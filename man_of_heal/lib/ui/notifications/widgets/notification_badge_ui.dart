import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class NotificationBadgeUI extends GetView<NotificationController> {
  const NotificationBadgeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = 30.0;
    double badgeSize = iconSize / 2;
    return Stack(
      children: [
        InkWell(
          onTap: () {
            controller.notificationCount.value = 0;
            Get.to(() => NotificationUI());
          },
          child: Icon(
            Icons.notifications,
            size: iconSize,
            color: Colors.white,
          ),
        ),
        Obx(
          () => controller.notificationCount.value > 0
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
                        '${controller.notificationCount.value}',
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
