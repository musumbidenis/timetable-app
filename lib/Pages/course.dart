import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable/models/api.dart';
import 'package:timetable/Pages/year.dart';

class Course extends StatefulWidget {
  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<Course> {
  String _course;
  List courses = List();

/*Text Styling */
TextStyle style = TextStyle(fontFamily: "Montserrat", fontSize: 20.0);


  @override
  void initState() {
    super.initState();
    getCourses();
  }

  @override
  Widget build(BuildContext context) {
  SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(builder: (context){
        return Center(
        child: Padding(
          padding: const EdgeInsets.only(top:120,left: 15,right: 15),
          child: SingleChildScrollView(
            child: coursesDropdown(),
          ),
        ),
      );
      })
    );
  }


/*getCourses API*/
void getCourses() async{
  var response = await CallAPi().getData('getCourses');
  var body = json.decode(response.body);
  setState(() {
    courses = body;
  });
}

/*Dropdown button for choosing courses*/
Widget coursesDropdown(){
 return Container(
    padding: EdgeInsets.only(left: 20.0, right: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text("Which course are you undertaking?", style: style.copyWith(
          color: Colors.green,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        )),
        SizedBox(height: 28.0,),
        DropdownButton(
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 50,
          underline: Container(
            height: 3.0,
            color:  Colors.green,
          ),
          elevation: 10,
          hint: Text("Select course undertaking", style: style,),
          items: courses.map((item){
            return DropdownMenuItem(
              child: Text(item['courseTitle'], style: style.copyWith(
                fontSize: 17,
              ),),
              value: item['courseCode'].toString(),
            );
          }).toList(),
          onChanged: (newVal){
            setState(() {
              _course = newVal;
            });
          },
          value: _course,
        ),
        SizedBox(height: 25.0,),

        /*Next Button */
        Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Material(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.green,
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: _handleNext,      
              child: Text("Next",
                textAlign: TextAlign.center,
                style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ],
    ),
  );
}

/*Handles the pressed action of next button*/
void _handleNext() async{
  if(_course == null){
    Flushbar(
      message: 'Please select course to proceed',
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
    )..show(context);
  }else{
  /*Move to the next page*/
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => Year()
    ),);

  /*Save student's course in the localStorage*/
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('courseKey', _course);
  }}
}