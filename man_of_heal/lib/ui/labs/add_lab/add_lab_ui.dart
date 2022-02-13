import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/ui/components/form_input_field_with_icon.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/utils/app_themes.dart';
import 'package:man_of_heal/utils/validator.dart';

class AddLabUI extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppThemes.BG_COLOR,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Add Lab',style: textTheme.headline6!.copyWith(color: AppThemes.blackPearl),),
          leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: AppThemes.blackPearl,
            ),
          ),
        ),
        body: body(context),
      ),
    );
  }

  Widget body(context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextTheme textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FormInputFieldWithIcon(
                controller: labController.titleController,
                iconPrefix: Icons.title_outlined,
                labelText: 'Title',
                maxLines: 1,
                autofocus: true,
                //validator: Validator().name,
                onChanged: (value) => null,
                onSaved: (value) => null,
              ),
              FormVerticalSpace(),
              FormInputFieldWithIcon(
                controller: labController.shortDescController,
                iconPrefix: Icons.description_outlined,
                labelText: 'Short Description',
                maxLines: 2,
                autofocus: false,
                maxLength: 70,
               // validator: Validator().name,
                onChanged: (value) => null,
                onSaved: (value) => null,
              ),
              FormVerticalSpace(),
              FormInputFieldWithIcon(
                controller: labController.longDescController,
                iconPrefix: Icons.list_alt_outlined,
                labelText: 'Long Description',
                maxLines: 10,
                autofocus: false,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                maxLength: 1000,
                //validator: Validator().name,
                onChanged: (value) => null,
                onSaved: (value) =>null,
              ),
              FormVerticalSpace(),
              Center(
                child: Container(
                  width: 250,
                  child: PrimaryButton(
                    buttonStyle: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      primary: AppThemes.blackPearl,
                      shape: StadiumBorder(),
                    ),
                    labelText: 'Add Lab',
                    textStyle: textTheme.headline5!
                        .copyWith(color: AppThemes.DEEP_ORANGE),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        SystemChannels.textInput.invokeMethod(
                            'TextInput.hide'); //to hide the keyboard - if any
                        labController.createLab();
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
