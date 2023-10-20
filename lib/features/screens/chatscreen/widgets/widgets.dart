import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/provider/chat_provider.dart';
import 'package:firebase_chat_app/features/screens/chatscreen/chatscreen.dart';
import 'package:firebase_chat_app/features/screens/chatscreen/widgets/message_tile.dart';
import 'package:flutter/material.dart';

class ChatStream extends StatelessWidget {
  const ChatStream({
    super.key,
    required ChatProvider chatProvider,
    required this.widget,
    required FirebaseAuth instanceAuth,
  }) : _chatProvider = chatProvider, _instanceAuth = instanceAuth;

  final ChatProvider _chatProvider;
  final ChatScreen widget;
  final FirebaseAuth _instanceAuth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _chatProvider.getMessage(otheruserID: widget.receiverID,userID: _instanceAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: Text("Null"),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
              children: snapshot.data!.docs
                  .map((doc) => messageTile(document: doc))
                  .toList()),
        );
      },
    );
  }
}