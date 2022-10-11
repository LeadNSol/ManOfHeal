import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/ui/labs/labs_ui.dart';
import 'package:man_of_heal/utils/app_themes.dart';
import 'package:man_of_heal/utils/svgs.dart';

class LabInstructionUI extends StatelessWidget {
  // const LabInstructionUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: buildLabInstructionIcon(),
                ),
                FormVerticalSpace(height: 100,),
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
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
                    'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                    ' tempor  incididunt ut labore et dolore magna aliqua',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.montserrat(
                      fontSize: 13,

                      color: Colors.black45,
                    ),
                  ),
                ),
                FormVerticalSpace(height: 100,),
                Center(
                  child: Container(
                    width: 180,
                    child: PrimaryButton(
                        buttonStyle: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          primary: AppThemes.DEEP_ORANGE,
                          shape: StadiumBorder(),
                        ),
                        labelText: 'GET STARTED',
                        textStyle: AppThemes.buttonFont,
                        onPressed: ()  {
                          Get.off(LabsUI());
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
