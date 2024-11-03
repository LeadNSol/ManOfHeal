import 'package:flutter/material.dart';

import '../../utils/app_themes.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key, this.onPressed});

  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.transparent,
      //clipBehavior: Clip.antiAlias,
      elevation: 0,
      highlightElevation: 0,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              AppThemes.gradientColor_1,
              AppThemes.gradientColor_2
            ],
          ),
        ),
        child: Icon(
          Icons.add_rounded,
          size: 30,
        ),
        // child: SvgPicture.asset("assets/icons/fab_icon.svg"),
      ),
    );
  }
}
