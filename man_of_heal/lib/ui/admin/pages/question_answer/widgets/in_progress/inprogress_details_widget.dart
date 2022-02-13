import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/ui/admin/pages/question_answer/widgets/header_widget.dart';
import 'package:man_of_heal/ui/components/custom_container.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/ui/profile/profile_ui.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class InProgressQuestionDetails extends StatelessWidget {
  final QuestionModel questionModel;

  InProgressQuestionDetails(this.questionModel);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppThemes.BG_COLOR,
        body: _body(context),
      ),
    );
  }

  Widget _body(context) {
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
                      child: CustomContainer(
                        width: constraints.maxWidth * 0.89,
                        hasOuterShadow: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HeaderWidget(questionModel),
                            FormVerticalSpace(
                              height: 10,
                            ),
                            Text(
                              '${questionModel.question}',
                              style:
                                  textTheme.bodyText2!.copyWith(fontSize: 16),
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
                                '${questionModel.category}',
                                style: textTheme.caption,
                              ),
                            ),
                            FormVerticalSpace(),
                            //answer button
                            _answerButton(textTheme),
                            FormVerticalSpace(),
                            _footerWidget(textTheme),
                          ],
                        ),
                      ),
                    ),

                    // Count down timer card
                    Positioned(
                      top: -constraints.maxHeight * 0.07,
                      child: Center(
                        child: CustomContainer(
                          width: constraints.maxWidth * 0.89,
                          height: constraints.maxWidth * 0.30,
                          alignment: Alignment.topLeft,
                          hasOuterShadow: true,
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

  _footerWidget(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
                style: textTheme.bodyText2!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ],
          ),
        ),
        FormVerticalSpace(height: 10,),
        Text(
          '${AppConstant.convertToFormattedDataTime("hh:mm a, MMM dd yyyy", questionModel.qCreatedDate!)}',
          style: textTheme.bodyText1,
        ),
        FormVerticalSpace(height: 10,),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: "Answer Status:   ", style: textTheme.bodyText1),
              TextSpan(
                text: " Pending",
                style: textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppThemes.DEEP_ORANGE.withOpacity(0.5),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _answerButton(TextTheme textTheme) => Center(
        child: Container(
          width: 200,
          child: PrimaryButton(
            buttonStyle: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              primary: AppThemes.DEEP_ORANGE,
              shape: StadiumBorder(),
            ),
            labelText: 'Answer',
            textStyle:
                textTheme.headline5!.copyWith(color: AppThemes.white),
            onPressed: () {},
          ),
        ),
      );
}
