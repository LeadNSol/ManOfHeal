import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/models/user_model.dart';
import 'package:man_of_heal/ui/components/black_rounded_container.dart';
import 'package:man_of_heal/ui/components/circular_avatar.dart';
import 'package:man_of_heal/ui/components/custom_container.dart';
import 'package:man_of_heal/ui/components/custom_header_row.dart';
import 'package:man_of_heal/ui/components/form_input_field_with_icon.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';
import 'package:man_of_heal/utils/validator.dart';

class AnswerDetails extends StatelessWidget {
  final QuestionModel? questionModel;

  AnswerDetails(this.questionModel);

  @override
  Widget build(BuildContext context) {
    //Get.put(FeedBackController());

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppThemes.BG_COLOR,
        body: answerBody(context),
        //_answerBody(context),
      ),
    );
  }

  Widget answerBody(context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          height: 225,
          left: 0,
          right: 0,
          child: BlackRoundedContainer(),
        ),
        Positioned(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              FormVerticalSpace(),
              CustomHeaderRow(
                title: "Answer",
                hasProfileIcon: true,
              ),
              FormVerticalSpace(
                height: AppConstant.getScreenHeight(context) * 0.12,
              ),
              CustomContainer(
                hasOuterShadow: true,
                height: AppConstant.getScreenHeight(context) * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AppConstant.textWidget("Question", questionModel!.question,
                        AppThemes.normalBlackFont),

                    ///category
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          border: Border.all(
                              color: AppThemes.DEEP_ORANGE.withOpacity(0.5))),
                      child: Text(
                        '${categoryController.getCategoryById(questionModel!.category)}',
                        style: AppThemes.normalBlackFont
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    AppConstant.textWidget(
                        "Answer",
                        questionModel!.answerMap!.answer,
                        AppThemes.normalBlackFont),
                    /*authController.admin.isTrue
                        ? Container(
                            child: null,
                          )
                        :*/
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Answered By",
                          style: AppThemes.headerItemTitle.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        FormVerticalSpace(
                          height: 10,
                        ),
                        answerBy(questionModel!),
                      ],
                    ),

                    //FormVerticalSpace(height: 10,),
                    ///bottom footer
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Image.asset(
                                  "assets/icons/estimated_time_green_icon.png",
                                  width: 13,
                                ),
                              ),
                              TextSpan(
                                text: "  Answer Time",
                                style: AppThemes.normalBlackFont
                                    .copyWith(color: Colors.black, fontSize: 9),
                              ),
                            ],
                          ),
                        ),
                        FormVerticalSpace(
                          height: 5,
                        ),
                        Text(
                          '${AppConstant.formattedDataTime("hh:mm a, MMM dd yyyy", questionModel!.answerMap!.createdDate!)}',
                          style: AppThemes.header2,
                        ),
                        FormVerticalSpace(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "Answer Status:   ",
                                  style: AppThemes.header2
                                      .copyWith(color: Colors.black)),
                              TextSpan(
                                text: "Answered",
                                style: AppThemes.header2
                                    .copyWith(color: Colors.green),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget answerBy(QuestionModel model) {
    UserModel? userModel =
        authController.getAdminFromListById(model.answerMap!.adminID!.trim());

    feedBackController.fetchCurrentAdminFeedBack(userModel: userModel);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: CircularAvatar(
            padding: 3,
            radius: 13,
            imageUrl: userModel!.photoUrl!,
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${userModel.name}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppThemes.normalBlackFont,
              ),
              Obx(
                () => RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.favorite,
                          size: 13,
                          color: AppThemes.DEEP_ORANGE,
                        ),
                      ),
                      TextSpan(
                          text: " ${feedBackController.netAdminRating.value}",
                          style: AppThemes.normalBlack45Font)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (authController.admin.isFalse)
          Obx(
            () => Visibility(
              visible: feedBackController.haveCurrentUserInList.isFalse,
              child: Expanded(
                flex: 2,
                child: Container(
                  width: 100,
                  child: PrimaryButton(
                    buttonStyle: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      backgroundColor: AppThemes.DEEP_ORANGE,
                      shape: StadiumBorder(),
                    ),
                    labelText: 'Rete Instructor!',
                    textStyle: AppThemes.buttonFont.copyWith(fontSize: 11),
                    onPressed: () {
                      //authController.deleteUserById(userModel);
                      feedBackController.rating(0);
                      showRatingBottomSheet(userModel);
                      //Get.back();
                    },
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  final _formKey = GlobalKey<FormState>();

  void showRatingBottomSheet(UserModel userModel) {
    final iconColor = AppThemes.DEEP_ORANGE;

    Get.bottomSheet(
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Feed back for ${userModel.name!}!",
                  style: AppThemes.dialogTitleHeader,
                ),
              ),
              FormVerticalSpace(),
              Align(
                alignment: Alignment.center,
                child: RatingBar(
                  initialRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  onRatingUpdate: (value) {
                    feedBackController.rating.value = value;
                  },
                  ratingWidget: RatingWidget(
                    full: Image.asset(
                      'assets/icons/heart.png',
                      color: iconColor,
                    ),
                    half: Image.asset(
                      'assets/icons/heart_half.png',
                      color: iconColor,
                    ),
                    empty: Image.asset(
                      'assets/icons/heart_border.png',
                      color: iconColor,
                    ),
                  ),
                ),
              ),
              FormVerticalSpace(height: 5),
              Align(
                alignment: Alignment.center,
                child: Obx(
                  () => Text(
                    "Ratings: ${feedBackController.rating.value}",
                    style: AppThemes.normalBlackFont,
                  ),
                ),
              ),
              FormVerticalSpace(
                height: 25
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      child: FormInputFieldWithIcon(
                        controller: feedBackController.remarksController,
                        iconPrefix: Icons.feedback_outlined,
                        labelText: 'Remarks',
                        maxLines: 3,
                        isExpanded: true,
                        maxLength: 400,
                        autofocus: false,
                        enableBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppThemes.DEEP_ORANGE,
                            width: 2.0,
                          ),
                        ),
                        //textCapitalization: TextCapitalization.words,
                        iconColor: AppThemes.DEEP_ORANGE,
                        textStyle: AppThemes.normalBlackFont,
                        validator: Validator().notEmpty,
                        onChanged: (value) => null,
                        onSaved: (value) => null,
                      ),
                    ),
                    FormVerticalSpace(
                      height: 15,
                    ),
                    Center(
                      child: Container(
                        width: 150,
                        child: PrimaryButton(
                          buttonStyle: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 5.0),
                            backgroundColor: AppThemes.DEEP_ORANGE,
                            shape: StadiumBorder(),
                          ),
                          labelText: 'Submit',
                          textStyle: AppThemes.buttonFont,
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                feedBackController.rating.value > 0) {
                              SystemChannels.textInput.invokeMethod(
                                  'TextInput.hide'); //to hide the keyboard - if any
                              feedBackController.createFeedBack(
                                  questionModel!, userModel);
                              Get.back();
                              //print('added');
                            } else
                              AppConstant.displaySnackBar(
                                  "Alert!", "Rating must not be Zero");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
    );
  }
}
