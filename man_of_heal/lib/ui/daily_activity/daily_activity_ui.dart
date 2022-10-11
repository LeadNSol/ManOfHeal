import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/daily_activity_model.dart';
import 'package:man_of_heal/ui/components/black_rounded_container.dart';
import 'package:man_of_heal/ui/components/custom_container.dart';
import 'package:man_of_heal/ui/components/custom_header_row.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/daily_activity/widgets/show_give_answer_widgets.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class DailyActivityUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppThemes.BG_COLOR,
        body: bodyNew(context),
      ),
    );
  }

  Widget bodyNew(context) {
    var _currentSelectedDate = DateTime.now().obs;
    var qod = AppConstant.loremIpsum.obs;
    var tod = "DVT".obs;
    var dailyActivityModel = DailyActivityModel().obs;
    dailyActivityController
        .getDailyActivityByDate(Timestamp.fromDate(_currentSelectedDate.value))
        .then((DailyActivityModel model) => {
              dailyActivityModel.value = model,
              if (model.termOfDay!.isEmpty && model.qOfDay!.isEmpty)
                {
                  qod(AppConstant.noQODFound),
                  tod(AppConstant.noTODFound),
                }
              else
                {
                  qod.value = model.qOfDay!,
                  tod.value = model.termOfDay!,
                }
            });

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.antiAlias,
      children: [
        /// black background
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 225,
          child: BlackRoundedContainer(),
        ),

        Positioned(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              FormVerticalSpace(),

              /// Header
              CustomHeaderRow(
                title: "Daily Activity",
                hasProfileIcon: false,
                isAdmin: false,
              ),

              /// Calendar container
              CustomContainer(
                height: AppConstant.getScreenHeight(context) * (kIsWeb? 0.6:0.45),
                margin: EdgeInsets.only(
                  left: 17.0,
                  right: 17.0,
                  top: 90,
                ),
                //padding: EdgeInsets.all(15.0),
                child: Obx(
                  () => CalendarCarousel<Event>(
                    onDayPressed: (DateTime date, List<Event> events) {
                      //print('CalendarDate: $date');

                      _currentSelectedDate.value = date;
                      dailyActivityController
                          .setCurrentDate(Timestamp.fromDate(date));
                      dailyActivityController
                          .getDailyActivityByDate(Timestamp.fromDate(date))
                          .then((DailyActivityModel model) {
                        dailyActivityModel.value = model;
                        qod.value = model.qOfDay!.isNotEmpty
                            ? model.qOfDay!
                            : AppConstant.noQODFound;

                        tod.value = model.termOfDay!.isNotEmpty
                            ? model.termOfDay!
                            : AppConstant.noTODFound;
                      });
                    },
                    weekDayMargin: const EdgeInsets.symmetric(vertical: 1),
                    headerMargin: EdgeInsets.symmetric(vertical: kIsWeb?2:16),
                    dayPadding: kIsWeb?1:2,
                    thisMonthDayBorderColor: Colors.transparent,
                    weekFormat: false,
                    pageScrollPhysics: const NeverScrollableScrollPhysics(),
                    selectedDateTime: _currentSelectedDate.value,
                    selectedDayButtonColor: AppThemes.DEEP_ORANGE,
                    selectedDayBorderColor: Colors.transparent,
                    selectedDayTextStyle:
                        GoogleFonts.poppins(color: Colors.white),
                    daysHaveCircularBorder: true,
                    todayButtonColor:
                        _currentSelectedDate.value == DateTime.now()
                            ? Colors.transparent
                            : Colors.transparent,
                    todayTextStyle: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _currentSelectedDate.value == DateTime.now()
                            ? Colors.white
                            : Colors.black),
                    todayBorderColor: Colors.transparent,
                    weekendTextStyle: AppThemes.normalBlackFont,
                    headerTextStyle: AppThemes.headerItemTitle,
                    iconColor: Colors.black,
                    daysTextStyle: AppThemes.normalBlackFont,
                    weekdayTextStyle: AppThemes.header2,
                    //markedDateShowIcon: true,
                    weekDayFormat: WeekdayFormat.narrow,
                  ),
                ),
              ),

              /// Today's activity
              CustomContainer(
                margin: EdgeInsets.only(
                  left: 17.0,
                  right: 17.0,
                  top: 30,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Today's Activity",
                    style: GoogleFonts.poppins(
                      fontSize: 14.28,
                      color: AppThemes.DEEP_ORANGE, //Color(0xffFC2125),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              ///TOD
              Obx(
                () => CustomContainer(
                  height: 90,
                  margin: EdgeInsets.only(
                    left: 17.0,
                    right: 17.0,
                    top: 15,
                  ),
                  child: Column(
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
                            '${tod.value}',
                            style: AppThemes.header4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// QOD
              Obx(
                () => CustomContainer(
                  margin: EdgeInsets.only(
                    left: 17.0,
                    right: 17.0,
                    top: 15,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Question of the day',
                          style: AppThemes.headerTitle,
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${qod.value}',
                          style: AppThemes.header4,
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerRight,
                          child: ShowGiveAnswerButtons(
                            showAnswerForCurrentDate: false,
                            activityModel: dailyActivityModel.value,
                          ),)
                    ],
                  ),
                ),
              ),

              FormVerticalSpace(),
            ],
          ),
        ),
      ],
    );
  }
}
