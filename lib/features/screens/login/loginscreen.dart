import 'package:firebase_chat_app/constants/size.dart';
import 'package:firebase_chat_app/domain/auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/provider/login_provider.dart';
import 'package:firebase_chat_app/features/screens/login/widgets/widgets.dart';
import 'package:firebase_chat_app/features/signIn/signIn_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Firebaseauth auth = Firebaseauth();
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "Firebase Chat",
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              tSizedboxh40,
              const Text("User LogIn"),
              TextfieldWidget(
                  controller: auth.logInUserEmailController, text: "Email"),
              Consumer<LogInPro>(
                builder: (context, value, child) => TextField(
                  controller: auth.logInPasswordController,
                  obscureText: value.obscureText,
                  style: const TextStyle(),
                  decoration: InputDecoration(
                      labelText: "Password",
                      suffix: IconButton(
                          onPressed: () {
                            value.toggleVisibility();
                          },
                          icon: Icon(value.obscureText == true
                              ? Icons.visibility
                              : Icons.visibility_off))),
                ),
              ),
              tSizedboxh20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        auth.logIn(context);
                      },
                      child: const Text("LogIn")),
                ],
              ),
              tSizedboxh10,
              const Text("You dont have an account?"),
              tSizedboxh10,
              InkWell(
                child: const Text(
                  "SignUp",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInSCreen(),
                      ));
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
