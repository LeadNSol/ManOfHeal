import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/ui/components/black_rounded_container.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/profile/profile_ui.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class QuestionDetails extends StatelessWidget {
  final QuestionModel? questionModel;
  final int index;

  QuestionDetails(this.questionModel, this.index);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppThemes.BG_COLOR,
        body: _statusBody(context),
      ),
    );
  }

  _statusBody(context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  //Background rounded bottom left, right black color

                  BlackRoundedContainer(
                    bottomLeft: 20,
                    bottomRight: 20,
                  ),

                  //Title and back button
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
                                  'Status',
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
                        //FormVerticalSpace(),
                        Expanded(child: Center()),
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
                  //Question body card

                  Positioned(
                    top: constraints.maxHeight * 0.09,
                    left: 0,
                    child: Container(
                      width: constraints.maxWidth * 0.89,
                      //height: constraints.maxHeight * 0.45,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppThemes.DEEP_ORANGE.withOpacity(0.22),
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: Offset(2, 3),
                              // Shadow position
                            ),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Question ${index + 1}',
                            style: textTheme.headline5!.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          FormVerticalSpace(
                            height: 10,
                          ),
                          Text(
                            '${questionModel!.question}',
                            style: textTheme.bodyText2!.copyWith(fontSize: 16),
                          ),
                          FormVerticalSpace(
                            height: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    color: AppThemes.DEEP_ORANGE
                                        .withOpacity(0.5))),
                            child: Text(
                              '${questionModel!.category}',
                              style: textTheme.caption,
                            ),
                          ),
                          questionModel!.answerMap != null
                              ? _answerWidget(textTheme)
                              : Container(),
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
                                  style: textTheme.bodyText2!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${_convertToFormattedDataTime(questionModel!.qCreatedDate!)}',
                            style: textTheme.bodyText1,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Answer Status:   ",
                                    style: textTheme.bodyText1),
                                TextSpan(
                                  text: " Pending",
                                  style: textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color:
                                        AppThemes.DEEP_ORANGE.withOpacity(0.5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Count down timer card
                  Positioned(
                    top: -constraints.maxHeight * 0.07,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.89,
                          height: constraints.maxWidth * 0.30,
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      AppThemes.DEEP_ORANGE.withOpacity(0.22),
                                  blurRadius: 13,
                                  spreadRadius: 2,
                                  blurStyle: BlurStyle.outer // Shadow position
                                  ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "71:51:00",
                                style: textTheme.headline2!.copyWith(
                                    color:
                                        AppThemes.DEEP_ORANGE.withOpacity(0.7)),
                              ),
                            ),
                          ),
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
    });
  }

  _answerWidget(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormVerticalSpace(
          height: 15,
        ),
        Text(
          'Answer',
          style: textTheme.headline5!
              .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        FormVerticalSpace(
          height: 10,
        ),
        Text(
          '${questionModel!.answerMap!.answer}',
          style: textTheme.bodyText2!.copyWith(fontSize: 16),
        ),
      ],
    );
  }

  _convertToFormattedDataTime(Timestamp timestamp) {
    var date =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);

    return DateFormat("hh:mm a, MMM dd yyyy").format(date);
  }
}
