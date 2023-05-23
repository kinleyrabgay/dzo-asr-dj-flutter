// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_interpolation_to_compose_strings
import 'package:frontend/pages/canvas/bottom_login.dart';
import 'package:frontend/pages/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import '../../api/userapi.dart';
import '../canvas/top.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoggedIn = false;
  var username = TextEditingController();
  var passwordController = TextEditingController();

  void updateStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isloggedIn', true);
    await prefs.setString('username', username.text);
  }

  @override
  void dispose() {
    username.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildEmail() {
      return Container(
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter username";
            }
            return null;
          },
          controller: username,
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.person,
            ),
            hintText: 'Username',
          ),
        ),
      );
    }

    Widget buildPassword() {
      return Container(
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter your password";
            }
            return null;
          },
          controller: passwordController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.lock_outline_rounded,
              ),
              hintText: 'Password'),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              // flex: 1,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 390,
                    child: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, 100),
                      painter: TopArcPainterTop(),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          CustomPaint(
                            size: Size(MediaQuery.of(context).size.width, 350),
                            painter: TopArcPainterBottomLogin(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            child: Column(
                              children: [
                                const SizedBox(height: 140),
                                buildEmail(),
                                const SizedBox(height: 10),
                                buildPassword(),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final user = username.text;
                                      final password = passwordController.text;

                                      UserService().login(user, password).then(
                                        (value) async {
                                          print(value['message']);
                                          if (value['message'] == 'success') {
                                            updateStatus();
                                            print('After');
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const DashboardScreen(),
                                              ),
                                              (route) => false,
                                            );
                                          }
                                        },
                                      );
                                    },
                                    child: const Text(
                                      'LOGIN',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
