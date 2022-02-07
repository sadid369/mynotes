import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_services.dart';

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
                  await AuthServices.firebase()
                      .createUser(email: email, password: password);

                  final user = AuthServices.firebase().currentUser;
                  await AuthServices.firebase().sendEmailVerification();
                  Navigator.of(context).pushNamed(VerifyEmailView.routeName);
                } on WeakPasswordAuthException {
                  await showErrorDialog(context, "Weak Password");
                } on EmailAlreadyInUseAuthException {
                  await showErrorDialog(context, "Email Already In Use");
                } on InvalidEmailAuthException {
                  await showErrorDialog(context, "Invalid Email");
                } on GenericAuthException {
                  await showErrorDialog(
                    context,
                    "Failed to Register",
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
