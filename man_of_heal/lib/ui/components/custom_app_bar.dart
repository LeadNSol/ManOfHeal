import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final Color? iconColor;
  final Color? bgColor;

  CustomAppBar({this.title, this.iconColor, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: bgColor,
      leading: InkWell(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 20,
          color: iconColor,
        ),
      ),
      title: Text(
        title!,
        //style: textTheme.headline6!.copyWith(color: iconColor),
      ),
    );
  }
}
