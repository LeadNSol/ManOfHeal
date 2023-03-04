import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/quiz_model.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class VDQuizReview extends GetView<AdminVdController> {
  VDQuizReview({Key? key}) : super(key: key);

  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        /// black background
        Positioned(
          top: 0,
          height: 225,
          left: 0,
          right: 0,
          child: BlackRoundedContainer(),
        ),

        Positioned(
          // top: 50,
          // left: 10,
          // right: 10,
          child: Column(
            /*shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 50),
            physics: const AlwaysScrollableScrollPhysics(),*/
            children: [
              FormVerticalSpace(
                height: 40,
              ),
              CustomHeaderRow(
                title: "Quiz Review",
                hasProfileIcon: true,
              ),

              /// Quiz Review
              Container(
                height: 90,
                margin: EdgeInsets.only(
                  left: 17.0,
                  right: 17.0,
                  top: 90,
                ),
                padding: EdgeInsets.all(17.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.86),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppThemes.DEEP_ORANGE.withOpacity(0.22),
                      offset: Offset(0, 0),
                      blurRadius: 10.78,
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Quiz review',
                    style: AppThemes.headerTitleBlackFont
                        .copyWith(color: Colors.black45),
                  ),
                ),
              ),

              /// Quiz List
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    left: 0,
                    top: 5,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                  child: Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      //primary: false,
                      physics: const AlwaysScrollableScrollPhysics(),
                      //padding: EdgeInsets.zero,
                      itemCount: controller.quizList.length,
                      itemBuilder: (context, index) {
                        QuizModel quizModel = controller.quizList[index];

                        return SingleQuizItem(quizModel: quizModel,);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class SingleQuizItem extends StatelessWidget {
  const SingleQuizItem({Key? key, this.quizModel}) : super(key: key);
  final QuizModel? quizModel;



  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      margin: const EdgeInsets.only(left: 17, right: 17, top: 0, bottom: 10),
      child: ListTile(
          onTap: () {
            Get.put(quizModel!);
            Get.to(() => QuizQuestionsUI(quizModel: quizModel!));
          },
          title: Text(
            '${quizModel!.quizTitle!}',
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: AppThemes.headerItemTitle
                .copyWith(color: AppThemes.DEEP_ORANGE),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormVerticalSpace(
                height: 5,
              ),
              Text(
                '${quizModel!.quizDescription!.isEmpty ? AppConstant.loremIpsum : quizModel!.quizDescription!}',
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: AppThemes.normalBlack45Font,
              ),
              FormVerticalSpace(
                height: 10,
              ),
              /* Obx(
                () => Text('Total Questions: ${totalQuestions.value}',
                    textAlign: TextAlign.start,
                    style: AppThemes.normalBlack45Font),
              ),
              FormVerticalSpace(
                height: 10,
              )*/
            ],
          ),
          trailing: Column(
            children: [
              Text(
                quizModel!.isActive! ? "active" : "",
                style: AppThemes.captionFont
                    .copyWith(color: AppThemes.rightAnswerColor),
              ),
              Text(
                '${AppConstant.formattedDataTime("dd/MM/yyyy", quizModel!.createdDate!)}',
                textAlign: TextAlign.end,
                style: AppThemes.normalBlack45Font,
              ),
            ],
          ),),
    );
  }
}
