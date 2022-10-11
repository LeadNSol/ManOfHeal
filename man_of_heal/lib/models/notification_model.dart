import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  static final nUID = "uId";
  static final nTitle = "title";
  static final nBody = "body";
  static final nType = "type";
  static final nSenderName = "senderName";
  static final nReceiverToken = "receiverToken";
  static final nReceiverID = "receiverID";
  static final nIsRead = "isRead";
  static final nSentTime = "sentTime";

  String? uID, title, body, type;
  // type is used for to navigate to specific page
  String? senderToken, senderName;
  String? receiverToken, receiverId;
  bool? isTopicBased, isRead;
  Timestamp? sentTime;

  NotificationModel(
      {this.uID,
      this.title,
      this.isTopicBased,
      this.body,
      this.type,
      this.isRead = false,
      this.senderToken,
      this.senderName,
        this.sentTime,
        this.receiverId,
      this.receiverToken});

  factory NotificationModel.fromMap(Map<String, dynamic> data) {
    return NotificationModel(
      uID: data[nUID],
      title: data[nTitle],
      body: data[nBody],
      type: data[nType],
      receiverToken: data[nReceiverToken],
      isRead: data[nIsRead],
      senderName: data[nSenderName],
      sentTime: data[nSentTime],
      receiverId: data[nReceiverID]
    );
  }

  Map<String, dynamic> toMap() => {
        nUID: uID,
        nTitle: title,
        nBody: body,
        nType: type,
        nSenderName: senderName,
        nIsRead: isRead,
        nReceiverToken: receiverToken,
        nSentTime: sentTime,
        nReceiverID: receiverId,
      };
}
