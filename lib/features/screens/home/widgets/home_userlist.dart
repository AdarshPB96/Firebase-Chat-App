import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/screens/chatscreen/chatscreen.dart';
import 'package:flutter/material.dart';

StreamBuilder<QuerySnapshot<Map<String, dynamic>>> homeUsersList() {
  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection('users').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      var users = snapshot.data?.docs;
      if (users == null || users.isEmpty) {
        return const Center(child: Text("No users found."));
      }

      return ListView.separated(
        itemBuilder: (context, index) {
          var userData = users[index].data();
          String userID = users[index].id;
          // String otherUseremail = userData["email"];
          return userData["email"] != FirebaseAuth.instance.currentUser!.email
              ? ListTile(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                              receiverID: userID,
                              userData: userData,
                              currentUserEmail: FirebaseAuth
                                  .instance.currentUser!.email
                                  .toString()),
                        ));
                  },
                  leading: const CircleAvatar(
                    radius: 20,
                  ),
                  title: Text(userData?["username"] ?? ""),
                )
              : const SizedBox();
        },
        separatorBuilder: (context, index) {
          var userData = users[index].data();
          return userData["email"] != FirebaseAuth.instance.currentUser!.email
              ? const Divider(
                  thickness: 2,
                )
              : const SizedBox();
        },
        itemCount: users.length,
      );
    },
  );
}
