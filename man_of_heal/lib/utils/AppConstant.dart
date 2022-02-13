import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class AppConstant {
  AppConstant._();

  static int getSecondsFromNowOnwardDate(Timestamp? timestamp) {
    DateTime dateTime =
        DateTime.fromMicrosecondsSinceEpoch(timestamp!.microsecondsSinceEpoch);
    return dateTime.difference(new DateTime.now()).inSeconds;
  }

 static String convertToFormattedDataTime(String customFormat,Timestamp timestamp) {
    var date =
    DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);

    return DateFormat(customFormat).format(date);
  }


 /* String _convertAgoDate(Timestamp? timestamp) {
    *//*final timeAgoFromNow =
        new DateTime.now().subtract(new Duration());*//*

    DateTime dateTime =
    DateTime.fromMicrosecondsSinceEpoch(timestamp!.microsecondsSinceEpoch);
    final timeAgoFromNow =
    new DateTime.now().subtract(new DateTime.now().difference(dateTime));

    initialTime!.value =
        new DateTime.now().difference(timeAgoFromNow).inSeconds;
    print(
        'Time ago: $timeAgoFromNow new: ${new DateTime.now().difference(timeAgoFromNow).inSeconds}');
    return timeAgo.format(timeAgoFromNow);
  }

  int _convertFromNowDate(Timestamp? timestamp) {
    DateTime dateTime =
    DateTime.fromMillisecondsSinceEpoch(timestamp!.microsecondsSinceEpoch);
    final timeAheadFromNow =
    new DateTime.now().add(dateTime.difference(new DateTime.now()));
    //print('Time ahead from now: ${timeAgo.format(timeAheadFromNow)}');
    int seconds = dateTime.difference(new DateTime.now()).inSeconds;

    // print('Time ahead from now: ${dateTime.subtract(new DateTime.now()).inSeconds)}');
    print('total seconds: ${dateTime.toLocal()}');
    print('total seconds: ${timestamp.seconds}');
    print('total seconds: ${seconds}');
    return seconds;
  }

  int secondsBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours * 3600).round();
  }*/
}
