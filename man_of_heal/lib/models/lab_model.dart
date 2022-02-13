import 'package:cloud_firestore/cloud_firestore.dart';

class LabModel {
  static const L_UID = "lUID";
  static const TITLE = "title";
  static const SHORT_DESCRIPTION = "shortDescription";
  static const LONG_DESCRIPTION = "longDescription";
  static const CREATED_DATE = "createdDate";
  static const ADMIN_ID = "adminId";
  static const ADMIN_NAME = "adminName";
  static const IMAGE_URL = "imageUrl";

  String? lUID;
  String? title;
  String? shortDescription;
  String? longDescription;
  Timestamp? createdDate;
  String? adminId;
  String? adminName;
  String? imageIconUrl;

  LabModel(
      {this.lUID,
      this.title,
      this.shortDescription,
      this.longDescription,
      this.createdDate,
      this.adminId,
      this.adminName,
      this.imageIconUrl});

  factory LabModel.fromMap(Map<String, dynamic> map) {
    return LabModel(
        lUID: map[L_UID],
        title: map[TITLE],
        shortDescription: map[SHORT_DESCRIPTION],
        longDescription: map[LONG_DESCRIPTION],
        createdDate: map[CREATED_DATE],
        adminId: map[ADMIN_ID],
        adminName: map[ADMIN_NAME],
        imageIconUrl: map[IMAGE_URL]);
  }

  Map<String, dynamic> toJson() => {
        L_UID: this.lUID,
        TITLE: this.title,
        SHORT_DESCRIPTION: this.shortDescription,
        LONG_DESCRIPTION: this.longDescription,
        CREATED_DATE: this.createdDate,
        ADMIN_ID: this.adminId,
        ADMIN_NAME: this.adminName,
        IMAGE_URL: this.imageIconUrl
      };
}
