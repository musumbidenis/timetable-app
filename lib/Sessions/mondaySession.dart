import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable/APIs/api.dart';

class MondaySession{
  
  final String unitCode;
  final String unitTitle;
  final String sessionStart;
  final String sessionStop;

  MondaySession(this.unitCode, this.unitTitle, this.sessionStart, this.sessionStop);

}


class SessionMonday extends StatefulWidget {
  @override
  _SessionMondayState createState() => _SessionMondayState();
}

class _SessionMondayState extends State<SessionMonday> {

  //Variables used to retreive sessions for the particular student//
  String course;
  int year;
  
  
  @override
  void initState() {
    this.getMondaySessions();
    super.initState();
  }



  /////Fetch the sessions that occur on monday/////
  Future<List<MondaySession>> getMondaySessions() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    course = localStorage.getString('courseKey');
    year= localStorage.getInt('yearKey');
      var data = {
        'course': course,
        'year': year,      
      };
    var response = await CallAPi().postData(data, 'mondaySessions');
    var jsonData = json.decode(response.body);
    print(jsonData);
  //Create a list array to store the fetched data//
  List<MondaySession> sessions = [];

  //Loop through the jsonData and add the items to the list array created//
  for(var s in jsonData){
    MondaySession mondaySession = MondaySession(
      s["unitCode"],s["unitTitle"],s["sessionStart"],s["sessionStop"],);

      sessions.add(mondaySession);
  }

  //Show the sessions//
  return sessions;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getMondaySessions(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return Center(
              child: Text("Loading . . .", style: TextStyle(color: Color(0xffe6020a),fontSize: 26, fontWeight: FontWeight.bold),),
            );
              break;
            case ConnectionState.waiting:
              return Center(
              child: Text("Loading . . .", style: TextStyle(color: Color(0xffe6020a),fontSize: 26, fontWeight: FontWeight.bold),),
            );
            case ConnectionState.none:
              return Center(
              child: Text("No connection.Check your internet connection", style: TextStyle(color: Color(0xffe6020a),fontSize: 26, fontWeight: FontWeight.bold),),
            );
            case ConnectionState.done:

          //Check whether data has been fetched//
          if(snapshot.hasError){
            return Center(
              child: Text("No connection.Check your internet connection", style: TextStyle(color: Color(0xffe6020a),fontSize: 26, fontWeight: FontWeight.bold),),
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
                            Text(snapshot.data[index].sessionStart, style: TextStyle(color: Colors.black54,fontSize: 17,fontWeight: FontWeight.bold),),
                            SizedBox(width: 20,),
                            Text("---", style: TextStyle(color: Colors.black54,fontSize: 17,fontWeight: FontWeight.bold),),
                            SizedBox(width: 20,),
                            Text(snapshot.data[index].sessionStop, style: TextStyle(color: Colors.black54,fontSize: 17,fontWeight: FontWeight.bold),),
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