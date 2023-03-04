import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class QuestionDetails extends GetView<QAController> {
  final QuestionModel? questionModel;
  final int index;

  QuestionDetails(this.questionModel, this.index);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppThemes.BG_COLOR,
        body: statusBody(context),
        //_statusBody(context),
      ),
    );
  }

  Widget statusBody(context) {
    int endTime = questionModel!.toBeAnsweredIn!.millisecondsSinceEpoch;
    return Stack(
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
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              FormVerticalSpace(),
              CustomHeaderRow(
                title: "Status",
                hasProfileIcon: true,
              ),
              FormVerticalSpace(
                height: AppConstant.getScreenHeight(context) * 0.12,
              ),

              /// Timer
              CustomContainer(
                hasOuterShadow: true,
                height: 110,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: CountdownTimer(
                    endTime: endTime,
                    widgetBuilder: (context, CurrentRemainingTime? time) {
                      if (time == null) {
                        return Text(
                          'Time over',
                          style: GoogleFonts.poppins(
                              fontSize: 63,
                              color: AppThemes.DEEP_ORANGE.withOpacity(0.7)),
                        );
                      }
                      return Text(
                          '${time.hours! < 10 ? "0${time.hours}" : time.hours}'
                          ':${time.min! < 10 ? "0${time.min}" : time.min}'
                          ':${time.sec! < 10 ? "0${time.sec}" : time.sec}',
                          style: GoogleFonts.poppins(
                              fontSize: 63,
                              color: AppThemes.DEEP_ORANGE.withOpacity(0.7)));
                    },
                  ),
                ),
              ),

              CustomContainer(
                hasOuterShadow: true,
                height: AppConstant.getScreenHeight(context) * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AppConstant.textWidget('Question ${index + 1}',
                        questionModel!.question, AppThemes.normalBlack45Font),

                    FormVerticalSpace(
                      height: 15,
                    ),

                    ///Category
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: AppThemes.DEEP_ORANGE.withOpacity(0.5))),
                      child: Text(
                        '${controller.categoryController!.getCategoryById(questionModel!.category)}',
                        style: GoogleFonts.poppins(
                            fontSize: 9, fontWeight: FontWeight.w600),
                      ),
                    ),
                    FormVerticalSpace(),

                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Image.asset(
                              "assets/icons/estimated_time_icon.png",
                              width: 13,
                            ),
                          ),
                          TextSpan(
                            text: "  Start Time",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 9),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${AppConstant.formattedDataTime("hh:mm a, MMM dd yyyy", questionModel!.qCreatedDate!)}',
                      style: GoogleFonts.poppins(
                          fontSize: 14.28, fontWeight: FontWeight.w600),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Answer Status:   ",
                              style: GoogleFonts.poppins(
                                  fontSize: 14.28,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                          TextSpan(
                            text: "Pending",
                            style: GoogleFonts.poppins(
                              fontSize: 14.28,
                              color: Colors.black45,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                    FormVerticalSpace()
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
