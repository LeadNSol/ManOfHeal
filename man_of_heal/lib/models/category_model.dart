import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  static const CAT_ID = "cUid";
  static const CATEGORY = "category";
  static const CREATED_DATE = "createdDate";
  static const CREATED_BY = "createdBy";
  static const IS_DELETED = "isDeleted";

  String? cUID;
  String? category;
  Timestamp? createdDate;
  bool? isDeleted;
  String? createdBy;

  CategoryModel(
      {this.cUID,
      this.category,
      this.createdDate,
      this.createdBy,
      this.isDeleted = false});

  factory CategoryModel.fromMap(Map<String, dynamic> data) {
    return CategoryModel(
        cUID: data[CAT_ID],
        isDeleted: data[IS_DELETED],
        category: data[CATEGORY],
        createdDate: data[CREATED_DATE] ?? '',
        createdBy: data[CREATED_BY]);
  }

  Map<String, dynamic> toJson() => {
        CAT_ID: cUID,
        CATEGORY: category,
        IS_DELETED: isDeleted,
        CREATED_DATE: createdDate,
        CREATED_BY: createdBy
      };
}
