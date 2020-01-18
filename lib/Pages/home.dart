import 'package:flutter/material.dart';
import 'package:timetable/Sessions/mondaySession.dart';
import 'package:timetable/Sessions/tuesdaySession.dart';
import 'package:timetable/background.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

///Styling for texts///
TextStyle style = TextStyle(fontFamily: "Montserrat", fontSize: 20.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //Background//
          Background(screenHeight: MediaQuery.of(context).size.height,),

          //Headings for the hompage//
          Padding(
            padding: const EdgeInsets.only(top: 50.0,left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Timetable",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold, color: Color(0x99FFFFFF)),),
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Icon(Icons.search, size: 30, color: Colors.white,),
                      ),
                    ],
                  ),
                  Text("Sessions", style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold, color: Color(0XFFFFFFFF)),),
                ],
            ),
          ),

          //TabBar appears here//
          Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: Container(
              height: 75,
              child: getTabBar()
            ),
          ),

          //TabBar pages appear here//
          Padding(
            padding: const EdgeInsets.only(top: 210.0),
            child: Container(
              child: getTabBarPages(),
            ),
          ),
        ],), 
    );
  }


////////////TabBar widget/////////////
 Widget getTabBar() {
  return TabBar(
    isScrollable: true,
    controller: tabController,
    unselectedLabelColor: Colors.white,
    labelStyle: style,
    indicatorSize: TabBarIndicatorSize.label,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Color(0xffe6020a),
    ),

    /////Tabs for the days/////
    tabs: [
    //Monday//
      Container(
        width: 150,
        child: Tab(
          child: Align(
            alignment: Alignment.center,
            child: Text("Monday", style: TextStyle(fontSize: 24),),
          ),
        ),
      ),

      //Tuesday//
      Tab(
        child: Container(
          width: 150,
        child: Align(
          alignment: Alignment.center,
          child: Text("Tuesday", style: TextStyle(fontSize: 24),),
        ),
       ),
      ),

      //Wednesday//
      Tab(
        child: Container(
          width: 150,
        child: Align(
          alignment: Alignment.center,
          child: Text("Wednesday", style: TextStyle(fontSize: 24),),
        ),
       ),
      ),

      //Thursday//
      Tab(
        child: Container(
          width: 150,
        child: Align(
          alignment: Alignment.center,
          child: Text("Thursday", style: TextStyle(fontSize: 24),),
        ),
       ),
      ),

      //Friday//
      Tab(
        child: Container(
          width: 150,
        child: Align(
          alignment: Alignment.center,
          child: Text("Friday", style: TextStyle(fontSize: 24),),
        ),
       ),
      ),
    ]);
  }


/////////////Pages to display for each tab///////////////
Widget getTabBarPages() {
  return Padding(
    padding: const EdgeInsets.only(top: 40),
    child: TabBarView(
      controller: tabController,
      children: <Widget>[
        SessionMonday(),
        SessionTuesday(),
        Container(color: Colors.black),
        Container(color: Colors.orange),
        Container(color: Colors.yellow),
      ]),
  );
 }
}
