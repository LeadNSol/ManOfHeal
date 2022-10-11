import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/ui/components/black_rounded_container.dart';
import 'package:man_of_heal/ui/components/custom_container.dart';
import 'package:man_of_heal/ui/components/form_input_field_with_icon.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/ui/daily_activity/daily_activity_ui.dart';
import 'package:man_of_heal/ui/daily_activity/widgets/show_give_answer_widgets.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class DailyActivityScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //dailyActivityController.getDailyActivity();

    return Scaffold(
      backgroundColor: AppThemes.BG_COLOR,
      body: Stack(
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
            top: 50,
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
                          onPressed: () => Navigator.of(context).pop(),
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
                            style: GoogleFonts.poppins(
                              fontSize: 23.85,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => Get.to(() => DailyActivityUI()),
                        child: Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            "assets/icons/calendar_icon.svg",
                            color: Colors.white,
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
                                '${dailyActivityController.model!.termOfDay!.isNotEmpty ? dailyActivityController.model!.termOfDay : AppConstant.noTODFound}',
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
                            '${dailyActivityController.model!.qOfDay!.isNotEmpty ? dailyActivityController.model!.qOfDay : AppConstant.noTODFound}',
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
                            activityModel: dailyActivityController.model!,),
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
      floatingActionButton:
          authController.admin.isTrue ? _buildFab(context) : null,
    );
  }

  Widget _buildFab(context) {
    return FloatingActionButton(
      onPressed: () {
        print('Pressed fab');
        // Get.to(()=>AddLabUI());

        Get.bottomSheet(
          getContent(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          ),
          backgroundColor: Colors.white,
        );
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [AppThemes.gradientColor_1, AppThemes.gradientColor_2],
          ),
        ),
        child: Icon(
          Icons.add_rounded,
          size: 30,
        ),
        // child: SvgPicture.asset("assets/icons/fab_icon.svg"),
      ),
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
                controller: dailyActivityController.termOfDayController,
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
                  controller: dailyActivityController.qOfDayController,
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
                        dailyActivityController.addDailyActivity();
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
