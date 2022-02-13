import 'package:flutter/material.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class BlackRoundedContainer extends StatelessWidget {
  final double? bottomLeft;
  final double? bottomRight;

  BlackRoundedContainer({this.bottomRight, this.bottomLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppThemes.blackPearl,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(bottomLeft!),
          bottomRight: Radius.circular(bottomRight!),
        ),
      ),
    );
  }
}
