import 'package:firebase_chat_app/domain/auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/screens/home/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Firebaseauth auth = Firebaseauth();
    return SafeArea(
      child: Scaffold(
          appBar: appbar(auth, context),
          body: const Column(
            children: [
              Expanded(
                child: HomeListview(),
              ),
            ],
          )),
    );
  }


}

