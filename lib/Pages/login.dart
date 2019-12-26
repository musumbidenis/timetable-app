
import 'package:flutter/material.dart';
import 'package:timetable/Pages/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

TextStyle style = TextStyle(fontFamily: "Montserrat", fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final hero = CircleAvatar(
      child: Image.asset("assets/hero.png"),
      radius: 70.0,
    );

    final emailField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: "admission number",
      border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: "id number",
      border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () {},
      child: Text("Login",
      textAlign: TextAlign.center,
      style: style.copyWith(
      color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    final registerlabel = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Dont have an account?", style: TextStyle(color: Colors.black54),),
        SizedBox(width: 10.0),
        GestureDetector(
          child: Text("Register", style: TextStyle(fontWeight: FontWeight.bold),),
          onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Register()));
          },
        ),
      ],
    );

  return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
    child: Container(
    child: Padding(
    padding: const EdgeInsets.all(36.0),
    child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
          hero,
        SizedBox(height: 25.0),
          emailField,
        SizedBox(height: 25.0),
          passwordField,
        SizedBox(height: 35.0),
          loginButon,
        SizedBox(height: 15.0),
        registerlabel,
      ],
    ),
  ),
),),),);
  }
}