import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/ui/components/black_rounded_container.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class DailyActivityUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.BG_COLOR,
      body: body(context),
    );
  }

  Widget body(context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    BlackRoundedContainer(
                      bottomLeft: 20,
                      bottomRight: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
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
                                    width: 20,
                                  ),
                                  Text(
                                    'Daily Activity',
                                    style: textTheme.headline6!.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: AppThemes.white),
                                  ),
                                ],
                              ),
                              //profile icon
                              InkWell(
                                onTap: () {
                                  //Get.to(ProfileUI());
                                },
                                child: Container(
                                  height: 60,
                                  //width: 30,
                                  child: Icon(
                                    Icons.calendar_today_rounded,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //FormVerticalSpace(),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight / 1.4,
                color: AppThemes.BG_COLOR,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    //Calendar
                    Positioned(
                      top: -constraints.maxHeight * 0.09,
                      child: Container(
                        width: constraints.maxWidth * 0.85,
                        height: constraints.maxWidth * 0.8,
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: AppThemes.DEEP_ORANGE.withOpacity(0.22),
                                blurRadius: 13,
                                spreadRadius: 2,
                                blurStyle: BlurStyle.normal // Shadow position
                                ),
                          ],
                        ),
                        child: CalendarCarousel<Event>(
                          onDayPressed: (DateTime date, List<Event> events) {
                            print('CalendarDate: $date');
                          },
                          thisMonthDayBorderColor: Colors.transparent,
                          weekFormat: false,
                          //markedDatesMap: _markedDateMap,
                          height: 270.0,
                          width: 250.0,
                          pageScrollPhysics: BouncingScrollPhysics(),
                          selectedDateTime: DateTime.now(),
                          daysHaveCircularBorder: true,
                          weekendTextStyle: TextStyle(color: Colors.black),
                          selectedDayBorderColor: Colors.transparent,
                          selectedDayButtonColor: AppThemes.DEEP_ORANGE,
                          headerTextStyle: textTheme.bodyText1!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          iconColor: Colors.black,
                          weekdayTextStyle: textTheme.bodyText1!
                              .copyWith(color: Colors.black),
                          markedDateShowIcon: true,
                        ),
                      ),
                    ),
                    //Today's Activity
                    Positioned(
                      top: constraints.maxHeight * 0.32,
                      left: 0,
                      child: Column(
                        children: [
                          Container(
                            width: constraints.maxWidth * 0.70,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(
                                left: 26, right: 15, top: 0, bottom: 0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppThemes.DEEP_ORANGE.withOpacity(0.22),
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                    offset: Offset(2, 3),
                                    // Shadow position
                                  ),
                                ]),
                            child: Text(
                              "Today's Activity",
                              style: textTheme.headline6!
                                  .copyWith(color: AppThemes.DEEP_ORANGE),
                            ),
                          ),
                          FormVerticalSpace(),
                          Container(
                            width: constraints.maxWidth * 0.70,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(
                                left: 26, right: 15, top: 0, bottom: 0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppThemes.DEEP_ORANGE.withOpacity(0.22),
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                    offset: Offset(2, 3),
                                    // Shadow position
                                  ),
                                ]),
                            child: customRichText(
                                textTheme, "Term Of The Day", "DVT"),
                          ),
                          FormVerticalSpace(),
                          Container(
                            width: constraints.maxWidth * 0.70,
                            //height: double.infinity,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(
                                left: 26, right: 15, top: 0, bottom: 0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppThemes.DEEP_ORANGE.withOpacity(0.22),
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                    offset: Offset(2, 3),
                                    // Shadow position
                                  ),
                                ]),
                            child: customRichText(
                                textTheme,
                                "Question Of The Day",
                                "lorem ipsum dolor sit amet consectetur adipiscing elit aptent pellentesque tempus lectus eget dictumst in varius nullam feugiat posuere ultricies commodo fusce risus velit turpis ridiculus ultrices dis efficitur ac arcu pretium morbi leo natoque quisque nostra molestie phasellus proin viverra montes nunc nec id neque senectus fringilla fames augue"),
                          ),
                        ],
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

  //Top card item
  Widget customRichText(TextTheme textTheme, title, subtitle) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textTheme.headline6!.copyWith(color: AppThemes.DEEP_ORANGE),
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: Text(
              subtitle,
              style: textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
