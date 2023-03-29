// matching various patterns for kinds of data
import 'package:get/get.dart';

class Validator {
  Validator();

  String? email(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!.trim()))
      return 'Invalid Email Format';
    else
      return null;
  }

  String? password(String? value) {
    String pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'Password must be at least 6 characters.';
    else
      return null;
  }

  String? name(String? value) {
    String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!.trim()))
      return 'Name Required';
    else
      return null;
  }

  String? question(String? value) {
    String pattern = r"^\d+(?:\.\d+)?$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!.trim()))
      return "Invalid question format";
    else
      return null;
  }

  String? number(String? value) {
    // String pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    String pattern = r'(^(?:[+0]9)?[0-9]{11,12}$)';

    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!.trim()))
      return 'Invalid phone number format';
    else
      return null;
  }

  String? amount(String? value) {
    String pattern = r'^\d+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'validator.amount'.tr;
    else
      return null;
  }

  String? notEmpty(String? value) {
    //String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    //String pattern = r'/^(?!\s*$).+/';
    // String pattern = "/(.|\s)*\S(.|\s)*/gm";
    //RegExp regex = RegExp(pattern);
    // if (!regex.hasMatch(value!.trim())) {
    if (value == null || value.isEmpty) {
      return 'This is required!';
    } else {
      return null;
    }
  }
}
