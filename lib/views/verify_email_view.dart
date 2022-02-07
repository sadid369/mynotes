// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_services.dart';
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
              await AuthServices.firebase().sendEmailVerification();
            },
            child: Text(
              "send email varification",
            ),
          ),
          TextButton(
            onPressed: () async {
              await AuthServices.firebase().logOut();
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
