import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/feedback_model.dart';
import 'package:man_of_heal/models/user_model.dart';
import 'package:man_of_heal/ui/components/custom_container.dart';
import 'package:man_of_heal/ui/components/not_found_data_widget.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class FeedBackUI extends StatelessWidget {
  const FeedBackUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppThemes.BG_COLOR,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppThemes.BG_COLOR,
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
        ),
        title: Text(
          "Feedbacks",
          style: AppThemes.headerTitleBlackFont,
        ),
      ),
      body: body(context),
    );
  }

  Widget body(context) {
    return Obx(
      () => feedBackController.currentAdminFeedBackList.isEmpty
          ? NoDataFound()
          : ListView.builder(
              shrinkWrap: true,
              itemCount: feedBackController.currentAdminFeedBackList.length,
              itemBuilder: (_, index) {
                FeedbackModel model =
                    feedBackController.currentAdminFeedBackList[index];
                return SingleFeedBackItem(model);
              },
            ),
    );
  }

  Widget SingleFeedBackItem(FeedbackModel model) {
    final UserModel? userModel =
        authController.getUserFromListById(model.studentId!);
    final  isOverFlowVisible = false.obs;

    return CustomContainer(
      child: ListTile(
        onTap: () => isOverFlowVisible.value = !isOverFlowVisible.value,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(userModel!.photoUrl!),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${userModel.name}",
              style: AppThemes.normalORANGEFont,
            ),
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.favorite,
                      size: 13,
                      color: AppThemes.DEEP_ORANGE,
                    ),
                  ),
                  TextSpan(
                      text: " ${model.ratings!}",
                      style: AppThemes.normalBlack45Font)
                ],
              ),
            ),
            Obx(() => Text(
                  "${model.remarks!}",
                  style: AppThemes.normalBlack45Font,
                  maxLines:
                      isOverFlowVisible.isTrue ? model.remarks!.length : 2,
                  overflow: TextOverflow.ellipsis,
                )),
          ],
        ),
      ),
    );
  }
}
