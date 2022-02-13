import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/*
PrimaryButton(
                labelText: 'UPDATE',
                onPressed: () => print('Submit'),
              ),
*/

class PrimaryButton extends StatelessWidget {
  PrimaryButton(
      {required this.labelText,
      required this.onPressed,
      this.buttonStyle,
      this.hasIcon = false,
      this.icon,
      this.textStyle});

  final String labelText;
  final void Function() onPressed;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;
  final bool hasIcon;
  final icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: hasIcon
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  child: SvgPicture.asset(
                    "assets/icons/$icon",
                   // height: 10,
                    fit: BoxFit.fitWidth,
                  ),

                ),
                SizedBox(
                  width: 40,
                ),
                Text(
                  labelText,
                  textAlign: TextAlign.center,
                  style: textStyle ?? TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            )
          : Text(
              labelText,
              textAlign: TextAlign.center,
              style: textStyle ?? TextStyle(fontWeight: FontWeight.bold),
            ),
    );
  }
}
