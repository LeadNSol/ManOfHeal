import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class NotificationUI extends GetView<NotificationController> {
  const NotificationUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.BG_COLOR,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppThemes.BG_COLOR,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
        ),
        title: Text(
          "Notifications",
          style: AppThemes.headerTitleBlackFont,
        ),
      ),
      body: Obx(
        () => controller.notificationList.isEmpty
            ? Center(
                child: Text(
                  "No Notification received yet?",
                  style: AppThemes.normalBlackFont,
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.notificationList.length,
                itemBuilder: (_, index) {
                  NotificationModel model =
                      controller.notificationList[index];
                  return CustomContainer(
                    isNotificationBody: model.isRead!=null? !model.isRead! : false,
                    child: ListTile(
                      onTap: () => controller
                          .updateNotificationIsRead(model),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${model.title}",
                            style: AppThemes.normalORANGEFont,
                          ),
                          FormVerticalSpace(height: 1,),
                          Text(
                            AppConstant.getAgoDateTime(model.sentTime),
                            style: AppThemes.captionFont,
                          ),
                          FormVerticalSpace(height: 10,),
                          Text(
                            "${model.body}",
                            maxLines: 3,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: AppThemes.normalBlack45Font
                                .copyWith(fontSize: 12),
                          ),

                        ],
                      ),
                      trailing: InkWell(
                        onTap: () =>
                            {controller.deleteNotification(model)},
                        child: Icon(
                          Icons.delete,
                          color: AppThemes.DEEP_ORANGE,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
