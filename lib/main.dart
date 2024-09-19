import 'package:autism_project/signup.dart';
import 'package:flutter/material.dart';
import 'dayspage.dart';
import 'games.dart';
import 'home.dart';
import 'levels.dart';
import 'login.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Autism Learning Assistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => HomePage(),
        '/levels': (context) => LevelsPage(),
        '/games': (context) => GamesPage(),

        // Level and day routes
        '/level1': (context) => DayPage(level: 1, day: 1),
        '/level2': (context) => DayPage(level: 2, day: 1),
        '/level3': (context) => DayPage(level: 3, day: 1),
        // Extend with more routes for days if needed
      },
    );
  }
}
