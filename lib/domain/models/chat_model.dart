import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String message;
  String receiverid;
  String senderid;
  String senderemail;

  Timestamp timestamp;
  Message(
      {required this.message,
      required this.timestamp,
      required this.receiverid,
      required this.senderid,
      required this.senderemail});
  Map<String, dynamic> toMap() {
    return {
      "message": message,
      "timestamp": timestamp,
      "receiverid": receiverid,
      "senderid": senderid,
      "senderemail" :senderemail
    };
  }
}
