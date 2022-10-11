import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/admin_vd_controller.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/controllers/qa_controller.dart';
import 'package:man_of_heal/controllers/subscription_controller.dart';
import 'package:man_of_heal/ui/admin/pages/manage_categories/categories_ui.dart';
import 'package:man_of_heal/ui/components/double_back_press_on_exit.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _initControllers();
    return Obx(
      () => SafeArea(
        child: DoubleBackPressToExit(
          child: Scaffold(
            extendBody: true,
            body: landingPageController.currentAdminPage,
            bottomNavigationBar: _bottomCircularNotchedBar(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () => Get.to(() => CategoriesUI()),
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
            ),
          ),
        ),
      ),
    );
  }

  /// controller that required user ID's
  /// and common for both users,
  ///
  _initControllers() {
    print(" _initControllers()");

    /* Get.put(CategoryController());
    Get.put(LabController());
    Get.put(DailyActivityController());
    Get.put(FeedBackController());*/
    //Get.put(SubscriptionController());
   //Get.put(QAController());
    Get.put(AdminVdController());
  }

  _bottomCircularNotchedBar() {
    final _inactiveColor = Colors.grey;
    return BottomAppBar(
      //color: Colors.deepPurple,
      notchMargin: 8,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      elevation: 20,
      shape: CircularNotchedRectangle(),
      child: Obx(
        () => BottomNavigationBar(
          currentIndex: landingPageController.adminTabIndex.value,
          selectedItemColor: AppThemes.DEEP_ORANGE,
          unselectedItemColor: _inactiveColor,
          selectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
          onTap: onTapped,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline), label: "Favorite"),
          ],
        ),
      ),
    );
  }

  onTapped(int index) {
    landingPageController.setAdminPage(index);
    // if (index == 1) landingPageController.setCalledFor("Answered");
  }
}
