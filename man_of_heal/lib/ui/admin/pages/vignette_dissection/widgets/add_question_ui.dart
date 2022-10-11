import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/quiz_model.dart';
import 'package:man_of_heal/ui/components/form_input_field_with_icon.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class AddQuestionUI extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

  final QuizModel quizModel;
  AddQuestionUI(this.quizModel);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppThemes.BG_COLOR,
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
        body: bodyContent(context),
      ),
    );
  }

  Widget bodyContent(context) {
    //init values for drop down in list
    adminVdController.initDropDown();
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
                controller: adminVdController.quizQuestionController,
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
                        primary: AppThemes.blackPearl,
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
                                      adminVdController.optionsController,
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
                                      buttonStyle: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        primary: AppThemes.DEEP_ORANGE,
                                        shape: StadiumBorder(),
                                      ),
                                      labelText: 'Add Option',
                                      textStyle: AppThemes.buttonFont,
                                      onPressed: () {
                                        if (_formKey1.currentState!
                                            .validate()) {
                                          SystemChannels.textInput.invokeMethod(
                                              'TextInput.hide'); //to hide the keyboard - if any
                                          adminVdController.addOptions();
                                          adminVdController.clearControllers();
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
                    children: adminVdController.optionList
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
                                          adminVdController.optionList
                                              .remove(element);
                                          adminVdController.initDropDown();
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
                    hint: Text('${adminVdController.option.value}'),
                    onChanged: (newValue) {
                      adminVdController.setOption(newValue);
                      int index = adminVdController.optionList.indexOf(newValue);
                      print('Selected Index: $index');
                      adminVdController.setCorrectIndex(index);
                      print('Correct Selected Index: ${adminVdController.correctIndex}');
                    },
                    items: adminVdController.optionList.map((element) {
                      print('Option Value: ${adminVdController.option.value}');
                      return DropdownMenuItem(
                        child: Text(element),
                        value: element,
                      );
                    }).toList(),
                    value: adminVdController.option.value,
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
                          adminVdController.option.value !=
                              AppConstant.CHOOSE_OPTION) {
                        SystemChannels.textInput.invokeMethod(
                            'TextInput.hide'); //to hide the keyboard - if any
                        //labController.createLab();
                        adminVdController.createQuestion(quizModel);
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
