import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  static const CAT_ID = "cuid";
  static const CATEGORY = "category";
  static const CREATED_DATE = "createdDate";
  static const CREATED_BY = "createdBy";

  String? cUID;
  String? category;
  Timestamp? createdDate;
  String? createdBy;

  Category({this.cUID, this.category, this.createdDate, this.createdBy});

  factory Category.fromMap(Map<String, dynamic> data) {
    return Category(
        cUID: data[CAT_ID],
        category: data[CATEGORY],
        createdDate: data[CREATED_DATE] ?? '',
        createdBy: data[CREATED_BY]);
  }

  Map<String, dynamic> toJson() => {
        CAT_ID: cUID,
        CATEGORY: category,
        CREATED_DATE: createdDate,
        CREATED_BY: createdBy
      };
}
