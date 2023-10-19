 import 'package:firebase_chat_app/domain/auth/firebase_auth.dart';
import 'package:flutter/material.dart';

AppBar appbar(Firebaseauth auth, BuildContext context) {
    return AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    auth.signOut(context);
                  },
                  icon: Icon(Icons.logout)),
            ),
          ],
          title: const Text(
            "Home",
          ),
          centerTitle: true,
        );
  }


class HomeListview extends StatelessWidget {
  const HomeListview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              radius: 20,
            ),
            title: Text("User ${index + 1}"),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 2,
          );
        },
        itemCount: 20);
  }
}
