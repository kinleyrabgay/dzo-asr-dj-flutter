import 'package:frontend/pages/dashboard/dashboard_screen.dart';
import 'package:frontend/provider/color.dart';
import 'package:frontend/provider/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EnglishState()),
        ChangeNotifierProvider(create: (_) => ColorModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "DASR",
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color.fromARGB(255, 15, 31, 65),
        fontFamily: 'Roboto',
      ),
      home: const DashboardScreen(),
    );
  }
}
