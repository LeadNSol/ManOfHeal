import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          extendBody: true,
          body: landingPageController.currentAdminPage,
          bottomNavigationBar: _bottomCircularNotchedBar(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
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
    );
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
          onTap: onTapped,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_rounded), label: "Favorite"),
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
