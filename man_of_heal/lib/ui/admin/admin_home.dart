import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/ui/components/base_widget.dart';
import 'package:man_of_heal/ui/components/custom_floating_action_button.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class AdminHome extends StatelessWidget {
  final LandingPageController controller = Get.put(LandingPageController());

  @override
  Widget build(BuildContext context) {
    //_initControllers();
    return Obx(
      () => BaseWidget(
        extendBody: true,
        child: controller.currentAdminPage,
        bottomNaviBar: _bottomCircularNotchedBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingButton: CustomFloatingActionButton(
          onPressed: () => Get.to(() => CategoriesUI()),
        ),
      ),
    );
  }


  _bottomCircularNotchedBar() {
    final _inactiveColor = Colors.grey;
    return Stack(
      children: [
        BottomAppBar(
          //color: Colors.deepPurple,
          notchMargin: 8,
          color: Colors.white,
          clipBehavior: Clip.hardEdge,
          elevation: 0,
          shape: CircularNotchedRectangle(),
          child: Container(
            //width: double.infinity,
            height: 50,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Obx(
            () => BottomNavigationBar(
              currentIndex: controller.adminTabIndex.value,
              selectedItemColor: AppThemes.DEEP_ORANGE,
              unselectedItemColor: _inactiveColor,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedLabelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 10),
              unselectedLabelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 10),
              onTap: onTapped,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_outline), label: "Favorite"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  onTapped(int index) {
    controller.setAdminPage(index);
    // if (index == 1) landingPageController.setCalledFor("Answered");
  }
}
