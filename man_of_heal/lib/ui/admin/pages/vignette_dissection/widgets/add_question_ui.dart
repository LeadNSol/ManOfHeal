import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/quiz_model.dart';
import 'package:man_of_heal/ui/components/base_widget.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class AddQuestionUI extends GetView<AdminVdController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

  final QuizModel quizModel;
  AddQuestionUI(this.quizModel);
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      backgroundColor: AppThemes.BG_COLOR,
      statusBarColor: AppThemes.BG_COLOR,
      statusBarIconBrightness: Brightness.dark,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Add Questions', style: AppThemes.headerTitleBlackFont),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: AppThemes.blackPearl,
          ),
        ),
      ),
      child: bodyContent(context),
    );
  }

  Widget bodyContent(context) {
    //init values for drop down in list
    controller.initDropDown();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// question body
              FormInputFieldWithIcon(
                controller: controller.quizQuestionController,
                iconPrefix: Icons.quiz,
                labelText: 'Question',
                maxLines: 5,
                maxLength: 500,
                textCapitalization: TextCapitalization.sentences,
                iconColor: AppThemes.DEEP_ORANGE,
                textStyle: AppThemes.normalBlackFont,
                autofocus: false,
                //validator: Validator().name,
                onChanged: (value) => null,
                onSaved: (value) => null,
              ),
              FormVerticalSpace(),


              /// add option button and title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Options',
                      style: AppThemes.headerItemTitle,
                    ),
                  ),
                  Container(
                    width: 80,
                    child: PrimaryButton(
                      buttonStyle: ElevatedButton.styleFrom(
                        backgroundColor: AppThemes.blackPearl,
                        shape: StadiumBorder(),
                      ),
                      labelText: 'Add',
                      textStyle: AppThemes.buttonFont.copyWith(fontSize: 15),
                      onPressed: () {
                        Get.defaultDialog(
                          titleStyle: AppThemes.dialogTitleHeader,
                          title: "Add Option",
                          content: Form(
                            key: _formKey1,
                            child: Column(
                              children: [
                                FormInputFieldWithIcon(
                                  controller:
                                      controller.optionsController,
                                  iconPrefix: Icons.text_fields,
                                  labelText: 'Option',
                                  maxLines: 1,
                                  autofocus: false,
                                  textCapitalization: TextCapitalization.words,
                                  iconColor: AppThemes.DEEP_ORANGE,
                                  textStyle: AppThemes.normalBlackFont,
                                  //maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                  //validator: Validator().name,
                                  onChanged: (value) => null,
                                  onSaved: (value) => null,
                                ),
                                FormVerticalSpace(
                                  height: 15,
                                ),
                                Center(
                                  child: Container(
                                    width: 150,
                                    child: PrimaryButton(
                                      labelText: 'Add Option',
                                      textStyle: AppThemes.buttonFont,
                                      onPressed: () {
                                        if (_formKey1.currentState!
                                            .validate()) {
                                          SystemChannels.textInput.invokeMethod(
                                              'TextInput.hide'); //to hide the keyboard - if any
                                          controller.addOptions();
                                          controller.clearControllers();
                                          Get.back();
                                          //print('added');
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Divider(color: AppThemes.DEEP_ORANGE),

              /// options list
              Obx(
                () => Container(
                  child: ListView(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    children: controller.optionList
                        .map((element) => Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppThemes.DEEP_ORANGE.withOpacity(0.22),
                                    blurRadius: 10.78,
                                    offset: Offset(0, 0),
                                    // Shadow position
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width:
                                          AppConstant.getScreenWidth(context) *
                                              0.5,
                                      child: Text(
                                        '$element',
                                        maxLines: 3,
                                        textAlign: TextAlign.justify,
                                        style: AppThemes.normalBlackFont,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          controller.optionList
                                              .remove(element);
                                          controller.initDropDown();
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          size: 20,
                                        ))
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
              Divider(color: AppThemes.DEEP_ORANGE),
              FormVerticalSpace(),

              /// dropdown options
              Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppThemes.DEEP_ORANGE,
                          width: 1.5,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(8)),
                  child: DropdownButton(
                    isExpanded: true,
                    style: AppThemes.normalBlackFont,
                    hint: Text('${controller.option.value}'),
                    onChanged: (newValue) {
                      controller.setOption(newValue);
                      int index = controller.optionList.indexOf(newValue);
                      print('Selected Index: $index');
                      controller.setCorrectIndex(index);
                      print('Correct Selected Index: ${controller.correctIndex}');
                    },
                    items: controller.optionList.map((element) {
                      print('Option Value: ${controller.option.value}');
                      return DropdownMenuItem(
                        child: Text(element),
                        value: element,
                      );
                    }).toList(),
                    value: controller.option.value,
                  ),
                ),
              ),
              FormVerticalSpace(
                height: 50,
              ),
              Center(
                child: Container(
                  width: 200,
                  child: PrimaryButton(
                    labelText: 'Create Question',
                    textStyle: AppThemes.buttonFont,
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          controller.option.value !=
                              AppConstant.CHOOSE_OPTION) {
                        SystemChannels.textInput.invokeMethod(
                            'TextInput.hide'); //to hide the keyboard - if any
                        //labController.createLab();
                        controller.createQuestion(quizModel);
                        Get.back();
                        //print('added');
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
