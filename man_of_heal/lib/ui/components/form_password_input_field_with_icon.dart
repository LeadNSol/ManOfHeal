import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class FormPasswordInputFieldWithIcon extends StatefulWidget {
  FormPasswordInputFieldWithIcon(
      {required this.controller,
      required this.iconPrefix,
      required this.labelText,
      required this.validator,
      this.iconColor,
      this.textStyle,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines,
      this.maxLength,
      this.maxLengthEnforcement,
      this.onPasswordVisible,
      required this.onChanged,
      this.onSaved});

  final TextEditingController controller;
  final IconData iconPrefix;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final obscureText;
  final int minLines;
  final int? maxLines;
  final maxLength;
  final iconColor;
  final textStyle;
  final maxLengthEnforcement;
  final void Function(String) onChanged;
  final void Function(String?)? onSaved;
  final void Function(bool?)? onPasswordVisible;

  @override
  State<FormPasswordInputFieldWithIcon> createState() =>
      _FormPasswordInputFieldWithIconState();
}

class _FormPasswordInputFieldWithIconState
    extends State<FormPasswordInputFieldWithIcon> {
  RxBool passVisibility = true.obs;

  _toggle() {
    passVisibility.value = !passVisibility.value;
    print("password visible: ${passVisibility.value}");
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        decoration: InputDecoration(
            filled: false,
            prefixIcon: Icon(
              widget.iconPrefix,
              color: widget.iconColor ?? Colors.black,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: widget.iconColor ?? AppThemes.DEEP_ORANGE, width: 2.0,
                  ),
              //borderRadius: BorderRadius.circular(20)
            ),
            fillColor: widget.iconColor ?? AppThemes.DEEP_ORANGE,
            labelText: widget.labelText,
            labelStyle: widget.textStyle,
            focusColor: widget.iconColor,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: widget.iconColor ?? AppThemes.DEEP_ORANGE, width: 2.0),
              //borderRadius: BorderRadius.circular(25.0),
            ),
            suffixIcon: widget.obscureText
                ? GestureDetector(
                    onTap: _toggle,
                    child: Icon(
                      passVisibility.isTrue
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: widget.iconColor,
                    ),
                  )
                : null),
        controller: widget.controller,
        cursorColor: widget.iconColor,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        obscureText: passVisibility.value,
        style: widget.textStyle,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        maxLength: widget.maxLength,
        validator: widget.validator,
      ),
    );
  }
}
