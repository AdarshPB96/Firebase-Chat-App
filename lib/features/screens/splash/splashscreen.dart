import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/screens/home/home_screen.dart';
import 'package:firebase_chat_app/features/screens/login/loginscreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => StreamBuilder<User?>(
                stream: _auth.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    if (snapshot.hasData) {
                      return const HomeScreen();
                    } else {
                      return const LoginScreen();
                    }
                  }
                },
              )));
    });
    return const Scaffold(
        body: Center(
      child: Text(
        "Hello",
        style: TextStyle(fontSize: 20),
      ),
    ));
  }
}
