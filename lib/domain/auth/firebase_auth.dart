import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/features/screens/home/home_screen.dart';
import 'package:firebase_chat_app/features/screens/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Firebaseauth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController logInUserEmailController = TextEditingController();
  TextEditingController logInPasswordController = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;

  signUp() async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Fluttertoast.showToast(msg: "Successfully Registered");
      addUser();
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  addUser() async {
    db.collection("users").doc(auth.currentUser!.uid).set(
        {"username": usernameController.text, "email": emailController.text});
  }

  logIn(context) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: logInUserEmailController.text,
          password: logInPasswordController.text);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ));
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(msg: "Invalid details");
    }
  }

  signOut(context) async {
    await auth.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
