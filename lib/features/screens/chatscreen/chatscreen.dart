import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/provider/chat_provider.dart';
import 'package:firebase_chat_app/features/screens/chatscreen/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  final String currentUserEmail;
  final String receiverID;

  const ChatScreen({required this.userData, required this.currentUserEmail,required this.receiverID});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatProvider _chatProvider = ChatProvider();
  final FirebaseAuth _instanceAuth = FirebaseAuth.instance;
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatProvider.sendMessage(
          receiverID: widget.receiverID,
          message: _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatAppbar(),
      body: Column(
        children: [
          Expanded(
            child: ChatStream(chatProvider: _chatProvider, widget: widget, instanceAuth: _instanceAuth),
          ),
          const Divider(),
          Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _messageController,
                      decoration:
                          const InputDecoration(labelText: 'Type a message'),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar chatAppbar() {
    return AppBar(
      title: Text(widget.userData['username']),
    );
  }
}



