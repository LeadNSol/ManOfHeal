import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/ui/components/base_widget.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

import '../../../controllers/lab_controller.dart';

class LabInstructionUI extends StatelessWidget {
  // const LabInstructionUI({Key? key}) : super(key: key);
 final  controller =  Get.put(LabController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BaseWidget(
        extendBody: false,
        //backgroundColor: ,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppThemes.whiteLilac,
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: AppThemes.blackPearl,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: buildLabInstructionIcon(),
                ),
                FormVerticalSpace(
                  height: 100,
                ),
                Text(
                  'Your lab everywhere',
                  style: GoogleFonts.poppins(
                      color: AppThemes.blackPearl,
                      fontSize: 22.2,
                      fontWeight: FontWeight.w600),
                ),
                FormVerticalSpace(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    labText,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      color: Colors.black45,
                    ),
                  ),
                ),
                FormVerticalSpace(
                  height: 100,
                ),
                Center(
                  child: Container(
                    width: 180,
                    child: PrimaryButton(
                        labelText: 'GET STARTED',
                        textStyle: AppThemes.buttonFont,
                        onPressed: () {
                          Get.offNamed(AppRoutes.labsRoute);
                        }),
                  ),
                ),
                // Expanded(child: Center())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
