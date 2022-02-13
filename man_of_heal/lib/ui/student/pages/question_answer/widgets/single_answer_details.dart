import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/profile/profile_ui.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class AnswerDetails extends StatelessWidget {
  final QuestionModel? questionModel;

  AnswerDetails(this.questionModel);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppThemes.BG_COLOR,
        body: _answerBody(context),
      ),
    );
  }

  _answerBody(context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var fontSize = 14.28;
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
                    //Background rounded bottom left, right black color

                    Container(
                      decoration: BoxDecoration(
                        color: AppThemes.blackPearl,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),

                    //Title and back button plus profile icon
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
                                    'Answer',
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
                    // whole data card
                    Positioned(
                      top: -constraints.maxHeight * 0.07,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: constraints.maxWidth * 0.89,
                            height: constraints.maxHeight * 0.60,
                            //alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppThemes.DEEP_ORANGE.withOpacity(0.26),
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                  offset: Offset(2, 3),
                                  //blurStyle: BlurStyle.outer // Shadow position
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Question',
                                    style: textTheme.headline5!.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '${questionModel!.question}',
                                    style: textTheme.bodyText2!
                                        .copyWith(fontSize: 16),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: AppThemes.DEEP_ORANGE
                                                .withOpacity(0.5))),
                                    child: Text(
                                      '${questionModel!.category}',
                                      style: textTheme.caption,
                                    ),
                                  ),
                                  _answerWidget(textTheme),
                                  FormVerticalSpace(),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Image.asset(
                                            "assets/icons/estimated_time_green_icon.png",
                                            width: 13,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "  Answer Time",
                                          style: textTheme.subtitle1!.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${AppConstant.convertToFormattedDataTime("hh:mm a, MMM dd yyyy", questionModel!.answerMap!.createdDate!)}',
                                    style: textTheme.bodyText1!.copyWith(
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "Answer Status:   ",
                                            style: textTheme.bodyText1!
                                                .copyWith(fontSize: fontSize)),
                                        TextSpan(
                                          text: " Answered",
                                          style: textTheme.bodyText2!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: fontSize,
                                            color: Colors.green,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
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
      },
    );
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
}
