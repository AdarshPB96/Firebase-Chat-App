import 'package:firebase_chat_app/domain/auth/firebase_auth.dart';
import 'package:flutter/material.dart';

AppBar appbar(Firebaseauth auth, BuildContext context) {
  return AppBar(
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return alertDialogLogout(auth, context);
                },
              );
            },
            icon: const Icon(Icons.logout)),
      ),
    ],
    title: const Text(
      "Home",
    ),
    centerTitle: true,
  );
}

AlertDialog alertDialogLogout(Firebaseauth auth, BuildContext context) {
  return AlertDialog(
    title: const Text("Do you want to Logout ?"),
    actions: [
      TextButton(
          onPressed: () {
            auth.signOut(context);
          },
          child: const Text("Yes")),
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("No"))
    ],
  );
}

