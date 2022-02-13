import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class AdminSingleQAWidget extends StatelessWidget {
  final TextEditingController? questionController = TextEditingController();

  final QuestionModel? questionModel;

  AdminSingleQAWidget(this.questionModel);

  @override
  Widget build(BuildContext context) {
    questionController!.text = questionModel!.question!;
    if (questionModel!.answerMap != null) {
      qaController.answerController!.text = questionModel!.answerMap!.answer!;
    }
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${_convertAgoDate(questionModel!.qCreatedDate)}",
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Answer time: ${_convertFromNowDate(questionModel!.toBeAnsweredIn)}",
                  ),
                ),
              ],
            ),
            FormVerticalSpace(
              height: 12.0,
            ),

            //Question field
            TextField(
              controller: questionController,
              minLines: 1,
              maxLines: 5,
              readOnly: true,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(labelText: "Question"),
            ),
            FormVerticalSpace(
              height: 5.0,
            ),

            //Answer
            questionModel!.answerMap != null
                ? Column(
                    children: [
                      // Edit icon for answer
                      Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            qaController.dialogAnswerController!.text =
                                questionModel!.answerMap!.answer!;

                            _customGetXDialog(
                                "Update Answer", "update", Colors.greenAccent,
                                () {
                              qaController
                                  .updateAnswerOfTheQuestionById(questionModel);
                              Get.back();
                            }, questionModel);
                          },
                          icon: Icon(Icons.edit),
                          iconSize: 20,
                        ),
                      ),
                      TextField(
                          controller: qaController.answerController,
                          minLines: 1,
                          maxLines: 5,
                          readOnly: true,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(labelText: "Answer"))
                    ],
                  )
                : Container(),
            FormVerticalSpace(
              height: 12.0,
            ),
            Row(
              children: [
                Container(
                  height: 30,
                  alignment: Alignment.center,
                  child: TextButton.icon(
                    icon: Icon(
                      Icons.delete_rounded,
                      color: Colors.redAccent,
                    ),
                    label: Text(
                      'Delete',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    onPressed: () {
                      questionModel!.isDeleted = true;
                      qaController.deleteQuestionById(questionModel);
                    },
                  ),
                ),
                Container(
                  height: 30,
                  alignment: Alignment.center,
                  child: questionModel!.answerMap != null
                      ? Text('Already Answered')
                      : TextButton.icon(
                          icon: Icon(
                            Icons.insert_comment_rounded,
                            color: Colors.greenAccent,
                          ),
                          label: Text(
                            'Answer',
                            style: TextStyle(color: Colors.greenAccent),
                          ),
                          onPressed: () {
                            _customGetXDialog(
                                "Write an Answer", "submit", Colors.greenAccent,
                                () {
                              qaController.answerTheQuestionById(questionModel);
                              Get.back();
                            }, questionModel);
                          },
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _customGetXDialog(
      _title, _confirmBtnText, _confirmColor, onConfirmBtn, questionModel) {
    Get.defaultDialog(
        title: _title,
        textConfirm: _confirmBtnText,
        confirmTextColor: _confirmColor,
        textCancel: "Cancel",
        cancelTextColor: Colors.redAccent,
        barrierDismissible: false,
        buttonColor: Colors.white,
        radius: 10,
        onConfirm: onConfirmBtn,
        content: Column(
          children: [
            Container(
              child: Text('Q: ${questionModel!.question}'),
            ),
            FormVerticalSpace(
              height: 10,
            ),
            TextFormField(
                controller: qaController.dialogAnswerController,
                maxLines: 5,
                maxLength: 150,
                textAlign: TextAlign.start,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: InputDecoration(labelText: "Answer")),
          ],
        ));
  }

  String _convertAgoDate(Timestamp? timestamp) {
    DateTime dateTime =
        DateTime.fromMicrosecondsSinceEpoch(timestamp!.microsecondsSinceEpoch);
    final timeAgoFromNow =
        new DateTime.now().subtract(new DateTime.now().difference(dateTime));
    return timeAgo.format(timeAgoFromNow);
  }

  String _convertFromNowDate(Timestamp? timestamp) {
    DateTime dateTime =
        DateTime.fromMicrosecondsSinceEpoch(timestamp!.microsecondsSinceEpoch);
    final timeAheadFromNow =
        new DateTime.now().add(dateTime.difference(new DateTime.now()));

    return timeAgo.format(timeAheadFromNow,
        locale: 'en_short', allowFromNow: true);
  }
}
