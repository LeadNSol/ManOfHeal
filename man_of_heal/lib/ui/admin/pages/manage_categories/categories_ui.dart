import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class CategoriesUI extends GetView<CategoryController> {
  const CategoriesUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppThemes.BG_COLOR,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppThemes.BG_COLOR,
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
        ),
        title: Text(
          "Categories",
          style: AppThemes.headerTitleBlackFont,
        ),
      ),
      body: _body(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            title: "Add Category",
            titleStyle: AppThemes.dialogTitleHeader,
            content: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FormInputFieldWithIcon(
                      controller: controller.categoryTitleController,
                      iconPrefix: Icons.title,
                      labelText: 'Category title',
                      autofocus: false,
                      iconColor: AppThemes.DEEP_ORANGE,
                      textStyle: AppThemes.normalBlackFont,
                      validator: Validator().notEmpty,
                      keyboardType: TextInputType.text,
                      onChanged: (value) => null,
                      onSaved: (value) => null,
                    ),
                    FormVerticalSpace(),
                  ],
                ),
              ),
            ),
            confirm: Container(
              width: 150,
              child: PrimaryButton(
                labelText: 'Add',
                textStyle: AppThemes.buttonFont,
                onPressed: () async {
                  if (controller.formKey.currentState!.validate()) {
                    SystemChannels.textInput.invokeMethod(
                        'TextInput.hide'); //to hide the keyboard - if any
                    await controller.createCategory();
                  }
                },
              ),
            ),
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
              colors: [AppThemes.gradientColor_1, AppThemes.gradientColor_2],
            ),
          ),
          child: Icon(
            Icons.add_rounded,
            size: 30,
          ),
          // child: SvgPicture.asset("assets/icons/fab_icon.svg"),
        ),
      ),
    );
  }

  Widget _body(context) {
    return Obx(
      () => controller.categoriesList.isEmpty
          ? NoDataFound()
          : ListView.builder(
              itemCount: controller.categoriesList.length,
              itemBuilder: (_, index) {
                CategoryModel model = controller.categoriesList[index];
                return SingleCategoryItem(model: model);
              },
            ),
    );
  }
}

class SingleCategoryItem extends GetView<CategoryController> {
  SingleCategoryItem({Key? key, this.model}) : super(key: key);
  final CategoryModel? model;

  @override
  Widget build(BuildContext context) {
    var userName = "fetching...".obs;
    getUserById().then((UserModel model) {
      userName.value = model.name!;
    });

    return CustomContainer(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              model!.category!,
              style: AppThemes.header3.copyWith(
                  color: AppThemes.blackPearl, fontWeight: FontWeight.bold),
            ),
            FormVerticalSpace(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'By: ',
                            style: AppThemes.normalBlackFont
                                .copyWith(fontSize: 11)),
                        TextSpan(
                            text: userName.value,
                            style: AppThemes.normalBlack45Font
                                .copyWith(fontSize: 11.5)),
                      ],
                    ),
                  ),
                ),

                //Date and time
                Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Image.asset(
                            "assets/icons/estimated_time_green_icon.png",
                            width: 12,
                          ),
                        ),
                        TextSpan(
                          text:
                              " ${AppConstant.formattedDataTime("MMM-dd-yyyy", model!.createdDate!)}",
                          style: AppThemes.normalBlack45Font
                              .copyWith(fontSize: 11.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: InkWell(
          onTap: () => showDeleteConfirmationDialog(model!),
          child: Text(
            "Remove",
            style: AppThemes.normalORANGEFont.copyWith(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(CategoryModel model) {
    Get.defaultDialog(
      title: "Delete Category!",
      titleStyle:
          AppThemes.dialogTitleHeader.copyWith(color: AppThemes.DEEP_ORANGE),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Are you sure you want to delete this ${model.category!}?",
              style: AppThemes.normalBlackFont,
            ),
            FormVerticalSpace(),
            buildDeleteDialogUI(),
            FormVerticalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  child: PrimaryButton(
                    labelText: 'Yes',
                    textStyle: AppThemes.buttonFont,
                    onPressed: () {
                      model.isDeleted = true;
                      controller.deleteCategory(model);
                    },
                  ),
                ),
                Container(
                  width: 100,
                  child: PrimaryButton(
                      buttonStyle: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        backgroundColor: AppThemes.DEEP_ORANGE,
                        shape: StadiumBorder(),
                      ),
                      labelText: 'No',
                      textStyle: AppThemes.buttonFont,
                      onPressed: () => Get.back()),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<UserModel> getUserById() {
    return authController.getUserById(model!.createdBy!);
  }
}
