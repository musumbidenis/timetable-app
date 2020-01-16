import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
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

  Future<List<MondaySession>> getMondaySessions() async{
    var response = await CallAPi().getData('mondaySessions');
    var jsonData = json.decode(response.body);

  List<MondaySession> sessions = [];

  for(var s in jsonData){
    MondaySession mondaySession = MondaySession(
      s["unitCode"],s["unitTitle"],s["sessionStart"],s["sessionStop"],);

      sessions.add(mondaySession);

  }
  print(jsonData);
  return sessions;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getMondaySessions(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.data == null){
            return Center(
              child: Text("Loading..."),
            );
          }else{
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index){
              return Container(
                height: 170.0,
                child: Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                elevation: 12.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                            Text(snapshot.data[index].unitCode, style: TextStyle(color: Color(0xffe6020a),fontSize: 26, fontWeight: FontWeight.bold),),
                            Text(snapshot.data[index].unitTitle, style: TextStyle(color: Colors.black54,fontSize: 17),),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(snapshot.data[index].sessionStart),
                                SizedBox(width: 20,),
                                Text(snapshot.data[index].sessionStop),
                              ],
                            )
                          ],),
                ),
            ),
              );
          });
          }
        })
      );
  }
}