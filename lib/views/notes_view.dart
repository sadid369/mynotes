import 'package:flutter/material.dart';
import 'package:mynotes/enums/menu_action.dart';
import 'package:mynotes/services/auth/auth_services.dart';
import 'package:mynotes/views/login_view.dart';

class NotesView extends StatefulWidget {
  static const routeName = "/notes/";

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                    child: Text('Logout'), value: MenuAction.logout),
              ];
            },
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthServices.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginView.routeName, (route) => false);
                  }
              }
            },
          )
        ],
      ),
      body: Text(
        "Hello World",
        style: TextStyle(color: Color.fromARGB(255, 47, 3, 179)),
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      // ignore: prefer_const_constructors
      return AlertDialog(
        title: const Text("Sign out"),
        content: const Text("Are you sure?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text("Log out"),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
