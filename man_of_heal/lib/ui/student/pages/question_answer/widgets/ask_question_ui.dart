import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/ui/components/form_input_field_with_icon.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/utils/validator.dart';

class AskQuestionUI extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask Question'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: Card(
              elevation: 10,
              margin: EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //dropdown will goes here,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Obx(
                        () => DropdownButton(
                          //isExpanded: true,
                          hint: Text('Choose Category'),
                          onChanged: (newValue) {
                            print('newValue: $newValue');
                            qaController.setSelectedCategory(newValue as String);
                          },
                          items:
                              qaController.categoriesList.map((categoryModel) {
                            String category = categoryModel.category!;
                            return DropdownMenuItem(
                              child: Text('$category'),
                              value: category,
                            );
                          }).toList(),

                          value: qaController.selectedCategory.value,

                        ),
                      ),
                    ),

                    FormVerticalSpace(),

                    FormInputFieldWithIcon(
                      controller: qaController.questionController,
                      iconPrefix: Icons.question_answer_outlined,
                      labelText: 'Question Body',
                      maxLines: 10,
                      autofocus: true,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      maxLength: 150,
                      validator: Validator().name,
                      onChanged: (value) => null,
                      onSaved: (value) =>
                          qaController.questionController.text = value!,
                    ),
                    FormVerticalSpace(),
                    PrimaryButton(
                        labelText: "Submit",
                        onPressed: () async {
                          // if (_formKey.currentState!.validate()) {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          qaController.createQuestion();
                          Get.back();
                          // }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
