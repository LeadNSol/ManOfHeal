import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:man_of_heal/ui/components/double_back_press_on_exit.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget(
      {super.key,
      required this.child,
      this.floatingButton,
      this.scaffoldBgColor,
      this.hasTransparentBg, this.statusBarColor});

  final Widget? child, floatingButton;
  final Color? scaffoldBgColor, statusBarColor;
  final bool? hasTransparentBg;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: AppThemes.white,
        statusBarBrightness: Brightness.dark,
        statusBarColor: statusBarColor ?? AppThemes.BG_COLOR,
        statusBarIconBrightness: Brightness.dark
      ),
      child: DoubleBackPressToExit(
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: EdgeInsets.zero,
            child: floatingButton,
          ),
          backgroundColor: hasTransparentBg ?? false
              ? Colors.transparent
              : scaffoldBgColor ?? AppThemes.BG_COLOR,
          body: child,
        ),
      ),
    );
  }
}
