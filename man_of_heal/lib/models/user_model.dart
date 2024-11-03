//User Model

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "uid";
  static const NAME = "name";
  static const TYPE = "userType";
  static const PHONE = "phone";
  static const EMAIL = "email";
  static const RATING = "rating";
  static const PHOTO_URL = "photo_url";
  static const DEGREE_PROGRAM = "degree_program";
  static const ADDRESS = "address";
  static const CREATED_DATE = "createDateTime";
  static const TRAIL_EXPIRY_DATE = "trailExpiryDateTime";
  static const IS_ADMIN = "isAdmin";
  static const IS_DELETED = "isDeleted";
  static const IS_TRAIL_FINISH = "isTrailFinished";
  static const USER_TOKEN = "userToken";

  String? uid, userToken;
  String? email;
  String? name, userType;
  String? phone;
  String? photoUrl;
  bool? isAdmin;
  bool? isDeleted;
  String? degreeProgram;
  String? address;
  Timestamp? createdDate;
  num? ratings;

  bool? isTrailFinished;
  Timestamp? trialExpiryDate;

  UserModel(
      {this.uid,
      this.userToken,
      this.email,
      this.name,
      this.userType,
      this.phone,
      this.ratings = 0.0,
      this.isAdmin = false,
      this.isDeleted = false,
      this.isTrailFinished = false,
      this.photoUrl = "https://cdn-icons-png.flaticon.com/512/3011/3011270.png",
      this.degreeProgram,
      this.address,
      this.trialExpiryDate,
      this.createdDate});

  factory UserModel.fromMap(Map<String, dynamic>? data) {
    return UserModel(
      uid: data![ID],
      userToken: data[USER_TOKEN] ?? "Deleted User",
      email: data[EMAIL],
      name: data[NAME] ?? 'Deleted User',
      userType: data[TYPE],
      phone: data[PHONE],
      photoUrl: data[PHOTO_URL] ??
          "https://cdn-icons-png.flaticon.com/512/3011/3011270.png",
      isAdmin: data[IS_ADMIN] ?? false,
      ratings: data[RATING],
      isDeleted: data[IS_DELETED],
      isTrailFinished: data[IS_TRAIL_FINISH],
      degreeProgram: data[DEGREE_PROGRAM] ?? '',
      address: data[ADDRESS] ?? '',
      createdDate: data[CREATED_DATE] ?? null,
      trialExpiryDate: data[TRAIL_EXPIRY_DATE] ?? null,
    );
  }

  factory UserModel.fromDoc(Object? data) {
    // print('Student User: before $data');
    Map<String, dynamic> map = data as Map<String, dynamic>;

    //print('Student User:after $map');
    return UserModel.fromMap(map);
  }

  Map<String, dynamic> toJson() => {
        ID: uid,
        USER_TOKEN: userToken,
        EMAIL: email,
        NAME: name,
        PHONE: phone,
        PHOTO_URL: photoUrl,
        IS_ADMIN: isAdmin,
        RATING: ratings,
        IS_DELETED: isDeleted,
        IS_TRAIL_FINISH: isTrailFinished,
        DEGREE_PROGRAM: degreeProgram,
        ADDRESS: address,
        TYPE: userType,
        CREATED_DATE: createdDate,
        TRAIL_EXPIRY_DATE: trialExpiryDate
      };
}

enum UserGroup { superAdmin, admin, instructor, student }
