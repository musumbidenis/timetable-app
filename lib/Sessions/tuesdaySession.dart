import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
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

  /////Fetch the sessions that occur on monday/////
  Future<List<TuesdaySession>> getTuesdaySessions() async{
    var response = await CallAPi().getData('tuesdaySessions');
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
        future: getTuesdaySessions(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Check whether data has been fetched//
          if(snapshot.data == null){
            return Center(
              child: Text("Loading..."),
            );
          }else{
          
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
        }
      )
    );
  }
}