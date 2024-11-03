import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class AddLabUI extends StatelessWidget {

  final LabController controller = Get.put(LabController());
  @override
  Widget build(BuildContext context) {
    return body(context);

  }

  Widget body(context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(alignment:Alignment.topCenter,child: Text("Add Lab", style: AppThemes.dialogTitleHeader,)),
              FormVerticalSpace(height: 10,),
              FormInputFieldWithIcon(
                controller: controller.titleController,
                iconPrefix: Icons.title_outlined,
                labelText: 'Title',
                maxLines: 1,
                iconColor: AppThemes.DEEP_ORANGE,
                textStyle: AppThemes.normalBlackFont,
                autofocus: true,
                //validator: Validator().name,
                onChanged: (value) => null,
                onSaved: (value) => null,
              ),
              FormVerticalSpace(height: 10,),
              FormInputFieldWithIcon(
                controller: controller.shortDescController,
                iconPrefix: Icons.description_outlined,
                labelText: 'Short Description',
                maxLines: 2,
                autofocus: false,
                iconColor: AppThemes.DEEP_ORANGE,
                textStyle: AppThemes.normalBlackFont,
                maxLength: 70,
                // validator: Validator().name,
                onChanged: (value) => null,
                onSaved: (value) => null,
              ),
              FormVerticalSpace(height: 10,),
              FormInputFieldWithIcon(
                controller: controller.longDescController,
                iconPrefix: Icons.list_alt_outlined,
                labelText: 'Long Description',
                maxLines: 10,
                autofocus: false,
                iconColor: AppThemes.DEEP_ORANGE,
                textStyle: AppThemes.normalBlackFont,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                maxLength: 1000,
                //validator: Validator().name,
                onChanged: (value) => null,
                onSaved: (value) => null,
              ),
              FormVerticalSpace(height: 15,),
              Center(
                child: Container(
                  width: 150,
                  child: PrimaryButton(
                    labelText: 'Add Lab',
                    textStyle: AppThemes.buttonFont,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        SystemChannels.textInput.invokeMethod(
                            'TextInput.hide'); //to hide the keyboard - if any
                        controller.createLab();
                        Get.back();
                        //print('added');
                      }
                    },
                  ),
                ),
              ),
             // Expanded(child: Container())
            ],
          ),
        ),
      ),
    );
  }
}
