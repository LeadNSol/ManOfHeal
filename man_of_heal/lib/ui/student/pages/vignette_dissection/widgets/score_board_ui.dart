import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/ui/components/black_rounded_container.dart';
import 'package:man_of_heal/ui/components/custom_container.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/student/pages/vignette_dissection/widgets/leader_board_ui.dart';
import 'package:man_of_heal/ui/student/pages/vignette_dissection/widgets/review_ui.dart';
import 'package:man_of_heal/ui/student/std_home.dart';
import 'package:man_of_heal/utils/app_themes.dart';
class ScoreBoardUI extends StatelessWidget {
  //const ScoreBoardUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppThemes.BG_COLOR,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppThemes.blackPearl,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: AppThemes.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: null,
              child: Icon(
                Icons.info_rounded,
                color: AppThemes.white,
                size: 25,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(child: body(context)),
    );
  }

  Widget body(context) {
    var noOfQuestions = vdController.quizQuestionsList.length;
    var wrong =
        noOfQuestions - vdController.numOfCorrectAns;
    var yourScore = vdController.numOfCorrectAns * 10;

    var completion = ((wrong + vdController.numOfCorrectAns) * 100)/noOfQuestions;

    print('Completion: $completion');
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                BlackRoundedContainer(),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white54,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Your Score',
                              style: AppThemes.header2
                                  .copyWith(color: AppThemes.DEEP_ORANGE),
                            ),
                            Text.rich(
                              TextSpan(
                                text: "$yourScore",
                                style: AppThemes.headerTitleBlackFont
                                    .copyWith(fontSize: 50.69),
                                children: [
                                  TextSpan(
                                    text: "    pt",
                                    style: AppThemes.normalBlack45Font,
                                  ),
                                ],
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
          Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight / 1.9,
            color: AppThemes.BG_COLOR,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                //Top Question Card
                Positioned(
                  top: -constraints.maxHeight * 0.1,
                  child: CustomContainer(
                    width: constraints.maxWidth * 0.9,
                    height: 150,
                    alignment: Alignment.center,
                    hasOuterShadow: false,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.st,
                        children: [
                          Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: cardWidget(
                                  AppThemes.DEEP_ORANGE,
                                  "${completion.toInt()}%",
                                  "Completion",
                                ),
                              ),
                              SizedBox(width: 30,),
                              Expanded(
                                flex: 2,
                                child: cardWidget(
                                    AppThemes.blackPearl,
                                    vdController.quizQuestionsList.length < 10
                                        ? "0${vdController.quizQuestionsList.length}"
                                        : vdController.quizQuestionsList.length,
                                    "Total Questions"),
                              ),
                            ],
                          ),
                          //FormVerticalSpace(height: 10,),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: cardWidget(
                                    AppThemes.rightAnswerColor,
                                    vdController.numOfCorrectAns < 10
                                        ? "0${vdController.numOfCorrectAns}"
                                        : vdController.numOfCorrectAns,
                                    "Correct"),
                              ),
                              SizedBox(width: 30,),
                              Expanded(
                                flex: 2,
                                child: cardWidget(AppThemes.DEEP_ORANGE,
                                    wrong < 10 ? '0$wrong' : wrong, "Wrong"),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                 // margin: const EdgeInsets.only(left: 17,right: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //SizedBox(width: 50,),
                      Expanded(
                        child: bottomActionIcon(
                          () => Get.offAll(StudentHome()),
                          "score_home_icon.svg",
                          "Home",
                        ),
                      ),
                     // SizedBox(width: 55,),
                      Expanded(
                        child: bottomActionIcon(
                          () => Get.to(ReviewUI()),
                          "score_review_icon.svg",
                          "Review",
                        ),
                      ),
                      //SizedBox(width: 50,),
                      Expanded(
                        child: bottomActionIcon(
                          () => Get.to(()=>LeaderBoardUI()),
                          "score_leader_board_icon.svg",
                          "Leader Board",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget bottomActionIcon(onTap, icon, title) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/$icon"),
          FormVerticalSpace(
            height: 10,
          ),
          Text(
            '$title',
            style: AppThemes.normalBlackFont,
          )
        ],
      ),
    );
  }

  Widget cardWidget(colorDot, title, subTitle) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Icon(
              Icons.circle,
              size: 12,
              color: colorDot,
            ),
          ),
          TextSpan(
            text: '  $title\n',
            style: AppThemes.normalORANGEFont.copyWith(fontSize: 13.5),
          ),
          TextSpan(
            text: '      $subTitle',
            style: AppThemes.normalBlack45Font,
          ),
        ],
      ),
    );
    /*return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(left: 10.0, right: 6.0),
      leading: Icon(
        Icons.circle,
        size: 12,
        color: colorDot,
      ),
      title: Text(
        '$title',
        style: textTheme.headline6!
            .copyWith(color: AppThemes.DEEP_ORANGE, fontSize: 14),
      ),
      subtitle: Text(
        '$subTitle',
        style:
            textTheme.bodyText1!.copyWith(color: Colors.black54, fontSize: 13),
      ),
    );*/
  }
}
