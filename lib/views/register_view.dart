import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'dart:developer' as devtools show log;

import 'package:mynotes/utilities/show_error_dialog.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/verify_email_view.dart';

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
      appBar: AppBar(
        title: Text("Register"),
      ),
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
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email, password: password);
                  final user = FirebaseAuth.instance.currentUser;
                  await user?.sendEmailVerification();
                  Navigator.of(context).pushNamed(VerifyEmailView.routeName);
                } on FirebaseAuthException catch (e) {
                  if (e.code == "weak-password") {
                    await showErrorDialog(context, "Weak Password");
                  } else if (e.code == "email-already-in-use") {
                    await showErrorDialog(context, "Email Already In Use");
                  } else if (e.code == "invalid-email") {
                    await showErrorDialog(context, "Invalid Email");
                  } else {
                    await showErrorDialog(
                      context,
                      "Error: ${e.code}",
                    );
                  }
                } catch (e) {
                  await showErrorDialog(
                    context,
                    "Error: ${e.toString()}",
                  );
                }
              },
              child: const Text("Registration")),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginView.routeName, (route) => false);
            },
            child: const Text("Already Registered!, Go to Login "),
          ),
        ],
      ),
    );
  }
}
