import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/models/lab_model.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/profile/profile_ui.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class LabDetails extends StatelessWidget {
  final LabModel labModel;

  LabDetails(this.labModel);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        /* appBar: AppBar(
          leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 20,
            ),
          ),
          title: Text('Lab Details'),
        ),*/
        body: _detailsLabBody(context),
      ),
    );
  }

  Widget _detailsLabBody(context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    //background round shape with black color
                    Container(
                      decoration: BoxDecoration(
                        color: AppThemes.blackPearl,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Header profile icon and Dashboard Text...
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () => Get.back(),
                                    child: Icon(
                                      Icons.arrow_back_ios_new,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Lab Details',
                                    style: textTheme.headline6!.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: AppThemes.white),
                                  ),
                                ],
                              ),

                              //profile icon
                              InkWell(
                                onTap: () {
                                  Get.to(ProfileUI());
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Image.network(
                                        "https://cdn-icons-png.flaticon.com/128/3011/3011270.png"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          FormVerticalSpace(),
                          Container(
                            height: 100,
                            width: constraints.maxWidth,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Image.network(
                                labModel.imageIconUrl!,
                              ),
                            ),
                          ),
                          Expanded(child: Center()),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight / 1.5,
                color: AppThemes.BG_COLOR,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: -constraints.maxHeight * 0.05,
                      child: Container(
                        width: constraints.maxWidth * 0.89,
                        height: constraints.maxHeight * 0.60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppThemes.DEEP_ORANGE.withOpacity(0.26),
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: Offset(2, 3),
                              //blurStyle: BlurStyle.outer // Shadow position
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _headerWidget(textTheme),
                                FormVerticalSpace(),
                                SingleChildScrollView(
                                  child: Text(
                                    labModel.longDescription!,
                                    style: textTheme.bodyText2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _headerWidget(TextTheme textTheme) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${labModel.title}',
              style: textTheme.headline6,
            ),
            FormVerticalSpace(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'By ${labModel.adminName}',
                  style: textTheme.bodyText2!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 30,
                ),
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
                            "  ${AppConstant.convertToFormattedDataTime("MM.dd.yyyy", labModel.createdDate!)}",
                        style: textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
