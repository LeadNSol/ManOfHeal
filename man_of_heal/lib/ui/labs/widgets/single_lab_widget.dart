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

    TextTheme _textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        labModel.adminName = userName.value;
        Get.to(LabDetails(labModel));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppThemes.DEEP_ORANGE.withOpacity(0.26),
              blurRadius: 4,
              spreadRadius: 2,
              offset: Offset(2, 3),
              // Shadow position
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ListTile(
            dense: true,
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
                  child: labModel.imageIconUrl!.isNotEmpty
                      ? Image.network(labModel.imageIconUrl!,height: 70, fit: BoxFit.cover,)
                      : Image.network("https://cdn-icons-png.flaticon.com/128/3011/3011270.png"),
                )),
            title: Text(
              '${labModel.title}',
              style: _textTheme.headline6,
            ),
            subtitle: Column(
              children: [
                FormVerticalSpace(height: 10,),
                Text(
                  '${labModel.shortDescription}',
                  style: _textTheme.bodyText1,
                ),
                FormVerticalSpace(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                        ()=> RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'By: ',
                                style: _textTheme.bodyText1!
                                    .copyWith(fontWeight: FontWeight.w500)),
                            TextSpan(
                                text: userName.value, style: _textTheme.subtitle2!.copyWith(fontSize: 13)),
                          ],
                        ),
                      ),
                    ),

                    //Date and time
                    RichText(
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
                                " ${AppConstant.convertToFormattedDataTime("MM.dd.yyyy", labModel.createdDate!)}",
                            style: _textTheme.subtitle1!.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
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
