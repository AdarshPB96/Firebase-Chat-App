import 'package:firebase_chat_app/constants/size.dart';
import 'package:firebase_chat_app/domain/auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/provider/login_provider.dart';
import 'package:firebase_chat_app/features/screens/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInSCreen extends StatefulWidget {
  SignInSCreen({super.key});
  @override
  State<SignInSCreen> createState() => _SignInSCreenState();
}

class _SignInSCreenState extends State<SignInSCreen> {
  Firebaseauth auth = Firebaseauth();

  //  GlobalKey formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  const Text(
                    "Firebase Chat",
                    style: TextStyle(fontSize: 24),
                  ),
                  tSizedboxh40,
                  Text("SignUp"),
                  TextFormField(
                    controller: auth.usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Plese enter a name";
                      } else if (value.trim().split(" ").length < 2) {
                        return "Please enter full name";
                      } else if (value.trim().length < 4) {
                        return "Name must be at least 4 characters long";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "User Name",
                    ),
                  ),
                  tSizedboxh10,
                  TextFormField(
                    controller: auth.emailController,
                    validator: (value) {
                      if (value == null) {
                        return "Enter an email";
                      } else if (!value.contains("@")) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                  ),
                  tSizedboxh10,
                  Consumer<LogInPro>(
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: auth.passwordController,
                        obscureText: value.obscureText,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffix: IconButton(
                              onPressed: () {
                                value.toggleVisibility();
                              },
                              icon: Icon(value.obscureText == true
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          labelText: "Password",
                        ),
                      );
                    },
                  ),
                  tSizedboxh10,
                  Consumer<LogInPro>(
                    builder: (context, value, child) {
                      return TextFormField(
                        obscureText: value.obscureText,
                        controller: auth.confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Confirm Your Password";
                          }
                          // if (value != auth.passwordController) {
                          //   return "Incorrect Password";
                          // }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          suffix: IconButton(
                              onPressed: () {
                                value.toggleVisibility();
                              },
                              icon: Icon(value.obscureText == true
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                        ),
                      );
                    },
                  ),
                  tSizedboxh20,
                  signInbutton(formkey),
                  tSizedboxh10,
                  bottomRow(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton signInbutton(GlobalKey<FormState> formkey) {
    return ElevatedButton(
        onPressed: () {
          if (formkey.currentState!.validate()) {
            auth.signUp();
          }
        },
        child: const Text("SignIn"));
  }

  Row bottomRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("You already SignedUp ?"),
        InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
          },
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
