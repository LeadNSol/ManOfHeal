import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class QodAndTodUI extends StatelessWidget {
   QodAndTodUI({Key? key}) : super(key: key);
final DailyActivityController controller = Get.put(DailyActivityController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomContainer(
        margin: const EdgeInsets.only(top: 130, left: 17, right: 17),
        height: kIsWeb ? 120 : 150,
        child: InkWell(
          onTap: () => Get.to(() => DailyActivityScreen()),
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Question Of The Day',
                    style: AppThemes.headerTitle,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${controller.model!.qOfDay!.isNotEmpty ? controller.model!.qOfDay : AppConstant.noTODFound}',
                    style: AppThemes.normalBlackFont,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Term Of The Day',
                    style: AppThemes.headerTitle,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${controller.model!.termOfDay!.isNotEmpty ? controller.model!.termOfDay : AppConstant.noTODFound}',
                    style: AppThemes.normalBlackFont,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
