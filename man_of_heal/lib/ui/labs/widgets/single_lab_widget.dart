import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/lab_model.dart';
import 'package:man_of_heal/models/user_model.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/labs/widgets/lab_details_widget.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class SingleLabWidget extends StatelessWidget {
  final LabModel labModel;

  SingleLabWidget(this.labModel);

  @override
  Widget build(BuildContext context) {
    var userName = "fetching...".obs;
    getUserById().then((UserModel model) {
      userName.value = model.name!;
    });

    return GestureDetector(
      onTap: () {
        labModel.adminName = userName.value;
        Get.to(() => LabDetails(labModel));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppThemes.DEEP_ORANGE.withOpacity(0.26),
              blurRadius: 10.78,
              offset: Offset(0, 0),
              // Shadow position
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ListTile(
            dense: false,
            contentPadding: EdgeInsets.only(left: 10.0, right: 20.0),
            leading: Container(
              //width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: AppThemes.DEEP_ORANGE.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Image.network(
                  labModel.imageIconUrl!.isNotEmpty
                      ? labModel.imageIconUrl!
                      : "https://cdn-icons-png.flaticon.com/128/3011/3011270.png",
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              '${labModel.title}',
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: AppThemes.headerItemTitle,
            ),
            subtitle: Column(
              children: [
                FormVerticalSpace(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${labModel.shortDescription}',
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: AppThemes.normalBlack45Font,
                  ),
                ),
                FormVerticalSpace(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'By:  ',
                                style: AppThemes.normalBlackFont),
                            TextSpan(
                                text: userName.value,
                                style: AppThemes.normalBlackFont),
                          ],
                        ),
                      ),
                    ),

                    //Date and time
                    Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Image.asset(
                                "assets/icons/estimated_time_green_icon.png",
                                width: 12,
                              ),
                            ),
                            TextSpan(
                              text:
                                  " ${AppConstant.formattedDataTime("MM.dd.yyyy", labModel.createdDate!)}",
                              style: AppThemes.normalBlack45Font,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<UserModel> getUserById() {
    return authController.getUserById(labModel.adminId!);
  }
}
