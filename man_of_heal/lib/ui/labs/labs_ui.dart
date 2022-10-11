import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/labs/add_lab/add_lab_ui.dart';
import 'package:man_of_heal/ui/labs/widgets/single_lab_widget.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class LabsUI extends StatelessWidget {
  //var isVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppThemes.BG_COLOR,
      appBar: AppBar(
        //leadingWidth: 25,
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
        title: Text(
          "Labs",
          style: AppThemes.headerTitleBlackFont,
        ),
      ),
      body: SafeArea(child: _body()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: authController.admin.isTrue
          ? FloatingActionButton(
              onPressed: () {
                print('Pressed fab');
                Get.bottomSheet(
                    AddLabUI(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                  ),
                  backgroundColor: Colors.white,
                );
                //Get.to(()=>AddLabUI());
              /*  String weekDay = DateFormat('EEEE').format(DateTime.now());
                if (weekDay.toLowerCase() == "monday" ||
                    weekDay.toLowerCase() == "thursday")
                  Get.defaultDialog(
                    title: 'Add Lab',
                    titleStyle: AppThemes.dialogTitleHeader,
                    content: AddLabUI(),
                  );
                else
                  AppConstant.displaySnackBar("Warning", "You can plug Lab information only on Monday and Thursday!");
*/              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppThemes.gradientColor_1,
                      AppThemes.gradientColor_2
                    ],
                  ),
                ),
                child: Icon(
                  Icons.add_rounded,
                  size: 30,
                ),
                // child: SvgPicture.asset("assets/icons/fab_icon.svg"),
              ),
            )
          : null,
    );
  }

  Widget _body() {
    print('Lab Length: ${labController.labList.length}');
    if (labController.labList.isNotEmpty && labController.labList.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormVerticalSpace(
            height: 50,
          ),
          Text(
            '   Total Labs',
            style: GoogleFonts.poppins(
                fontSize: 16.65,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          FormVerticalSpace(),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: labController.labList.length,
                itemBuilder: (context, index) {
                  return SingleLabWidget(labController.labList[index]);
                },
              ),
            ),
          ),
        ],
      );
    } else
      return Center(
        child: Container(
          child: Text(
            'No Labs Data Found',
            style: AppThemes.header2,
          ),
        ),
      );
  }
}
