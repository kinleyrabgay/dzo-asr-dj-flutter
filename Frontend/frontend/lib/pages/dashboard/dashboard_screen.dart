// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:frontend/pages/about/about.dart';
import 'package:frontend/pages/components/app_bar_title.dart';
import 'package:frontend/pages/rulebook/rule_book.dart';
import 'package:frontend/provider/color.dart';
import 'package:frontend/provider/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../pages/home.dart';
import '../login/welcome.dart';
import '../model/try_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class DashboardScreen extends StatefulWidget implements PreferredSizeWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 75);
}

class _DashboardScreenState extends State<DashboardScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    // Recroding
    Widget firstCard() {
      return Container(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: const DecorationImage(
            image: AssetImage('assets/img/record_card.png'),
            fit: BoxFit.cover,
          ),
          boxShadow: const [
            BoxShadow(
              spreadRadius: 0,
              blurRadius: 0.5,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Audio Recording',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Take a time to record audio for better model',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextButton(
                      onPressed: () {
                        if (isloggedIn) {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const Home(),
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(1.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        } else {
                          // Navigate to login screen when user is not logged in
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WelcomePage(),
                            ),
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'See more',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 255, 105, 105),
                            ),
                            padding: const EdgeInsets.all(1),
                            child: const Icon(Icons.chevron_right,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
          ],
        ),
      );
    }

    // Model
    Widget secondCard() {
      return Container(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: const DecorationImage(
            image: AssetImage('assets/img/try_card.png'),
            fit: BoxFit.cover,
          ),
          boxShadow: const [
            BoxShadow(
              spreadRadius: 0,
              blurRadius: 0.5,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Try our model',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'We appreciate for your time and feedbacks',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    // const Home(),
                                    const TryModel(),
                            //         ModelTest(
                            //   onStop: (String path) {},
                            // ),
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = const Offset(1.0, 0.0);
                              var end = Offset.zero;
                              var curve = Curves.ease;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'See more',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 255, 105, 105),
                            ),
                            padding: const EdgeInsets.all(1),
                            child: const Icon(Icons.chevron_right,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
          ],
        ),
      );
    }

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final englishState = Provider.of<EnglishState>(context);
    final colorModel = Provider.of<ColorModel>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: widget.preferredSize,
        child: AppBar(
          backgroundColor: Provider.of<ColorModel>(context).selectedColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.menu_outlined,
              color: Colors.white,
              // size: 28,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          title: const AppBarTitle(),
          bottom: PreferredSize(
            preferredSize: widget.preferredSize,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.blue,
                      color: const Color.fromARGB(255, 80, 79, 79)
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            englishState.isEnglishSelected
                                ? 'Record audio and get a chance to win prize'
                                : 'གློག་རྩེ་བཟུང་མི་རུང་ལུ་བརྟེན་པའི་ཁ་དངག་བཀོད་པ',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                          Container(
                            width: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color.fromARGB(255, 80, 79, 79)
                                    .withOpacity(0.5)),
                            child: IconButton(
                              iconSize: 24,
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (isloggedIn) {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          const Home(),
                                      transitionDuration:
                                          const Duration(milliseconds: 500),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var begin = const Offset(1.0, 0.0);
                                        var end = Offset.zero;
                                        var curve = Curves.ease;

                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));

                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  // Navigate to login screen when user is not logged in
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const WelcomePage(),
                                    ),
                                  );
                                }
                              },
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
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    firstCard(),
                    const SizedBox(height: 20),
                    secondCard()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                        bottom: BorderSide(width: 0, color: Colors.transparent),
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/img/dashboard_drawer.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(),
                  ),
                  ListTile(
                    leading: const Icon(Icons.verified_user_outlined),
                    title: Text(
                      englishState.isEnglishSelected
                          ? 'Researcher'
                          : 'ཞིབ་འཚོལ་པ་།',
                      style: const TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const AboutPage(),
                          transitionDuration: const Duration(milliseconds: 500),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = const Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;
                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const Divider(
                    color: Colors.black12,
                    indent: 20,
                  ),
                  ListTile(
                    leading: const Icon(Icons.rule),
                    title: Text(
                        englishState.isEnglishSelected
                            ? 'Rule'
                            : 'ཁྲིམས་ལུགས་།',
                        style: const TextStyle(fontSize: 16)),
                    onTap: () {
                      // Add your onTap action here
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const RulebookScreen(),
                          transitionDuration: const Duration(milliseconds: 500),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = const Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;
                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const Divider(
                    color: Colors.black12,
                    indent: 20,
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.format_color_fill_sharp),
                        title: Text(
                          englishState.isEnglishSelected
                              ? 'Color'
                              : 'སྐབས་ཀྱི་བ',
                          style: const TextStyle(fontSize: 16),
                        ),
                        onTap: () {
                          // Add your onTap action here
                        },
                      ),
                      // Color custome color picker should go here
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => colorModel.updateColorPreference(
                                  const Color(0xFF0F1F41)),
                              child: Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0F1F41),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                      border: Border.all(
                                          color: colorModel.selectedColor ==
                                                  const Color(0xFF0F1F41)
                                              ? Colors.white
                                              : Colors.transparent),
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  if (colorModel.selectedColor ==
                                      const Color(0xFF0F1F41))
                                    const Icon(
                                        CupertinoIcons
                                            .checkmark_alt_circle_fill,
                                        color: Color(0xFF5ACFC9),
                                        size: 20),
                                ],
                              ),
                            ),
                            const SizedBox(width: 30),
                            GestureDetector(
                              onTap: () => colorModel
                                  .updateColorPreference(Colors.orange),
                              child: Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                      color: Colors.orange,
                                      border: Border.all(
                                          color: colorModel.selectedColor ==
                                                  Colors.orange
                                              ? Colors.black38
                                              : Colors.transparent),
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  if (colorModel.selectedColor == Colors.orange)
                                    const Icon(
                                        CupertinoIcons
                                            .checkmark_alt_circle_fill,
                                        color: Color(0xFF5ACFC9),
                                        size: 20),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.black12, indent: 20),
                  ListTile(
                    leading:
                        const Icon(Icons.power_settings_new, color: Colors.red),
                    title: Text(
                        englishState.isEnglishSelected
                            ? 'Sign Out'
                            : 'ཡིག་རྟགས་བཀོད།',
                        style: const TextStyle(fontSize: 16)),
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      // Remove the login status to SharedPreferences
                      await prefs.remove('username');
                      await prefs.remove('isloggedIn');
                      // call SystemNavigator.pop to exit the app
                      SystemNavigator.pop();
                    },
                  ),
                  const Divider(color: Colors.black12, indent: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
