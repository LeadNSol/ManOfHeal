import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class SingleQAWidget extends GetView<QAController> {
  final TextEditingController? questionController = TextEditingController();
  final TextEditingController? answerController = TextEditingController();

  final QuestionModel? questionModel;
  final int index;

  SingleQAWidget(this.questionModel, this.index);

  final RxBool? is24hrOver = true.obs;
  final RxInt? initialTime = 0.obs;

  @override
  Widget build(BuildContext context) {
    questionController!.text = questionModel!.question!;
    if (questionModel!.answerMap != null) {
      answerController!.text = questionModel!.answerMap!.answer!;
    }

    var remainingTime = _getEstimatedTimeLeft(questionModel!.toBeAnsweredIn!);
    return GestureDetector(
      onTap: () {
        Get.to(() => QuestionDetails(questionModel!, index));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppThemes.DEEP_ORANGE.withOpacity(0.26),
                offset: Offset(0, 0),
                blurRadius: 10.78,
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
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 17),
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
                  style: GoogleFonts.poppins(
                      color: Colors.black45,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
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
                                text: remainingTime.inMinutes < 0
                                    ? "Time over"
                                    : remainingTime.inHours <= 0
                                        ? "0${remainingTime.inHours} : ${remainingTime.inMinutes} hrs"
                                        : "${remainingTime.inHours} hrs",
                                style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700))
                          ],
                          style: GoogleFonts.poppins(
                              fontSize: 9,
                              color: Colors.black,
                              fontWeight: FontWeight.w700)),
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
                  title: "Delete Question",
                  titleStyle: GoogleFonts.poppins(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Are you sure you want to delete this Question ${index + 1}?",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        FormVerticalSpace(),
                        buildDeleteDialogUI(),
                        FormVerticalSpace(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              child: PrimaryButton(
                                labelText: 'Yes',
                                textStyle: GoogleFonts.poppins(
                                    color: AppThemes.white,
                                    fontWeight: FontWeight.w600),
                                onPressed: () {
                                  questionModel!.isDeleted = true;
                                  controller.updateQuestionById(questionModel);

                                  Get.back();
                                },
                              ),
                            ),
                            Container(
                              width: 100,
                              child: PrimaryButton(
                                  labelText: 'No',
                                  textStyle: GoogleFonts.poppins(
                                      color: AppThemes.white,
                                      fontWeight: FontWeight.w600),
                                  onPressed: () => Get.back()),
                            ),
                          ],
                        )
                      ],
                    ),
                  ));
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
            onTap: () {
              controller.questionController.text = questionModel!.question!;
              controller.categoryController!
                  .setSelectedCategory(questionModel!.category!);

              Get.bottomSheet(
                AskQuestionUI(
                  callingFor: "edit",
                  questionModel: questionModel,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                backgroundColor: Colors.white,
              );
            },
            child: Image.asset(
              "assets/icons/edit_icon.png",
              width: 17,
            ),
          ),
        ],
      ),
    );
  }

  _getEstimatedTimeLeft(Timestamp? timestamp) {
    DateTime dateTime = DateTime.parse(timestamp!.toDate().toString());
    //DateTime.fromMillisecondsSinceEpoch(timestamp!.microsecondsSinceEpoch);
    //print('Time ahead from now: ${timeAgo.format(timeAheadFromNow)}');

    //int hours = dateTime.subtract(dateTime.difference(DateTime.now())).hour;
    int hours = dateTime.difference(DateTime.now()).inHours;

    // print('Time ahead from now: ${dateTime.subtract(new DateTime.now()).inSeconds)}');
    print('total seconds: ${dateTime.toLocal()}');
    //print('total seconds: $hours1');
    print('total seconds: $hours');
    return dateTime.difference(DateTime.now());
  }
}
