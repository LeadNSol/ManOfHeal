import 'package:flutter/cupertino.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key, this.text}) : super(key: key);
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text ?? "No Data Found!",
        style: AppThemes.headerItemTitle,
      ),
    );
  }
}
