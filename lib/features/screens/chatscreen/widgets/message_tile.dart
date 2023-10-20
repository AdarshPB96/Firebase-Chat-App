import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget messageTile({required DocumentSnapshot document}) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  var alignment = (data["senderid"] == FirebaseAuth.instance.currentUser!.uid)
      ? Alignment.centerRight
      : Alignment.centerLeft;
  final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  DateTime timestamp = data["timestamp"].toDate();

  return Container(
    alignment: alignment,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            (data["senderid"] == FirebaseAuth.instance.currentUser!.uid)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
        mainAxisAlignment:
            (data["senderid"] == FirebaseAuth.instance.currentUser!.uid)
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
        children: [
          Text(
            data["message"],
            style: TextStyle(fontSize: 18),
          ),
          Text(
            dateFormat.format(timestamp),
            style: TextStyle(color: Colors.grey.withOpacity(0.6), fontSize: 11),
          )
        ],
      ),
    ),
  );
}
