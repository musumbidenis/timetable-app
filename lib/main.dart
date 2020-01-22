import 'package:flutter/material.dart';
import 'package:timetable/Pages/course.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timetable app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Course(),
    );
  }
}
