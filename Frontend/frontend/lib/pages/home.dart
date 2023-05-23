import 'package:frontend/pages/prize.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/record.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'help.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    Help(),
    Record(),
    Prize()
  ];

  bool isloggedIn = false;
  String username = "";

  void checkLoginStatus() {
    // Code to check if user is logged in or not
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getBool('isloggedIn') ?? false) {
        setState(() {
          isloggedIn = true;
          username = prefs.getString('username') ?? "there";
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
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.help),
              label: 'Help',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: 'Prizes',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF5ACFC9),
          iconSize: 26,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
