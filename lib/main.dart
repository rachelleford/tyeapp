import 'package:business_course/chapter1/oneone.dart';
import 'package:business_course/chapter1/onetwo.dart';
import 'package:flutter/material.dart';
import 'intropage.dart';
import 'studentdashboard.dart';
import 'loginpage.dart';
import 'welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/welcome': (context) => Welcome(),
        '/student-dashboard': (context) => StudentDashboard(),
        '/oneone': (context) => OneOne(), // Add the new route
        '/onetwo': (context) => OneTwo()
      },
    );
  }
}
