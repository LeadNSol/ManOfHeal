import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  static const fUID = "uid";
  static const fAdminID = "adminId";
  static const fStudentID = "studentId";
  static const fRating = "ratings";
  static const fRemarks = "remarks";
  static const fDate = "dateTime";

  String? uid, adminId, studentId, remarks;
  Timestamp? dateTime;
  double? ratings;

  FeedbackModel(
      {
      this.adminId,
      this.studentId,
      this.remarks,
      this.dateTime,
      this.ratings});

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
        //uid: map[fUID],
        adminId: map[fAdminID],
        studentId: map[fStudentID],
        remarks: map[fRemarks],
        dateTime: map[fDate],
        ratings: map[fRating]);
  }

  Map<String, dynamic> toMap() => {
        //fUID: uid,
        fAdminID: adminId,
        fStudentID: studentId,
        fRemarks: remarks,
        fDate: dateTime,
        fRating: ratings,
      };
}
