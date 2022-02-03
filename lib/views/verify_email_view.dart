// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/views/register_view.dart';

class VerifyEmailView extends StatefulWidget {
  static const routeName = "/veryfyEmailView";

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verified Email View"),
      ),
      body: Column(
        children: [
          Text(
            "We've sent you an email verification. Please open it to verify your account",
          ),
          Text(
            "if haven't received a verification email yet, press the button below",
          ),
          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user!.sendEmailVerification();
            },
            child: Text(
              "send email varification",
            ),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  RegisterView.routeName, (route) => false);
            },
            child: Text("Restart"),
          ),
        ],
      ),
    );
  }
}
