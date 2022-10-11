import 'package:flutter/cupertino.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No Data Found!",
        style: AppThemes.headerItemTitle,
      ),
    );
  }
}
