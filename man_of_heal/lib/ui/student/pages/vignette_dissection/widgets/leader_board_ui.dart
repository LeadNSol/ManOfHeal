import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/components/base_widget.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';


class LeaderBoardUI extends GetView<VDController> {
  @override
  Widget build(BuildContext context) {
    //otherList.sort((a, b) => a['score'],);

    return BaseWidget(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppThemes.blackPearl,
      statusBarColor: AppThemes.blackPearl,
      statusBarIconBrightness: Brightness.light,
      child: Obx(() => newLbBody(context)),
    );
  }

  Widget newLbBody(context) {
    var top3List = <ScoreModel>[].obs;
    var otherList = <ScoreModel>[].obs;
    top3List.clear();
    otherList.clear();
    otherList.addAll(controller.leaderboardList);

    if (otherList.length > 1) {
      int length = otherList.length == 2 ? 2 : 3;
      for (int i = 0; i < length; i++) {
        ScoreModel sm = otherList.reduce((previousValue, element) =>
            previousValue.score! > element.score! ? previousValue : element);
        // print('Max Value: ${sm.score!}');
        if (top3List.isEmpty)
          top3List.add(sm);
        else if (top3List.length <= 1) {
          top3List.insert(0, sm);
        } else
          top3List.add(sm);
        otherList.remove(sm);
      }
    }

    /* if (otherList.length == 1) {
      top3List.insert(0,otherList[0]);
      otherList.clear();
    } else {
      int length = otherList.length == 2 ? 2 : 3;
      for (int i = 0; i < length; i++) {
        ScoreModel sm = otherList.reduce((previousValue, element) =>
            previousValue.score! > element.score! ? previousValue : element);
        // print('Max Value: ${sm.score!}');
        if (top3List.isEmpty)
          top3List.add(sm);
        else if (top3List.length <= 1) {
          top3List.insert(0, sm);
        } else
          top3List.add(sm);
        otherList.remove(sm);
      }
    }*/

    return Stack(
      fit: StackFit.expand,
      children: [
        /// pink background
        Positioned(
          top: AppConstant.getScreenHeight(context) * (kIsWeb ? 0.5 : 0.4),
          left: 0,
          child: Container(
            width: AppConstant.getScreenWidth(context),
            height: AppConstant.getScreenHeight(context),
            decoration: BoxDecoration(
              color: AppThemes.BG_COLOR,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
            ),
          ),
        ),

        Positioned(
            child: Column(
          children: [
            FormVerticalSpace(),
            CustomHeaderRow(
              title: "Leader Board",
              hasProfileIcon: true,
            ),
            FormVerticalSpace(),

            /// Top three in list
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(20.0),
                child: top3List.isEmpty
                    ? Container(
                        height: AppConstant.getScreenHeight(context) *
                            (kIsWeb ? 0.5 : 0.2),
                      )
                    : SingleChildScrollView(
                        //scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: top3List.map((ScoreModel model) {
                            int index = top3List.indexOf(model);
                            return Expanded(child: topThree(index, model));
                          }).toList(),
                        ),
                      ),
              ),
            ),

            /// Other list
            FormVerticalSpace(
              height: 30,
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: otherList.length,
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    ScoreModel model = otherList[index];
                    return otherListItems(model);
                  },
                ),
              ),
            ),
          ],
        ))
      ],
    );
  }

  Widget topThree(int index, ScoreModel scoreModel) {
    int id = 0;
    double fontSize = 12;
    double height = 35;
    double width = 43;
    double fontSizeSub = 9;
    if (index == 1) {
      id = 1;
      fontSize = 16;
      height = 51;
      width = 61;
      fontSizeSub = 12;
    } else if (index == 0)
      id = 2;
    else
      id = 3;

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        //height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.,
          children: [
            FormVerticalSpace(),
            Text(
              '0$id',
              style: AppThemes.normalBlackFont
                  .copyWith(color: AppThemes.DEEP_ORANGE, fontSize: 14.23),
            ),
            FormVerticalSpace(
              height: 5,
            ),
            SvgPicture.asset(
              "assets/icons/winner_icon.svg",
              height: height,
              width: width,
            ),
            FormVerticalSpace(
              height: 5,
            ),
            Text(
              controller.getUserName(scoreModel.userId!.trim()),
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppThemes.header3
                  .copyWith(fontSize: fontSize, color: Colors.white),
            ),

            //FormVerticalSpace(height: 10,),
            Text(
              '${scoreModel.score!}',
              style: AppThemes.normalBlackFont
                  .copyWith(color: Colors.white, fontSize: fontSizeSub),
            ),
          ],
        ),
      ),
    );
  }

  Widget otherListItems(ScoreModel model) {
    // getPhotoUrl(model.userId!);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:
              NetworkImage(controller.getPhotoUrl(model.userId!.trim())),
        ),
        title: Text(
          //model.userId !=null ? model.userId! : "",
          controller.getUserName(model.userId!.trim()),
          style: AppThemes.normalBlackFont,
        ),

        //getUserNameById(model, AppThemes.normalBlackFont),

        trailing: Container(
          height: 20,
          width: 45,
          //padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: AppThemes.DEEP_ORANGE),
          child: Center(
            child: Text(
              '${model.score!} pt',
              textAlign: TextAlign.center,
              style: AppThemes.normalBlackFont
                  .copyWith(color: Colors.white, fontSize: 10),
            ),
          ),
        ),
      ),
    );
  }
}
