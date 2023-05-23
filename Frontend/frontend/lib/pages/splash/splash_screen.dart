import 'dart:async';
import 'package:frontend/pages/dashboard/dashboard_screen.dart';
import 'package:frontend/pages/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isloggedIn = false;

  void checkLoginStatus() {
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
    Timer(const Duration(seconds: 3), () {
      if (isloggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: const Color.fromARGB(255, 15, 31, 65),
        color: Colors.orange,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              // Spacer(),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 100),
              //   child: SpinKitWave(
              //     color: Colors.white,
              //     itemCount: 30,
              //     size: 40,
              //     type: SpinKitWaveType.center,
              //   ),
              // ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text(
                  'Powered By DDC',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: ' Montserrat',
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
