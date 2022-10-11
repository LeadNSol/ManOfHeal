import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class LoadingAnimatedButton extends StatelessWidget {
  final int? btnState;
  final double? width;
  final String? text;
  final void Function()? onPressed;

  LoadingAnimatedButton(
      {required this.btnState, required this.width, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: btnSetup(),
    );
    return Obx(
      () => Center(
        child: btnSetup(),
      ),
    );
  }

  Widget btnSetup() {
    if (btnState! == 1)
      return Container(
        width: 45,
        height: 45,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppThemes.DEEP_ORANGE,
        ),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 2.5,
        ),
      );
    else if (btnState! == 2)
      return Container(
          width: 45,
          height: 45,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppThemes.rightAnswerColor,
          ),
          child: Icon(Icons.check, size: 30, color: AppThemes.white));

    return Container(
      width: width,
      child: PrimaryButton(
          labelText: text!,
          buttonStyle: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            primary: AppThemes.DEEP_ORANGE,
            shape: StadiumBorder(),
          ),
          textStyle: AppThemes.buttonFont,
          onPressed: onPressed!),
    );
  }
}
