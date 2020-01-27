import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable/APIs/api.dart';
import 'package:timetable/Pages/home.dart';

class Year extends StatefulWidget {
  @override
  _YearState createState() => _YearState();
}

class _YearState extends State<Year> {

  int _year;

  List years = List();

///Styling for texts///
TextStyle style = TextStyle(fontFamily: "Montserrat", fontSize: 20.0);
  @override
  void initState() {
    super.initState();
    this.getYears();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top:120,left: 15,right: 15),
          child: SingleChildScrollView(
            child: yearsDropdown(),
          ),
        ),
      ),
    );
  }


////////////getYears API////////////
void getYears() async{
  var response = await CallAPi().getData('getYears');
  var body = json.decode(response.body);
  setState(() {
    years = body;
  });
}

////////////Dropdown button for choosing courses/////////////
Widget yearsDropdown(){
 return Container(
    padding: EdgeInsets.only(left: 20.0, right: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text("What's your current academic year of study?", style: style.copyWith(
          color: Color(0xff01A0C7),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        )),
        SizedBox(height: 28.0,),
        DropdownButton(
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 50,
          underline: Container(
            height: 3.0,
            color:  Color(0xff01A0C7),
          ),
          elevation: 10,
          hint: Text("Select your academic year", style: style,),
          items: years.map((item){
            return DropdownMenuItem(
              child: Row(
                children: <Widget>[
                  Text("Academic year ", style: style,),
                  Text(item['year'].toString(), style: style,),
                ],
              ),
              value: item['yosId'],
            );
          }).toList(),
          onChanged: (newVal){
            setState(() {
              _year = newVal;
            });
          },
          value: _year,
        ),
        SizedBox(height: 25.0,),

        /////Next button/////
        Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Material(
            borderRadius: BorderRadius.circular(30.0),
            color: Color(0xff01A0C7),
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: _handleProceed,      
              child: Text("Proceed",
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
void _handleProceed() async{
  //Move to the next page//
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => Home(),
    ),);

  //Save student's course in the localStorage//
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setInt('yearKey', _year);
}

}