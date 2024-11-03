import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:man_of_heal/ui/components/double_back_press_on_exit.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget(
      {super.key,
      required this.child,
      this.floatingButton,
      this.backgroundColor,
      this.hasTransparentBg,
      this.statusBarColor,
      this.resizeToAvoidBottomInset,
      this.bottomNaviBar,
      this.statusBarIconBrightness,
      this.appBar,
      this.floatingActionButtonLocation, this.extendBody});

  final PreferredSizeWidget? appBar;
  final Widget? child, floatingButton, bottomNaviBar;
  final Color? backgroundColor, statusBarColor;
  final bool? hasTransparentBg, resizeToAvoidBottomInset, extendBody;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Brightness? statusBarIconBrightness;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: AppThemes.white,
          statusBarBrightness: Brightness.light,
          statusBarColor: statusBarColor, //?? AppThemes.BG_COLOR,
          statusBarIconBrightness: statusBarIconBrightness ?? Brightness.dark),
      child: DoubleBackPressToExit(
        child: Scaffold(
          appBar: appBar,
          extendBody: extendBody ?? false,
          floatingActionButtonLocation: floatingActionButtonLocation ??
              FloatingActionButtonLocation.centerDocked,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          bottomNavigationBar: bottomNaviBar,
          floatingActionButton: Padding(
            padding: EdgeInsets.zero,
            child: floatingButton,
          ),
          backgroundColor: backgroundColor,
          // backgroundColor: hasTransparentBg ?? false
          //     ? Colors.transparent
          //     : backgroundColor ?? AppThemes.BG_COLOR,
          body: child,
        ),
      ),
    );
  }
}
