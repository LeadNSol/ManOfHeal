import 'package:flutter/material.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final BoxConstraints? constraints;
  final double? width;
  final double? height;
  final Color? color;
  final bool? hasOuterShadow;
  final bool? isNotificationBody;
  final Alignment? alignment;
  final EdgeInsetsGeometry? margin, padding;

  CustomContainer(
      {required this.child,
      this.constraints,
      this.height,
      this.width,
      this.margin,
      this.padding,
      this.isNotificationBody = false,
      this.hasOuterShadow = false,
      this.alignment,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: alignment,
      decoration: hasOuterShadow!
          ? boxOuterShadow(isNotificationBody)
          : boxNoShadow(isNotificationBody),
      padding: padding == null ? const EdgeInsets.all(15) : padding,
      margin: margin == null
          ? const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10)
          : margin,
      child: child,
    );
  }
}

BoxDecoration boxNoShadow(isNotificationBody) {
  return BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(14.3)),
    color: isNotificationBody ? Colors.grey[300]! : Colors.white,
    boxShadow: [
      BoxShadow(
        color: AppThemes.DEEP_ORANGE.withOpacity(0.22),
        offset: Offset(0, 0),
        blurRadius: 10.78,
      ),
    ],
  );
}

BoxDecoration boxOuterShadow(isNotificationBody) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(12.0),
    color: isNotificationBody ? Colors.grey[300]! : Colors.white,
    boxShadow: [
      BoxShadow(
        color: AppThemes.DEEP_ORANGE.withOpacity(0.22),
        offset: Offset(0, 0),
        blurRadius: 10.78,
      ),
    ],
  );
}
