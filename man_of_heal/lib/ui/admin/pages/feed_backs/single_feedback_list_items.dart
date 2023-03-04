import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:flutter/material.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class SingleFeedbackListItem extends GetView<FeedBackController> {
  const SingleFeedbackListItem({Key? key, this.model}) : super(key: key);
  final FeedbackModel? model;

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = controller.getFeedbackUser(model!.studentId);

    return CustomContainer(
      child: ListTile(
        onTap: () => controller.isSeeMoreClicked.value =
            !controller.isSeeMoreClicked.value,
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
                      text: " ${model!.ratings!}",
                      style: AppThemes.normalBlack45Font)
                ],
              ),
            ),
            Obx(() => Text(
                  "${model!.remarks!}",
                  style: AppThemes.normalBlack45Font,
                  maxLines: controller.isSeeMoreClicked.isTrue
                      ? model!.remarks!.length
                      : 2,
                  overflow: TextOverflow.ellipsis,
                )),
          ],
        ),
      ),
    );
  }
}
