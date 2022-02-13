import 'package:flutter/material.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final BoxConstraints? constraints;
  final double? width;
  final double? height;
  final Color? color;
  final bool? hasOuterShadow;
  final Alignment? alignment;

  CustomContainer(
      {required this.child,
      this.constraints,
      this.height,
      this.width,
      this.hasOuterShadow,
      this.alignment,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
      alignment: alignment,
      decoration: hasOuterShadow! ? boxOuterShadow() : boxNoShadow(),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: child,
    );
  }
}

BoxDecoration boxNoShadow() {
  return BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(14.3)),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: AppThemes.DEEP_ORANGE.withOpacity(0.22),
        blurRadius: 4,
        spreadRadius: 2,
        offset: Offset(2, 3),
        // Shadow position
      ),
    ],
  );
}

BoxDecoration boxOuterShadow() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(12.0),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
          color: AppThemes.DEEP_ORANGE.withOpacity(0.22),
          blurRadius: 13,
          spreadRadius: 2,
          blurStyle: BlurStyle.outer // Shadow position
          ),
    ],
  );
}
