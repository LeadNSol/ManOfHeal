import 'package:flutter/material.dart';
/*
LabelButton(
                labelText: 'Some Text',
                onPressed: () => print('implement me'),
              ),
*/

class LabelButton extends StatelessWidget {
  LabelButton(
      {required this.labelText, required this.onPressed, this.textStyle});

  final String labelText;
  final void Function() onPressed;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        labelText,
        textAlign: TextAlign.center,
        style: textStyle,
      ),
      onPressed: onPressed,
    );
  }
}
