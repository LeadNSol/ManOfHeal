import 'package:flutter/material.dart';

class BlackRoundedContainer extends StatelessWidget {
  final double? bottomLeft;
  final double? bottomRight;

  BlackRoundedContainer({this.bottomRight, this.bottomLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:

      BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20.04),
        ),
        color: Color(0xff1F1D1F),
      )

     /* BoxDecoration(
        color: AppThemes.blackPearl,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(bottomLeft!),
          bottomRight: Radius.circular(bottomRight!),
        ),
      ),*/
    );
  }
}
