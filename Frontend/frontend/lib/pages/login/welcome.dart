import 'package:frontend/pages/login/login_screen.dart';
import 'package:frontend/pages/login/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../canvas/bottom.dart';
import '../canvas/center.dart';
import '../canvas/top.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              margin: const EdgeInsets.only(top: 1),
              child: FractionallySizedBox(
                widthFactor: 0.6,
                child: SvgPicture.asset("assets/svg/speech.svg"),
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 270,
                    child: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, 100),
                      painter: TopArcPainterTop(),
                    ),
                  ),
                  Positioned(
                    bottom: 170,
                    child: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, 100),
                      painter: TopArcPainterCenter(),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: Size(MediaQuery.of(context).size.width, 200),
                          painter: TopArcPainterBottom(),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 28),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                const LoginScreen(),
                                            transitionDuration: const Duration(
                                                milliseconds: 500),
                                            transitionsBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              var begin =
                                                  const Offset(1.0, 0.0);
                                              var end = Offset.zero;
                                              var curve = Curves.ease;
                                              var tween = Tween(
                                                      begin: begin, end: end)
                                                  .chain(
                                                      CurveTween(curve: curve));
                                              return SlideTransition(
                                                position:
                                                    animation.drive(tween),
                                                child: child,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'SIGN IN',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                const SignupScreen(),
                                            transitionDuration: const Duration(
                                                milliseconds: 500),
                                            transitionsBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              var begin =
                                                  const Offset(1.0, 0.0);
                                              var end = Offset.zero;
                                              var curve = Curves.ease;
                                              var tween = Tween(
                                                      begin: begin, end: end)
                                                  .chain(
                                                      CurveTween(curve: curve));
                                              return SlideTransition(
                                                position:
                                                    animation.drive(tween),
                                                child: child,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(200, 50),
                                        backgroundColor: Colors.white,
                                      ),
                                      child: const Text(
                                        'SIGN UP',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
