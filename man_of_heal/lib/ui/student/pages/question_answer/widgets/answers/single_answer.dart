import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class SingleAnswerWidget extends GetView<QAController> {
  final QuestionModel? questionModel;

  SingleAnswerWidget(this.questionModel);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AnswerDetails(questionModel));
      },
      child: CustomContainer(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Question',
                      style: AppThemes.headerItemTitle
                          .copyWith(fontWeight: FontWeight.bold)),
                  _headerWidget(questionModel!),
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
                  style: AppThemes.normalBlack45Font,
                ),
              ),
              FormVerticalSpace(
                height: 5,
              ),
              Text(
                'Answer',
                style: AppThemes.headerItemTitle
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
                width: 245,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                child: Text(
                  '${questionModel!.answerMap!.answer}',
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: AppThemes.normalBlack45Font,
                ),
              ),
              FormVerticalSpace(
                height: 10,
              ),
              _footerWidget(),
            ],
          ),
        ),
      ),
    );
  }

  _headerWidget(QuestionModel questionModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            await controller.updateFavQuestionById(questionModel);
          },
          child: Icon(
            !questionModel.isFav!
                ? Icons.favorite_border_outlined
                : Icons.favorite,
            size: 21,
            color: AppThemes.DEEP_ORANGE,
          ),
        ),
        SizedBox(
          width: 15,
        ),
        InkWell(
          onTap: () =>
              controller.copyToClipBoard(questionModel.answerMap!.answer!),
          child: Image.asset(
            "assets/icons/copy_icon.png",
            width: 15,
          ),
        ),
      ],
    );
  }

  _footerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(
          "assets/icons/tick_mark_icon.png",
          width: 10,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          'Answered',
          style: GoogleFonts.poppins(
              color: Colors.green, fontWeight: FontWeight.w700, fontSize: 8),
        ),
      ],
    );
  }
}
