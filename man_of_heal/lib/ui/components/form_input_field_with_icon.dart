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
      this.maxLines = 1,
      this.isExpanded = false,
      this.maxLength,
      this.autofocus,
      this.enableBorder,
      this.textCapitalization = TextCapitalization.none,
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
  final bool? isExpanded;
  final iconColor;
  final textStyle;
  final maxLength;
  final maxLengthEnforcement;
  final InputBorder? enableBorder;
  final TextCapitalization? textCapitalization;
  final void Function(String) onChanged;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus!,
      textCapitalization: textCapitalization!,
      textAlignVertical: TextAlignVertical.top,
      scrollPhysics: AlwaysScrollableScrollPhysics(),
      decoration: InputDecoration(
        filled: false,
        suffix: suffix,
        prefixIcon: Icon(
          iconPrefix,
          color: iconColor ?? AppThemes.DEEP_ORANGE,
        ),
        labelText: labelText,
        labelStyle: textStyle,
        enabledBorder: enableBorder ??
            UnderlineInputBorder(
              borderSide: BorderSide(
                color: iconColor ?? AppThemes.DEEP_ORANGE,
                width: 2.0,
              ),
              //borderRadius: BorderRadius.circular(20)
            ),
        focusedBorder: enableBorder ??UnderlineInputBorder(
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
      expands: isExpanded!,
      maxLines: isExpanded! ? null : maxLines,
      minLines: isExpanded! ? null : minLines,
      maxLengthEnforcement: maxLengthEnforcement,
      maxLength: maxLength,
      validator: validator,
    );
  }
}
