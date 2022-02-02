import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'dart:developer' as devtools show log;

class RegisterView extends StatefulWidget {
  static const routeName = "/register/";

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            controller: _email,
            decoration:
                const InputDecoration(hintText: "Enter Your Email Address"),
          ),
          TextField(
            obscureText: true,
            controller: _password,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: "Enter Your Password"),
          ),
          TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  final userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email, password: password);
                  devtools.log(userCredential.toString());
                } on FirebaseAuthException catch (e) {
                  if (e.code == "weak-password") {
                    devtools.log("weak password");
                  } else if (e.code == "email-already-in-use") {
                    devtools.log("Email Already in Use");
                  } else if (e.code == "invalid-email") {
                    devtools.log("Invalid Email");
                  }
                }
              },
              child: const Text("Registration")),
          TextButton(
            onPressed: () {},
            child: const Text("Already Registered!, Go to Login "),
          ),
        ],
      ),
    );
  }
}
