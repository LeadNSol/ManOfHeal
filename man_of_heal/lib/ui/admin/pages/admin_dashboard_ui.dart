import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/ui/components/base_widget.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class AdminDashboardUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      backgroundColor: AppThemes.blackPearl,
      statusBarColor: AppThemes.blackPearl,
      statusBarIconBrightness: Brightness.light,
      resizeToAvoidBottomInset: false,
      child: newDashboard(context),
    );
  }

  Widget newDashboard(context) {
    return Stack(
      children: [
        /// pink background
        Positioned(
          top: AppConstant.getScreenHeight(context) * 0.23,
          left: 0,
          child: Container(
            width: AppConstant.getScreenWidth(context),
            height: AppConstant.getScreenHeight(context),
            decoration: BoxDecoration(
              color: AppThemes.BG_COLOR,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
            ),
          ),
        ),

        /// Headers
        Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FormVerticalSpace(),
              //Header profile icon and Dashboard Text...
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: RichText(
                      text: TextSpan(
                        text: 'Admin\n',
                        style: AppThemes.headerTitleFont,
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  'Welcome ${AppCommons.userModel!.name}!',
                              style: GoogleFonts.montserrat(fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                  NotificationBadgeUI(),
                  //profile icon
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      //Get.to(() => ProfileUI());
                      Get.toNamed(AppRoutes.profileRoute);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white,
                      ),
                      child: Obx(
                        () => CircularAvatar(
                          padding: 3,
                          imageUrl: AppCommons.userModel?.photoUrl ?? "",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //FormVerticalSpace(),
              Expanded(child: Center()),
            ],
          ),
        ),

        ///QOQ and TOD
        QodAndTodUI(),

        /// Dashboard items
        Container(
          margin: EdgeInsets.only(
              top: AppConstant.getScreenHeight(context) * (kIsWeb ? 0.4 : 0.3),
              left: 15,
              right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customDashboardItems(context, () {
                    Get.find<LandingPageController>().setAdminPage(1);
                  }, "assets/icons/questions_icon.svg", "Questions"),
                  SizedBox(
                    width: 10,
                  ),
                  customDashboardItems(context, () {
                    Get.to(() => DailyActivityScreen());
                  }, "assets/icons/qod_icon.svg", "QOD"),
                ],
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customDashboardItems(
                      context,
                      () => Get.to(() => LabInstructionUI()),
                      "assets/icons/lab_icon.svg",
                      "Labs"),
                  SizedBox(
                    width: 10,
                  ),
                  customDashboardItems(
                      context,
                      () => Get.toNamed(AppRoutes.adminVignetteD),
                      "assets/icons/quiz_icon.svg",
                      "Quiz"),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget customDashboardItems(context, onTap, image, name) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        width: 135,
        height: 122,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            border: Border.all(color: AppThemes.DEEP_ORANGE.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              width: 50,
              height: 50,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "$name",
              style: AppThemes.normalBlackFont,
            )
          ],
        ),
      ),
    );
  }

  //Top card item
  Widget customRichText(title, subtitle) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '$title',
                    style: GoogleFonts.poppins(
                      fontSize: 17.46,
                      color: AppThemes.DEEP_ORANGE,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '$subtitle',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
        /*  FormVerticalSpace(height: 10,),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Term Of The Day',
                    style: GoogleFonts.poppins(
                      fontSize: 17.46,
                      color: Color(0xffFC2125),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'DVT',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight:
                        FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),*/
      ],
    );
  }
}
