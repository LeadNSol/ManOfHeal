import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/ui/components/base_widget.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

import '../components/custom_floating_action_button.dart';

class DailyActivityScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DailyActivityController controller = Get.put(DailyActivityController());

  @override
  Widget build(BuildContext context) {
    //dailyActivityController.getDailyActivity();

    return BaseWidget(
      //backgroundColor: AppThemes.BG_COLOR,
      statusBarIconBrightness: Brightness.light,
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// black background
          Positioned(
            top: 0,
            height: 225,
            left: 0,
            right: 0,
            child: BlackRoundedContainer(),
          ),

          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        // child: Icon(
                        //   Icons.arrow_back_ios,
                        //   color: Colors.white,
                        // ),
                        child: IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(Icons.arrow_back_ios),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Daily Activity',
                            style: AppThemes.headerTitleFont
                          )),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => Get.to(() => DailyActivityUI()),
                        child: Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            "assets/icons/calendar_icon.svg",
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(Colors.white, BlendMode.color),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// Term of the day
                CustomContainer(
                  height: 90,
                  margin: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    top: 90,
                  ),
                  child: Obx(
                    () => Column(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Term Of The Day',
                              style: AppThemes.headerTitle,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                '${controller.model!.termOfDay!.isNotEmpty ? controller.model!.termOfDay : AppConstant.noTODFound}',
                                style: AppThemes.header4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FormVerticalSpace(),

                /// Question of the day
                CustomContainer(
                  margin: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Question of the day',
                          style: AppThemes.headerTitle,
                        ),
                      ),
                      SizedBox(height: 15),
                      Obx(
                        () => Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${controller.model!.qOfDay!.isNotEmpty ? controller.model!.qOfDay : AppConstant.noTODFound}',
                            style: AppThemes.header4,
                          ),
                        ),
                      ),
                      FormVerticalSpace(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ShowGiveAnswerButtons(
                          showAnswerForCurrentDate: true,
                          activityModel: controller.model!,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingButton: AppCommons.isAdmin ? _buildFab(context) : null,
    );
  }

  Widget _buildFab(context) {
    return CustomFloatingActionButton(
      onPressed: () {
        Get.bottomSheet(
          getContent(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }

  Widget getContent(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Add Question & Term of Day",
                  style: AppThemes.dialogTitleHeader,
                ),
              ),
              FormVerticalSpace(),
              FormInputFieldWithIcon(
                controller: controller.termOfDayController,
                iconPrefix: Icons.text_snippet_outlined,
                labelText: 'Term of the Day',
                maxLines: 1,
                autofocus: false,
                iconColor: AppThemes.DEEP_ORANGE,
                textStyle: AppThemes.normalBlackFont,
                maxLength: 100,
                // validator: Validator().name,
                onChanged: (value) => null,
                onSaved: (value) => null,
              ),
              FormVerticalSpace(),
              Container(
                height: 150,
                child: FormInputFieldWithIcon(
                  controller: controller.qOfDayController,
                  iconPrefix: Icons.note,
                  labelText: 'Question of the Day',
                  isExpanded: true,
                  autofocus: false,
                  iconColor: AppThemes.DEEP_ORANGE,
                  textStyle: AppThemes.normalBlackFont,
                  // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  maxLength: 1000,
                  //validator: Validator().notEmpty,
                  onChanged: (value) => null,
                  onSaved: (value) => null,
                ),
              ),
              FormVerticalSpace(),
              Center(
                child: Container(
                  width: 150,
                  child: PrimaryButton(
                    labelText: 'Submit',
                    textStyle: AppThemes.buttonFont,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        SystemChannels.textInput.invokeMethod(
                            'TextInput.hide'); //to hide the keyboard - if any
                        controller.addDailyActivity();
                        Get.back();
                        //print('added');
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
