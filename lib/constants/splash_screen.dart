import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:timetable/Pages/home.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigate);
  }

  void navigate() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
    void dispose(){
      startTime();
      super.dispose();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
          child: Container(
            height: 300,
            width: 200,
            child: Image(image: AssetImage('assets/denis.png')),
          ),
        ),
        bottomSheet: Container(
          height: 50,
          color: Colors.white,
          width: double.infinity,
          child: Center(
            child: RichText(
              text: TextSpan(
                  text: "Designed & Developed by | ",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  children: <TextSpan>[
                    TextSpan(
                        text: "musumbidenis",
                        style:
                            TextStyle(color: Colors.green, fontSize: 12),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            if (await canLaunch("http://musumbidenis.co.ke")) {
                              await launch("http://musumbidenis.co.ke");
                            }
                          })
                  ]),
            ),
          ),
        ));
  }
}