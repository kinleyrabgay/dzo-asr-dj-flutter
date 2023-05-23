// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers

import 'package:frontend/api/userapi.dart';
import 'package:frontend/pages/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../canvas/bottom_signup.dart';
import '../canvas/top.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var nameController = TextEditingController();
  var passwordController = TextEditingController();

  var emailController = TextEditingController();
  var genderController = TextEditingController();

  var ageController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    ageController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void cache() async {
    print('Called cache');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isloggedIn', true);
    await prefs.setString('username', nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    Widget buildName() {
      return Container(
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter your name";
            }
            return null;
          },
          controller: nameController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.person_outline,
              ),
              hintText: 'Username'),
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

    Widget buildGender() {
      String? _selectedGender;
      return Container(
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter your gender";
            }
            return null;
          },
          value: _selectedGender,
          onChanged: (newValue) {
            setState(() {
              _selectedGender = newValue;
            });
          },
          items: [
            "Male",
            "Female",
            "Other",
          ].map((String gender) {
            return DropdownMenuItem(
              value: gender,
              child: Text(gender),
            );
          }).toList(),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.person_outline,
            ),
            hintText: 'Gender',
          ),

          // dropdownColor: Colors.black,
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      );
    }

    Widget buildAge() {
      return Container(
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter your age";
            }
            return null;
          },
          controller: ageController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.calendar_month_outlined,
              ),
              hintText: 'Age'),
        ),
      );
    }

    Widget buildPhone() {
      return Container(
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter your phone";
            }
            return null;
          },
          controller: phoneController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.phone_callback_outlined,
              ),
              hintText: 'Phone'),
        ),
      );
    }

    Widget buildEmail() {
      return Container(
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter correct email";
            }
            return null;
          },
          controller: emailController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.email_outlined,
              ),
              hintText: 'Email'),
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
                    bottom: 490,
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
                            size: Size(MediaQuery.of(context).size.width, 450),
                            painter: TopArcPainterBottomSignup(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // const SizedBox(height: 20),
                                buildName(),
                                const SizedBox(height: 10),
                                buildAge(),
                                const SizedBox(height: 10),
                                buildGender(),
                                const SizedBox(height: 10),
                                buildPhone(),
                                const SizedBox(height: 10),
                                buildEmail(),
                                const SizedBox(height: 10),
                                buildPassword(),

                                const SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      // Get the user details
                                      final username = nameController.text;
                                      final gender = genderController.text;
                                      final email = emailController.text;
                                      final age = ageController.text;
                                      final phoneNumber = phoneController.text;
                                      final password = passwordController.text;

                                      print("sdfasdf regioster user ");

                                      if (nameController.text.isNotEmpty &&
                                          genderController.text.isNotEmpty &&
                                          emailController.text.isNotEmpty &&
                                          ageController.text.isNotEmpty &&
                                          phoneController.text.isNotEmpty &&
                                          passwordController.text.isNotEmpty) {
                                        print('Got data');
                                        UserService()
                                            .register(
                                              username,
                                              password,
                                              email,
                                              gender,
                                              age,
                                              phoneNumber,
                                            )
                                            .then(
                                              (value) async => {
                                                print(
                                                  "success" + value.toString(),
                                                ),
                                                if (value["message"] ==
                                                    'success')
                                                  {
                                                    // Save flag to shared preferences
                                                    cache(),
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const DashboardScreen(),
                                                      ),
                                                    ),
                                                  },
                                              },
                                            );
                                      } else {
                                        //
                                        print('The data not send');
                                      }
                                      // ignore: todo
                                    },
                                    child: const Text(
                                      'SIGN UP',
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
