import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class LabsUI extends GetView<LabController> {
  //var isVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: _body(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: authController.admin.isTrue
            ? FloatingActionButton(
                onPressed: () {
                  Get.bottomSheet(
                    AddLabUI(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                    backgroundColor: Colors.white,
                  );
                },
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
      ),
    );
  }

  Widget _body() {
    return controller.obx((state) {
      if (controller.status.isLoading) {
        return CircularProgressIndicator();
      } else if (controller.status.isEmpty || controller.status.isError) {
        return Center(
          child: Container(
            child: Text(
              'No Labs Data Found',
              style: AppThemes.header2,
            ),
          ),
        );
      } else {
        var labs = state as List<LabModel>;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormVerticalSpace(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Total Labs (${labs.length})',
                style: GoogleFonts.poppins(
                    fontSize: 16.65,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            FormVerticalSpace(),
            Expanded(
              child: ListView.builder(
                itemCount: labs.length,
                itemBuilder: (context, index) {
                  return SingleLabWidget(labs[index]);
                },
              ),
            ),
          ],
        );
      }
    });
  }
}
