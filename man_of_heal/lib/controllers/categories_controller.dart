import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/utils/export_utils.dart';

class CategoryController extends GetxController {
  /* final QAController? qaController;
  CategoryController(this.qaController);*/

  TextEditingController categoryTitleController = new TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var categoriesList = <CategoryModel>[].obs;

  var selectedCategory = CHOOSE_CATEGORY.obs;
  var selectedCategoryUID = "".obs;

  void setSelectedCategory(String? category) {
    selectedCategory.value = category!;
    print("Category: $category");
    if (!category.contains(CHOOSE_CATEGORY)) {
      selectedCategoryUID.value = categoriesList.isNotEmpty
          ? categoriesList
              .firstWhere((element) => element.category!.contains(category))
              .cUID!
          : category;
    }
  }

  @override
  void onReady() {
    super.onReady();
    initData();
  }

  void initData() {
    categoriesList.bindStream(getAllCategories());

    ever(categoriesList, handleCategoriesDropDown);
  }

  void handleCategoriesDropDown(List<CategoryModel> list) {
    setSelectedCategory(list.isEmpty ? CHOOSE_CATEGORY : list[0].category!);
  }

  String getCategoryById(String? uId) {
    if (categoriesList.isNotEmpty) {
      for (CategoryModel category in categoriesList) {
        if (category.cUID == uId || category.category == uId) {
          return category.category!;
        }
      }
    }
    return "Category Not Found";
  }

  Future<void> createCategory() async {
    String? _uuid = firebaseFirestore.collection(CATEGORIES).doc().id;

    CategoryModel _newCategory = CategoryModel(
        cUID: _uuid,
        category: categoryTitleController.text,
        isDeleted: false,
        createdBy: firebaseAuth.currentUser!.uid,
        createdDate: Timestamp.now());

    await firebaseFirestore
        .collection(CATEGORIES)
        .doc(_uuid)
        .set(_newCategory.toJson())
        .then((value) => {
              categoryTitleController.clear(),
              Get.back(),
              AppConstant.displaySuccessSnackBar(
                  "Category alert!", 'Category was added!')
            });
  }

  Stream<List<CategoryModel>> getAllCategories() {
    return firebaseFirestore
        .collection(CATEGORIES)
        .where(CategoryModel.IS_DELETED, isEqualTo: false)
        .snapshots()
        .map((event) => event.docs
            .map((e) =>
                e.exists ? CategoryModel.fromMap(e.data()) : CategoryModel())
            .toList());
  }

  Future<void> updateCategory(CategoryModel category) async {
    await firebaseFirestore
        .collection(CATEGORIES)
        .doc(category.cUID!)
        .update(category.toJson())
        .whenComplete(() => {print("Category is updated!"), Get.back()});
  }

  Future<void> deleteCategory(CategoryModel category) async {
    /*bool? isCategoryFound = false;
    for (QuestionModel element in qaController!.allQAList) {
      if (element.category!.contains(category.category!)) {
        isCategoryFound = true;
        break;
      }
    }
    if (isCategoryFound!) {
      Get.back();
      AppConstant.displaySnackBar("Deletion Warning!",
          "Category: ${category.category} Already in use!");
      return;
    }*/

    await firebaseFirestore
        .collection(QA_COLLECTION)
        .where(QuestionModel.CATEGORY, isEqualTo: category.cUID)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) async {
        //doc.data()['${QuestionModel.CATEGORY}'] == category.cUID
        if (doc.exists) {
          Get.back();
          AppConstant.displaySnackBar("Deletion Warning!",
              "Category: ${category.category} Already in use!");
          return;
        } else {
          await firebaseFirestore
              .collection(CATEGORIES)
              .doc(category.cUID!)
              .update(category.toJson())
              .whenComplete(() => {print("Category is updated!"), Get.back()});
        }
      });
    });
  }
}
