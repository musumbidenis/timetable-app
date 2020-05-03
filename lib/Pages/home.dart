import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable/models/api.dart';
import 'package:timetable/Pages/course.dart';
import 'package:timetable/models/session.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 5);
    tabController.addListener(_handleTabSelection);
    getSessions();
  }

  _handleTabSelection() {
    setState(() {
      _currentIndex = tabController.index;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

/*Variables used to retreive sessions for the particular student*/
  String course;
  String year;

/*Styling for texts*/
  TextStyle style = TextStyle(fontFamily: "Montserrat", fontSize: 20.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Timetable',
          style: style.copyWith(fontSize:27),
        ),
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
          child: Icon(
          Icons.keyboard_arrow_left,
          size: 40.0,
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return PlatformAlertDialog(
                      title: Text(''),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text("Are you sure, you want to exit app?", style: style,)
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        PlatformDialogAction(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        PlatformDialogAction(
                          child: Text('Ok'),
                          actionType: ActionType.Preferred,
                          onPressed: () async {
                            /*Remove the student details from localstorage */
                            SharedPreferences localStorage = await SharedPreferences.getInstance();
                            localStorage.remove('courseKey');
                            localStorage.remove('yearKey');

                            /*Navigate to the selecting course page */
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Course()),);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            child: Icon(
              Icons.exit_to_app,
              size: 30.0,
            ),
          )
        ),
      ],
      bottom: getTabBar(),
      ),
      body: Container(
        child: Stack(children: <Widget>[
          getTabBarPages(),
        ]),
      ),
    );
  }

  Widget session() {
    return Container(
        child: FutureBuilder(
          future: getSessions(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10.0),
                  child: Center(
                    child: Text(
                      "No connection.Check your internet connection",
                      style: TextStyle(
                      color: Color(0xffe6020a),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                    ),
                  ),
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
                        Text(
                          "Loading sessions",
                          style: style,
                        )
                      ],
                    ),
                  ),
                );
              break;
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10.0),
                    child: Center(
                      child: Text(
                        "Some problem occurred.Check your internet connection and try again!",
                        style: TextStyle(
                        color: Color(0xffe6020a),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                } else if (snapshot.hasData == null) {
                  return Text("data");
                }else{
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: MediaQuery.of(context).size.height* 0.25,
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      elevation: 18.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              snapshot.data[index].unitCode,
                              style: TextStyle(
                              color: Color(0xffe6020a),
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                            ),
                            Text(
                              snapshot.data[index].unitTitle,
                              style: TextStyle(
                              color: Colors.black54, fontSize: 18),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment:  MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  snapshot.data[index].sessionStart,
                                  style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "--",
                                  style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  snapshot.data[index].sessionStop,
                                  style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              );
            }
          }
          return Container();
        },
      ),
    );
  }


  /*Fetch the sessions that occur on monday*/
  Future<List<Session>> getSessions() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    course = localStorage.getString('courseKey');
    year = localStorage.getString('yearKey');
    var data = {
      'course': course,
      'year': year,
      'dayId': _currentIndex + 1,
    };
    var response = await CallAPi().postData(data, 'sessions');
    var jsonData = json.decode(response.body);

    /*Create a list array to store the fetched data*/
    List<Session> sessions = [];

    /*Loop through the jsonData and add the items to the list array created*/
    for (var s in jsonData) {
      Session session = Session(
        s["unitCode"],
        s["unitTitle"],
        s["sessionStart"],
        s["sessionStop"],
      );

      sessions.add(session);
    }

    /*Return the sessions*/
    return sessions;
    
  }



  /*Tab Bar*/
  Widget getTabBar() {
    return TabBar(
        isScrollable: true,
        controller: tabController,
        unselectedLabelColor: Colors.white,
        labelStyle: style,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Tab(
            child: Container(
              width: 120,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Monday",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              width: 120,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Tuesday",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              width: 130,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Wednesday",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              width: 120,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Thursday",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              width: 120,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Friday",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ]);
  }




/*Tab Bar Pages*/
  Widget getTabBarPages() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10),
      child: TabBarView(controller: tabController, children: <Widget>[
          session(),
          session(),
          session(),
          session(),
          session(),
      ],),
    );
    
  }
}
