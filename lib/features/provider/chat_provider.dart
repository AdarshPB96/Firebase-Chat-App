import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/domain/models/chat_model.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final FirebaseAuth instanceAuth = FirebaseAuth.instance;
  FirebaseFirestore instanceFirestore = FirebaseFirestore.instance;

  Future<void> sendMessage({
    required String receiverID,
    required String message,
  }) async {
    final String currentUserEmail = instanceAuth.currentUser!.email.toString();
    final String currentuserID = instanceAuth.currentUser!.uid;

    List<String> ids = [currentuserID, receiverID];
    ids.sort();
    String chatID = ids.join("_");
    Message newMessage = Message(
        senderemail: currentUserEmail,
        message: message,
        timestamp: Timestamp.now(),
        receiverid: receiverID,
        senderid: currentuserID);

    await instanceFirestore
        .collection("chat")
        .doc(chatID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage({required String userID, required String otheruserID}) {
    final String currentUserEmail = instanceAuth.currentUser!.email.toString();
    // String chatID = "${currentUserEmail}_$receiverEmail";
    List<String> ids = [userID, otheruserID];
    ids.sort();
    String chatID = ids.join("_");

    return instanceFirestore
        .collection("chat")
        .doc(chatID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
