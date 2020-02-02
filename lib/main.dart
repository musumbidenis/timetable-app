import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable/Pages/course.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLoggedIn = false;


  @override
  void initState(){
    _checkIfLoggedIn();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timetable app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _isLoggedIn ? Course() : Course(),
    );
  }

  //Check if user is logged in//
  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var course = localStorage.getString('courseKey');
    var year = localStorage.getInt('yearKey');

    //If !=null remain logged in//
    if(course!=null && year!=null){
      setState(() {
        _isLoggedIn = true;
      });
    }
  }
}
