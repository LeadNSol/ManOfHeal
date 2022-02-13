import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/vd_controller.dart';
import 'package:man_of_heal/utils/app_themes.dart';

import 'widgets/vd_body.dart';

class VignetteDissectionUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Get.put(VDController());
    //changing the status bar color for this ui.
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppThemes.blackPearl));

TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppThemes.BG_COLOR,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppThemes.blackPearl,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: AppThemes.white,
          ),
        ),
        title: Text('Quiz',style: textTheme.headline6!.copyWith(color: AppThemes.white) ,),
      ),
      body: VDBody(),
    );
  }
}
