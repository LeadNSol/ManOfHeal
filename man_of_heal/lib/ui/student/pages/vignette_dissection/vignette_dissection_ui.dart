import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/utils/app_themes.dart';

import 'widgets/vd_body.dart';

class VignetteDissectionUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Get.lazyPut(()=>VDController());
    //changing the status bar color for this ui.
   /* SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppThemes.white));*/

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
        title: Text(
          'Quiz',
          style: AppThemes.headerTitleFont,
        ),
      ),
      body: VDBody(),
    );
  }
}
