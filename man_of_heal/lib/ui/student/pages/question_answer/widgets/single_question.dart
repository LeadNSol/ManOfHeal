import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/utils/app_themes.dart';
import 'package:timeago/timeago.dart' as timeAgo;

import 'single_question_details.dart';

class SingleQAWidget extends StatelessWidget {
  final TextEditingController? questionController = TextEditingController();
  final TextEditingController? answerController = TextEditingController();

  final QuestionModel? questionModel;
  final int index;

  SingleQAWidget(this.questionModel, this.index);

  final RxBool? is24hrOver = true.obs;
  final RxInt? initialTime = 0.obs;

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    questionController!.text = questionModel!.question!;
    if (questionModel!.answerMap != null) {
      answerController!.text = questionModel!.answerMap!.answer!;
    }

    return GestureDetector(
      onTap: () {
        Get.to(QuestionDetails(questionModel!, index));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppThemes.DEEP_ORANGE.withOpacity(0.26),
                blurRadius: 4,
                spreadRadius: 2,
                offset: Offset(2, 3),
                // Shadow position
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${index + 1}',
                    style: _textTheme.headline6!.copyWith(fontSize: 17),
                  ),
                  _headerWidget(),
                ],
              ),

              Container(
                width: 245,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                child: Text(
                  '${questionModel!.question}',
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: _textTheme.bodyText1!
                      .copyWith(color: Colors.black45, fontSize: 15),
                ),
              ),

              //footer or bottom
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/icons/estimated_time_icon.png",
                      width: 13,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Estimated Time\n",
                          children: [
                            TextSpan(
                                text: "72 hrs",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800))
                          ],
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontSize: 10, fontWeight: FontWeight.w800)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _headerWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //IconButton(onPressed: () {}, icon: Icon(Icons.edit_rounded)),
          InkWell(
            onTap: () {

              Get.defaultDialog(
                title: "Attention Plz!",
                cancel: InkWell(
                  onTap: () => Get.back(),
                ),
                textConfirm: "Delete",
                onConfirm: (){
                  questionModel!.isDeleted = true;
                  qaController.deleteQuestionById(questionModel);
                }
              );
            },
            child: Image.asset(
              "assets/icons/delete_icon.png",
              width: 15,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {},
            child: Image.asset(
              "assets/icons/edit_icon.png",
              width: 17,
            ),
          ),

          /*IconButton(
              onPressed: () {
                questionModel!.isDeleted = true;
                qaController.deleteQuestionById(questionModel);
              },
              icon: Icon(Icons.delete_rounded))*/
        ],
      ),
    );
  }

  _answerWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        /*ListTile(
          leading: CircleAvatar(
              foregroundColor: Colors.deepPurple,
              backgroundColor: Colors.transparent,
              radius: 10,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/default.png',
                  fit: BoxFit.cover,
                  width: 60.0,
                  height: 60.0,
                ),
              ),),

          title: Text('${authController.userModel.value!.name}',style: TextStyle(fontSize: 13),),
          subtitle: Text('${_convertAgoDate(questionModel!.answerMap!.createdDate)}'),

        ),*/
        FormVerticalSpace(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              foregroundColor: Colors.deepPurple,
              backgroundColor: Colors.transparent,
              radius: 15,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/default.png',
                  fit: BoxFit.cover,
                  width: 60.0,
                  height: 60.0,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${authController.userModel.value!.name}',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                FormVerticalSpace(
                  height: 3,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                      '${_convertAgoDate(questionModel!.answerMap!.createdDate)}',
                      style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ],
        ),
        FormVerticalSpace(
          height: 10,
        ),
        TextField(
          controller: answerController,
          minLines: 1,
          maxLines: 5,
          readOnly: true,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(labelText: "Answer"),
        )
      ],
    );
  }

  String _convertAgoDate(Timestamp? timestamp) {
    /*final timeAgoFromNow =
        new DateTime.now().subtract(new Duration());*/

    DateTime dateTime =
        DateTime.fromMicrosecondsSinceEpoch(timestamp!.microsecondsSinceEpoch);
    final timeAgoFromNow =
        new DateTime.now().subtract(new DateTime.now().difference(dateTime));

    initialTime!.value =
        new DateTime.now().difference(timeAgoFromNow).inSeconds;
    print(
        'Time ago: $timeAgoFromNow new: ${new DateTime.now().difference(timeAgoFromNow).inSeconds}');
    return timeAgo.format(timeAgoFromNow);
  }

  int _convertFromNowDate(Timestamp? timestamp) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp!.microsecondsSinceEpoch);
    //print('Time ahead from now: ${timeAgo.format(timeAheadFromNow)}');
    int seconds = dateTime.difference(new DateTime.now()).inSeconds;

    // print('Time ahead from now: ${dateTime.subtract(new DateTime.now()).inSeconds)}');
    print('total seconds: ${dateTime.toLocal()}');
    print('total seconds: ${timestamp.seconds}');
    print('total seconds: $seconds');
    return seconds;
  }

  int secondsBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours * 3600).round();
  }
}
