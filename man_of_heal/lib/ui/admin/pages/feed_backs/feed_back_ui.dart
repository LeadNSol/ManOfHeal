import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/admin/pages/feed_backs/single_feedback_list_items.dart';
import 'package:man_of_heal/ui/components/base_widget.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class FeedBackUI extends StatelessWidget {
   FeedBackUI({Key? key}) : super(key: key);
  final FeedBackController controller = Get.put(FeedBackController());


  @override
  Widget build(BuildContext context) {
    return BaseWidget(
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
      child: body(context),
    );
  }

  Widget body(context) {
    return Obx(
      () => controller.currentAdminFeedBackList.isEmpty
          ? NoDataFound()
          : ListView.builder(
              shrinkWrap: true,
              itemCount: controller.currentAdminFeedBackList.length,
              itemBuilder: (_, index) {
                FeedbackModel model =
                    controller.currentAdminFeedBackList[index];
                return SingleFeedbackListItem(model: model);
              },
            ),
    );
  }

  Widget singleFeedBackItem(FeedbackModel model) {
    final UserModel? userModel =
        controller.authController?.getUserFromListById(model.studentId!);
    final isSeeMoreClicked = false.obs;

    return CustomContainer(
      child: ListTile(
        onTap: () => isSeeMoreClicked.value = !isSeeMoreClicked.value,
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
                  maxLines: isSeeMoreClicked.isTrue ? model.remarks!.length : 2,
                  overflow: TextOverflow.ellipsis,
                )),
          ],
        ),
      ),
    );
  }
}
