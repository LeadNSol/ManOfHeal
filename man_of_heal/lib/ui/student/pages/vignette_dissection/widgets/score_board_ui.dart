import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/ui/components/custom_container.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/student/pages/vignette_dissection/widgets/leader_board_ui.dart';
import 'package:man_of_heal/ui/student/std_home.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class ScoreBoardUI extends StatelessWidget {
  //const ScoreBoardUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

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
      body: SafeArea(child: body(context, textTheme)),
    );
  }

  Widget body(context, TextTheme textTheme) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppThemes.blackPearl,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                ),
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
                              style: textTheme.bodyText1!
                                  .copyWith(color: AppThemes.DEEP_ORANGE),
                            ),
                            Text.rich(
                              TextSpan(
                                text: "80",
                                style: textTheme.headline3!
                                    .copyWith(color: AppThemes.DEEP_ORANGE),
                                children: [
                                  TextSpan(
                                    text: "\t\t\t pt",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.black54),
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
                //Expanded(child: Center())
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
                    height: constraints.maxWidth * 0.38,
                    alignment: Alignment.center,
                    hasOuterShadow: false,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              cardWidget(
                                textTheme,
                                AppThemes.DEEP_ORANGE,
                                "100%",
                                "Completion",
                              ),
                              cardWidget(textTheme, AppThemes.blackPearl, "10",
                                  "Total Questions"),
                            ],
                          ),
                          //FormVerticalSpace(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              cardWidget(
                                textTheme,
                                AppThemes.rightAnswerColor,
                                "08",
                                "Correct",
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              cardWidget(textTheme, AppThemes.DEEP_ORANGE, "02",
                                  "Wrong")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      bottomActionIcon(
                        textTheme,
                        () => Get.offAll(StudentHome()),
                        "score_home_icon.svg",
                        "Home",
                      ),
                      bottomActionIcon(
                        textTheme,
                        () {},
                        "score_review_icon.svg",
                        "Review",
                      ),
                      bottomActionIcon(
                        textTheme,
                        () => Get.off(LeaderBoardUI()),
                        "score_leader_board_icon.svg",
                        "Leader Board",
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

  Widget bottomActionIcon(TextTheme textTheme, onTap, icon, title) {
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
            style: textTheme.bodyText2,
          )
        ],
      ),
    );
  }

  Widget cardWidget(TextTheme textTheme, colorDot, title, subTitle) {
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
            style: textTheme.headline6!
                .copyWith(color: AppThemes.DEEP_ORANGE, fontSize: 14),
          ),
          TextSpan(
            text: '      $subTitle',
            style: textTheme.bodyText1!.copyWith(
              color: Colors.black54,
              fontSize: 13,
            ),
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
