import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showDialog(
    context: context,
    builder: (context) {
      // ignore: prefer_const_constructors
      return AlertDialog(
        title: const Text("An Error Occurred"),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("ok"),
          ),
        ],
      );
    },
  );
}
