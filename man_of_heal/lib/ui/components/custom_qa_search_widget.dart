import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class QASearchWidget extends StatelessWidget {
   QASearchWidget(
      {Key? key, this.searchIconVisibility = false, this.isVisible})
      : super(key: key);
  final bool? searchIconVisibility;
  final bool? isVisible;
  //final AuthController authController = Get.put(AuthController());
  final QAController controller = Get.put(QAController());
  @override
  Widget build(BuildContext context) {

    if (AppCommons.isAdmin) return adminSearchWidget();

    return studentSearchWidget();
  }

  Widget studentSearchWidget() {
    return Visibility(
      visible: searchIconVisibility! && isVisible!,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10, left: 10),
            child: TextField(
              controller: controller.searchController,
              cursorColor: AppThemes.DEEP_ORANGE,
              textInputAction: TextInputAction.search,
              onChanged: (search) => {controller.setSearchQuery(search)},
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  prefixIcon: new Icon(
                    Icons.search,
                    color: AppThemes.DEEP_ORANGE,
                  ),
                  border: InputBorder.none.copyWith(
                    borderSide: BorderSide(style: BorderStyle.solid),
                  ),
                  labelStyle: AppThemes.normalBlackFont,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppThemes.DEEP_ORANGE,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppThemes.DEEP_ORANGE,
                      width: 1.0,
                    ),
                  ),
                  hintText: 'Search Answers ...'),
            ),
          ),
          Positioned(
            top: 1,
            right: 10,
            bottom: 1,
            child: Container(
              //width: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              decoration: BoxDecoration(
                  color: Colors.white54,
                  border: Border.all(
                      color: AppThemes.DEEP_ORANGE.withOpacity(0.9),
                      width: 0.5,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(5)),
              child: DropdownButton(
                //isExpanded: true,
                style: AppThemes.normalBlackFont,
                hint: Text('${controller.selectedCategory.value}'),
                onChanged: (newValue) =>
                    controller.setSelectedCategory(newValue as String),
                items: controller.searchFilterList.map((category) {
                  // String category = categoryModel.category!;
                  return DropdownMenuItem(
                    child: Text(
                      '$category',
                    ),
                    value: category,
                  );
                }).toList(),
                value: controller.selectedCategory.value,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget adminSearchWidget() {
    //controller.initDropDown();

   // debugPrint("Length: ${controller.searchFilterList.length}  Selected Value: ${controller.selectedCategory.value}"  );

    return Visibility(
      visible: searchIconVisibility! && isVisible!,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10, left: 10),
            child: TextField(
              controller: controller.searchController,
              cursorColor: AppThemes.DEEP_ORANGE,
              textInputAction: TextInputAction.search,
              onChanged: (search) {
                controller.setAdminSearchQuery(search);
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  prefixIcon: new Icon(
                    Icons.search,
                    color: AppThemes.DEEP_ORANGE,
                  ),
                  border: InputBorder.none.copyWith(
                    borderSide: BorderSide(style: BorderStyle.solid),
                  ),
                  labelStyle: AppThemes.normalBlackFont,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppThemes.DEEP_ORANGE,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppThemes.DEEP_ORANGE,
                      width: 1.0,
                    ),
                  ),
                  hintText: 'Search Answers ...'),
            ),
          ),
          Positioned(
            top: 1,
            right: 10,
            bottom: 1,
            child: Container(
              //width: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              decoration: BoxDecoration(
                  color: Colors.white54,
                  border: Border.all(
                      color: AppThemes.DEEP_ORANGE.withOpacity(0.9),
                      width: 0.5,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(5)),
              child: DropdownButton(
                //isExpanded: true,
                style: AppThemes.normalBlackFont,
                hint: Text('${controller.selectedCategory.value}'),
                onChanged: (newValue) =>
                    controller.setAdminSelectedCategory(newValue as String),
                items: controller.searchFilterList.map((category) {
                  // String category = categoryModel.category!;
                  return DropdownMenuItem(
                    child: Text(
                      '$category',
                    ),
                    value: category,
                  );
                }).toList(),
                value: controller.selectedCategory.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
