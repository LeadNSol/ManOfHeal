import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class AdminStdSubscriptionUI extends GetView<SubscriptionController> {
  const AdminStdSubscriptionUI({Key? key}) : super(key: key);

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
          "Student Subscription",
          style: AppThemes.headerTitleBlackFont,
        ),
      ),
      body: body(context),
    );
  }

  Widget body(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: TextField(
            cursorColor: AppThemes.DEEP_ORANGE,
            controller: controller.searchController,
            onChanged: (search) =>
                {controller.handleSearch(search)},
            textInputAction: TextInputAction.search,
            decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(12.0),
                prefixIcon: new Icon(
                  Icons.search,
                  color: AppThemes.DEEP_ORANGE,
                ),
                border: InputBorder.none.copyWith(
                  borderSide: BorderSide(style: BorderStyle.solid),
                ),
                labelStyle: AppThemes.normalBlackFont,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppThemes.DEEP_ORANGE,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppThemes.DEEP_ORANGE,
                    width: 1.0,
                  ),
                ),
                hintText: 'Search in ...'),
          ),
        ),
        FormVerticalSpace(
          height: 10,
        ),
        Obx(
          () => controller.stdSubscriptionList.isNotEmpty
              ? controller.searchList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.searchList.length,
                          itemBuilder: (context, index) {
                            StudentSubscription? stdSubsModel =
                                controller.searchList[index];
                            return SingleSubscriptionItem(
                                stdModel: stdSubsModel);
                          }),
                    )
                  : Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              controller.stdSubscriptionList.length,
                          itemBuilder: (context, index) {
                            StudentSubscription? stdSubsModel =
                                controller
                                    .stdSubscriptionList[index];
                            return SingleSubscriptionItem(
                                stdModel: stdSubsModel);
                          }),
                    )
              : NoDataFound(),
        ),
      ],
    );
  }
}

class SingleSubscriptionItem extends GetView<SubscriptionController> {
  const SingleSubscriptionItem({Key? key, this.stdModel}) : super(key: key);
  final StudentSubscription? stdModel;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsets.only(top: 10, bottom: 15, right: 5, left: 5),
      margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CircularAvatar(
              padding: 3,
              radius: 20,
              imageUrl: stdModel?.userModel!.photoUrl!,
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stdModel!.userModel?.name??"",
                  style: AppThemes.header2.copyWith(color: AppThemes.DEEP_ORANGE),
                ),
                _textWidget("Email", stdModel!.userModel?.email??""),
                _textWidget("Phone", stdModel!.userModel!.phone??""),
                _textWidget("Plan", stdModel!.subscription!.planName??""),
                _textWidget(
                    "Subscribe at",
                    AppConstant.formattedDataTime(
                        "yyyy-MMM-dd", stdModel!.subscription!.createAt!)),
                _textWidget(
                    "Expired at",
                    AppConstant.formattedDataTime(
                        "yyyy-MMM-dd", stdModel!.subscription!.expiresAt!)),
              ],
            ),
          ),
          Expanded(
            child: Text(
              stdModel!.subscription!.expiresAt!.compareTo(Timestamp.now()) <= 0
                  ? "Expired"
                  : "Days Left: \n ${AppConstant.daysBetween(stdModel!.subscription!.expiresAt!.toDate(), DateTime.now())}",
              style: AppThemes.normalORANGEFont.copyWith(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _textWidget(title, value) {
    if(title.toString().toLowerCase().contains("email") && value.toString().length > 20) {
      print("Email Length: ${value.toString().length}");

      return RichText(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(children: [
            TextSpan(
                text: "$title:  ",
                style: AppThemes.normalBlackFont.copyWith(fontSize: 11)),
            TextSpan(
                text: value,
                style: AppThemes.normalBlack45Font.copyWith(fontSize: 11))
          ]));
    }
    return RichText(
        text: TextSpan(children: [
          TextSpan(
              text: "$title:  ",
              style: AppThemes.normalBlackFont.copyWith(fontSize: 11)),
          TextSpan(
              text: value,
              style: AppThemes.normalBlack45Font.copyWith(fontSize: 11))
        ]));
  }
}
