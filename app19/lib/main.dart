import 'package:app19/screens/calendar.dart';
import 'package:app19/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:app19/screens/loginpage.dart';
import 'package:app19/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: 'login',
      routes: {
        'login': (context) => LoginPage(),
        'home': (context) => HomePage(),
        'calendar': (context) => Calendar(),
        'settings': (context) => Settings(),
      },
    );
  }
}
//commento alessia