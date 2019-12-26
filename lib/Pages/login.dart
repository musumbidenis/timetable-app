import 'package:flutter/material.dart';
import 'package:timetable/Pages/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {

      final emailField = TextField(
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        );
      final passwordField = TextField(
        obscureText: true,
        style: style,
        decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        );

      final loginButon = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xff01A0C7),
        child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => Register()));
        },
        child: Text("Login",
        textAlign: TextAlign.center,
        style: style.copyWith(
          color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Login page"),
      ),
      body: Center(
      child: Container(
      color: Colors.white,
      child: Padding(
      padding: const EdgeInsets.all(36.0),
      child: SingleChildScrollView(
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 155.0,
              child: Image.asset(
                "assets/logo.png",
              fit: BoxFit.contain,
            ),
           ),
            SizedBox(height: 45.0),
              emailField,
            SizedBox(height: 25.0),
              passwordField,
            SizedBox(
              height: 35.0,
            ),
              loginButon,
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
      ),
      ),
      ),
      );
      }
}