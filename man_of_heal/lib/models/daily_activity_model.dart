import 'package:cloud_firestore/cloud_firestore.dart';

class DailyActivityModel {

  static const DA_UID = "daID";
  static const TERM_OF_DAY = "tod";
  static const QUESTION_OF_DAY = "qod";
  static const CREATED_BY = "createdBy";
  static const CREATED_DATE = "createdDate";

  String? daUID;
  String? termOfDay;
  String? qOfDay;
  String? createdBy;
  Timestamp? createdDate;

  DailyActivityModel(
      {this.daUID,
      this.termOfDay = '',
      this.qOfDay = '',
      this.createdBy,
      this.createdDate});

  factory DailyActivityModel.fromDoc(DocumentSnapshot? snap) {
    //print('Student User: before $data');
    if(snap!.exists) {
      Map<String, dynamic> map = snap.data() as Map<String, dynamic>;
      return DailyActivityModel.fromMap(map);
    }else
      return DailyActivityModel();
  }

  factory DailyActivityModel.fromMap(Map<String, dynamic> map){
    return DailyActivityModel(
      daUID: map[DA_UID],
      termOfDay: map[TERM_OF_DAY],
      qOfDay: map[QUESTION_OF_DAY],
      createdBy: map[CREATED_BY],
      createdDate: map[CREATED_DATE] ?? null
    );
  }

  Map<String, dynamic> toJson()=>{
    DA_UID: this.daUID,
    TERM_OF_DAY: this.termOfDay,
    QUESTION_OF_DAY: this.qOfDay,
    CREATED_DATE: this.createdDate,
    CREATED_BY: this.createdBy
  };
}
