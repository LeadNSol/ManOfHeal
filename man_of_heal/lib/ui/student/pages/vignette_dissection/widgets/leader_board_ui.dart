import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/profile/profile_ui.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class LeaderBoardUI extends StatelessWidget {
  //const LeaderBoardUI({Key? key}) : super(key: key);

  final List topThreeList = [
    {
      "ttId": 2,
      "icon": "assets/icons/winner_icon.svg",
      "name": "George",
      "score": 15908
    },
    {
      "ttId": 1,
      "icon": "assets/icons/winner_icon.svg",
      "name": "Emma",
      "score": 16847
    },

    {
      "ttId": 3,
      "icon": "assets/icons/winner_icon.svg",
      "name": "Paul",
      "score": 14367
    }
  ];

  final List otherList = [
    {
      "oid": 1,
      "icon":
          "https://www.shareicon.net/data/128x128/2016/05/24/770136_man_512x512.png",
      "name": "Micheal",
      "score": 537
    },
    {
      "oid": 2,
      "icon": "https://cdn-icons-png.flaticon.com/128/3011/3011270.png",
      "name": "Olivia",
      "score": 123
    },
    {
      "oid": 3,
      "icon": "https://cdn-icons-png.flaticon.com/128/3011/3011270.png",
      "name": "Isabella",
      "score": 342
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: lbBody(context),
      ),
    );
  }

  Widget lbBody(context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppThemes.blackPearl,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Header profile icon and Dashboard Text...
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: InkWell(
                                      onTap: () => Get.back(),
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        size: 20,
                                        color: AppThemes.white,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: '\t\t Leader Board',
                                    style: textTheme.headline6!.copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: AppThemes.white),
                                  ),
                                ],
                              ),
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

                        /*Expanded(
                          child: ListView.builder(
                            itemCount: getTopThreeList().length,
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              LeaderBoardModel model = getTopThreeList()[index];
                              return otherListItems(textTheme, model);
                            },
                          ),
                        ),*/
                        FormVerticalSpace(),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: topThreeList
                                .map((data) => topThree(textTheme, data))
                                .toList(),
                          ),
                        ),
                        Expanded(child: Center())
                        /* Expanded(
                          child: Center(
                            child: ListView.builder(
                              itemCount: getTopThreeList().length,
                              scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                LeaderBoardModel model =
                                    getTopThreeList()[index];
                                return otherListItems(textTheme, model);
                              },
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.4,
                    left: 0,
                    child: Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        decoration: BoxDecoration(
                          color: AppThemes.BG_COLOR,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: getOtherListData().length,
                          padding: EdgeInsets.all(10),
                          itemBuilder: (context, index) {
                            LeaderBoardModel model = getOtherListData()[index];
                            return otherListItems(textTheme, model);
                          },
                        )

                        /*ListView(
                        //shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(5),
                        children: otherList
                            .map((lb) => otherListItems(textTheme, lb))
                            .toList(),
                      ),*/
                        ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget topThree(TextTheme textTheme, data) {
    int id = data['ttId'];
    double fontSize = 12;
    double height = 35;
    double width = 42;
    double fontSizeSub = 10;
    if (id == 1) {
      fontSize = 16;
      height = 50.14;
      width = 60.8;
      fontSizeSub = 12;
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.,
          children: [
            Text(
              '0${data['ttId']}',
              style: textTheme.caption!.copyWith(color: AppThemes.DEEP_ORANGE, fontSize: 14),
            ),
            //FormVerticalSpace(height: 10,),
            SvgPicture.asset(
              data['icon'],
              height: height,
              width: width,
            ),
            //FormVerticalSpace(height: 10,),
            Text(
              data['name'],
              style: textTheme.headline6!
                  .copyWith(fontSize: fontSize, color: Colors.white),
            ),
            //FormVerticalSpace(height: 10,),
            Text(
              '${data['score']}',
              style: textTheme.caption!
                  .copyWith(color: Colors.white, fontSize: fontSizeSub),
            ),
          ],
        ),
      ),
    );
  }

  Widget otherListItems(TextTheme textTheme, LeaderBoardModel model) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        leading: Image.network(
          model.icon!,
          width: 45,
        ),
        title: Text(
          model.name!,
          style: textTheme.headline6!.copyWith(fontSize: 14),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: AppThemes.DEEP_ORANGE),
          child: Text(
            '${model.score!} pt',
            style: textTheme.caption!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  List<LeaderBoardModel> getOtherListData() {
    return otherList
        .map((data) => LeaderBoardModel(
            id: data['oid'],
            name: data['name'],
            score: data['score'],
            icon: data['icon']))
        .toList();
  }

  List<LeaderBoardModel> getTopThreeList() {
    return topThreeList
        .map((data) => LeaderBoardModel(
            id: data['id'],
            name: data['name'],
            score: data['score'],
            icon: data['icon']))
        .toList();
  }
}

class LeaderBoardModel {
  int? id;
  int? score;
  String? name;
  String? icon;

  LeaderBoardModel({this.id, this.score, this.name, this.icon});
}
