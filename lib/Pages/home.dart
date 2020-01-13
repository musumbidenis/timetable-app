import 'package:flutter/material.dart';
import 'package:timetable/background.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(screenHeight: MediaQuery.of(context).size.height,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                ],                
              ),
            ),
        ],),
    );
  }
}