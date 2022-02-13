import 'package:flutter/material.dart';
import 'package:man_of_heal/utils/app_themes.dart';
/*
FormInputFieldWithIcon(
                controller: _email,
                iconPrefix: Icons.link,
                labelText: 'Post URL',
                validator: Validator.notEmpty,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                onChanged: (value) => print('changed'),
                onSaved: (value) => print('implement me'),
              ),
*/

class FormInputFieldWithIcon extends StatelessWidget {
  FormInputFieldWithIcon(
      {required this.controller,
      required this.iconPrefix,
      required this.labelText,
      this.suffix,
      this.iconColor,
      this.textStyle,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines,
      this.maxLength,
      this.autofocus,
      this.maxLengthEnforcement,
      required this.onChanged,
      required this.onSaved});

  final TextEditingController controller;
  final IconData iconPrefix;
  final String labelText;
  final bool? autofocus;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final obscureText;
  final int minLines;
  final int? maxLines;
  final iconColor;
  final textStyle;
  final maxLength;
  final maxLengthEnforcement;
  final void Function(String) onChanged;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus!,
      decoration: InputDecoration(
        filled: false,
        suffix: suffix,
        prefixIcon: Icon(
          iconPrefix,
          color: iconColor ?? AppThemes.DEEP_ORANGE,
        ),
        labelText: labelText,
        labelStyle: textStyle,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: iconColor ?? AppThemes.DEEP_ORANGE,
            width: 2.0,
          ),
          //borderRadius: BorderRadius.circular(20)
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: iconColor ?? AppThemes.DEEP_ORANGE, width: 2.0),
          //borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      controller: controller,
      cursorColor: iconColor,
      style: textStyle,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      maxLengthEnforcement: maxLengthEnforcement,
      maxLength: maxLength,
      validator: validator,
    );
  }
}
