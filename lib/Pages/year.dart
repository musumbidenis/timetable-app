import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flushbar/flushbar.dart';
import 'package:timetable/models/api.dart';
import 'package:timetable/Pages/home.dart';

class Year extends StatefulWidget {
  @override
  _YearState createState() => _YearState();
}

class _YearState extends State<Year> {
  String _year;
  List years = List();

/*Text Styling */
TextStyle style = TextStyle(fontFamily: "Montserrat", fontSize: 20.0);

  @override
  void initState() {
    super.initState();
    getYears();
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


/*getYears API */
void getYears() async{
  var response = await CallAPi().getData('getYears');
  var body = json.decode(response.body);
  setState(() {
    years = body;
  });
}

/*Dropdown button for choosing courses*/
Widget yearsDropdown(){
 return Container(
    padding: EdgeInsets.only(left: 20.0, right: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text("What's your current academic year of study?", style: style.copyWith(
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
          hint: Text("Select your academic year", style: style,),
          items: years.map((item){
            return DropdownMenuItem(
              child: Row(
                children: <Widget>[
                  Text("Academic year ", style: style,),
                  Text(item['year'].toString(), style: style,),
                ],
              ),
              value: item['yosId'].toString(),
            );
          }).toList(),
          onChanged: (value){
            setState(() {
              _year = value;
            });
          },
          value: _year,
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

/*Handles the pressed action of next button*/
void _handleProceed() async{
  if(_year == null){
    Flushbar(
      message: 'Please select academic year to proceed',
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
    )..show(context);
  }else{
  /*Move to the next page*/
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => Home(),
    ),);

  /*Save student's year of study in the localStorage*/
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('yearKey', _year);
  }
}

}