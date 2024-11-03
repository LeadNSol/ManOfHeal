import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:man_of_heal/utils/app_themes.dart';

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
      style: buttonStyle ??
          ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            backgroundColor: AppThemes.DEEP_ORANGE,
            shape: StadiumBorder(),
          ),
      child: hasIcon
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 22,
                  height: 22,
                  child: SvgPicture.asset(
                    "assets/icons/$icon",
                    // height: 10,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Text(
                  labelText,
                  textAlign: TextAlign.center,
                  style: textStyle ?? AppThemes.buttonFont,
                ),
              ],
            )
          : Text(
              labelText,
              textAlign: TextAlign.center,
              style: textStyle ?? AppThemes.buttonFont,
            ),
    );
  }
}
