import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable/APIs/api.dart';

class TuesdaySession{
  
  final String unitCode;
  final String unitTitle;
  final String sessionStart;
  final String sessionStop;

  TuesdaySession(this.unitCode, this.unitTitle, this.sessionStart, this.sessionStop);

}


class SessionTuesday extends StatefulWidget {
  @override
  _SessionTuesdayState createState() => _SessionTuesdayState();
}

class _SessionTuesdayState extends State<SessionTuesday> {

  //Variables used to retreive sessions for the particular student//
  String course;
  int year;
  
  
  @override
  void initState() {
    this.gettuesdaySessions();
    super.initState();
  }

///Styling for texts///
TextStyle style = TextStyle(fontFamily: "Montserrat", fontSize: 20.0, fontWeight: FontWeight.bold);

  /////Fetch the sessions that occur on tuesday/////
  Future<List<TuesdaySession>> gettuesdaySessions() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    course = localStorage.getString('courseKey');
    year= localStorage.getInt('yearKey');
      var data = {
        'course': course,
        'year': year,      
      };
    var response = await CallAPi().postData(data, 'tuesdaySessions');
    var jsonData = json.decode(response.body);
  //Create a list array to store the fetched data//
  List<TuesdaySession> sessions = [];

  //Loop through the jsonData and add the items to the list array created//
  for(var s in jsonData){
    TuesdaySession tuesdaySession = TuesdaySession(
      s["unitCode"],s["unitTitle"],s["sessionStart"],s["sessionStop"],);

      sessions.add(tuesdaySession);
  }

  //Show the sessions//
  return sessions;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: gettuesdaySessions(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
              child: Text("No connection.Check your internet connection", style: TextStyle(color: Color(0xffe6020a),fontSize: 18, fontWeight: FontWeight.bold),),
            );
              break;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(height: 10.0,),
                      Text("Loading sessions",style: style,)
                    ],
                  ),
                ),
              );
              break;
            case ConnectionState.done:

          //Check whether data has been fetched//
          if(snapshot.hasError){
            return Center(
              child: Text("Some problem occurred.Check your internet connection and try again!", style: TextStyle(color: Color(0xffe6020a),fontSize: 16, fontWeight: FontWeight.bold),),
            );
          }else if(snapshot.hasData){
          //Display the sessions fetched in UI//
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index){
              return Container(
                height: 180.0,
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 12.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(snapshot.data[index].unitCode, style: TextStyle(color: Color(0xffe6020a),fontSize: 26, fontWeight: FontWeight.bold),),
                        Text(snapshot.data[index].unitTitle, style: TextStyle(color: Colors.black54,fontSize: 18),),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(snapshot.data[index].sessionStart, style: TextStyle(color: Colors.black54,fontSize: 15,fontWeight: FontWeight.bold),),
                            SizedBox(width: 20,),
                            Text("--", style: TextStyle(color: Colors.black54,fontSize: 15,fontWeight: FontWeight.bold),),
                            SizedBox(width: 20,),
                            Text(snapshot.data[index].sessionStop, style: TextStyle(color: Colors.black54,fontSize: 15,fontWeight: FontWeight.bold),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          );}
        } return Container();}
      )
    );
  }
}