import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/controllers/lab_controller.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/labs/add_lab/add_lab_ui.dart';
import 'package:man_of_heal/ui/labs/widgets/single_lab_widget.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class LabsUI extends StatelessWidget {
  //var isVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Get.put(LabController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppThemes.BG_COLOR,
      appBar: AppBar(
        //leadingWidth: 25,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: AppThemes.blackPearl,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Labs",
          style: textTheme.headline6!.copyWith(color: AppThemes.blackPearl),
        ),
      ),
      body: SafeArea(child: _body(textTheme)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: authController.admin.isTrue
          ? FloatingActionButton(
              onPressed: () {
                print('Pressed fab');
                Get.to(AddLabUI());
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
    );
  }

  Widget _body(TextTheme textTheme) {
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
            style: textTheme.headline6!,
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
            style: textTheme.headline6,
          ),
        ),
      );
  }
}
