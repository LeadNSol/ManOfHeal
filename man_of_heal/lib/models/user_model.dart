//User Model

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "uid";
  static const NAME = "name";
  static const PHONE = "phone";
  static const EMAIL = "email";
  static const PHOTO_URL = "photo_url";
  static const DEGREE_PROGRAM = "degree_program";
  static const ADDRESS = "address";
  static const CREATED_DATE = "createDateTime";
  static const IS_ADMIN = "isAdmin";

  String? uid;
  String? email;
  String? name;
  String? phone;
  String? photoUrl;
  bool? isAdmin;
  String? degreeProgram;
  String? address;
  Timestamp? createdDate;

  UserModel(
      {this.uid,
      this.email,
      this.name,
      this.phone,
      this.isAdmin,
      this.degreeProgram,
      this.address,
      this.createdDate});

/*  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot.data()[NAME];
    email = snapshot.data()[EMAIL];
    uid = snapshot.data()[ID];
    photoUrl = snapshot.data()[PHOTO_URL];
  }*/

  factory UserModel.fromMap(Map<String, dynamic>? data) {
    return UserModel(
      uid: data![ID],
      email: data[EMAIL],
      name: data[NAME] ?? '',
      phone: data[PHONE],
      isAdmin: data[IS_ADMIN] ?? false,
      degreeProgram: data[DEGREE_PROGRAM] ?? '',
      address: data[ADDRESS] ?? '',
      createdDate: data[CREATED_DATE] ?? null,
    );
  }

  factory UserModel.fromDoc(Object? data) {
    print('Student User: before $data');
    Map<String, dynamic> map = data as Map<String, dynamic>;

    print('Student User:after $map');
    return UserModel.fromMap(map);
  }

  Map<String, dynamic> toJson() => {
        ID: uid,
        EMAIL: email,
        NAME: name,
        PHONE: phone,
        IS_ADMIN: isAdmin,
        DEGREE_PROGRAM: degreeProgram,
        ADDRESS: address,
        CREATED_DATE: createdDate
      };


}
