import 'package:flutter/material.dart';
import 'package:timetable/Sessions/mondaySession.dart';
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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff01A0C7),
        bottom: getTabBar(),
        ),
      body: Stack(
        children: <Widget>[
          Background(screenHeight: MediaQuery.of(context).size.height,),
          getTabBarPages()
        ],),
    );
  }

 Widget getTabBar() {
  return TabBar(
    isScrollable: true,
    controller: tabController,
    unselectedLabelColor: Colors.white,
    labelStyle: style,
    indicatorSize: TabBarIndicatorSize.label,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(18)),
      color: Colors.redAccent,
    ),
    tabs: [
      Tab(
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        child: Align(
          alignment: Alignment.center,
          child: Text("Monday"),
        ),
       ),
      ),
      Tab(
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        child: Align(
          alignment: Alignment.center,
          child: Text("Tuesday"),
        ),
       ),
      ),
      Tab(
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        child: Align(
          alignment: Alignment.center,
          child: Text("Wednesday"),
        ),
       ),
      ),
      Tab(
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        child: Align(
          alignment: Alignment.center,
          child: Text("Thursday"),
        ),
       ),
      ),
      Tab(
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        child: Align(
          alignment: Alignment.center,
          child: Text("Friday"),
        ),
       ),
      ),
    ]);
  }

Widget getTabBarPages() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 70.0),
    child: TabBarView(
      controller: tabController,
      children: <Widget>[
        SessionMonday(),
        Container(color: Colors.green),
        Container(color: Colors.black),
        Container(color: Colors.orange),
        Container(color: Colors.yellow),
      ]),
  );
 }
}
