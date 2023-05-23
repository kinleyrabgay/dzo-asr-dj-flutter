// ignore_for_file: unused_field

import 'package:frontend/provider/language_toggle.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarTitle extends StatefulWidget {
  const AppBarTitle({Key? key}) : super(key: key);

  @override
  State<AppBarTitle> createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<AppBarTitle> {
  String _username = '';
  bool isloggedIn = false;

  void checkLoginStatus() {
    // Code to check if user is logged in or not
    // You can use a shared preference or a database to store the login status
    // For this example, I am assuming you are using shared preferences
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getBool('isloggedIn') ?? false) {
        setState(() {
          isloggedIn = true;
        });
      } else {
        setState(() {
          isloggedIn = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    _loadUsername();
  }

  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? '';
    setState(() {
      _username = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isloggedIn) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _username.isEmpty ? 'Hi There' : 'Hi $_username',
              style: const TextStyle(color: Colors.white),
            ),
            const LanguageToggle(),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Hi There',
              style: TextStyle(color: Colors.white),
            ),
            LanguageToggle(),
          ],
        ),
      );
    }
  }
}
