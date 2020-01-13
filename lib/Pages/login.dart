
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:timetable/APIs/api.dart';
import 'package:timetable/Pages/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

TextEditingController admissionController = TextEditingController();
TextEditingController idController = TextEditingController();

TextStyle style = TextStyle(fontFamily: "Montserrat", fontSize: 20.0);

GlobalKey <FormState> _formKey = GlobalKey();

Widget loginForm(){
  return Column(
  children: <Widget>[
    CircleAvatar(
      child: Image.asset("assets/hero.png"),
      radius: 70.0,
    ),
    SizedBox(height: 25.0),
    TextFormField(
      controller: admissionController,
      obscureText: false,
      style: style,
      keyboardType: TextInputType.text,
      validator: (String value){
        if (value.isEmpty) {
          return "Admission number is required";
        }else if (value.length != 13){
          return "Admission number should contain 13 characters";
        }else{
          return null;
        }
      },
      decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: "admission number",
      border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    ),
    SizedBox(height: 15.0),
    TextFormField(
      controller: idController,
      obscureText: true,
      style: style,
      validator: (String value){
        if (value.isEmpty){
          return "Id number required";
        }else if(value.length != 8){
          return "Id number should contain 8 characters";
        }else{
          return null;
        }
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: "id number",
      border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    ),
    SizedBox(height: 25.0),
    Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: _handleLogin,     
      child: Text("Login",
      textAlign: TextAlign.center,
      style: style.copyWith(
        color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    ),
    SizedBox(height: 15.0),
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Dont have an account?", style: TextStyle(color: Colors.black54),),
        SizedBox(width: 10.0),
        GestureDetector(
          child: Text("Register", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff01A0C7),),),
          onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Register()));
          },
        ),
      ], 
    ),
  ],);
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(36, 0, 36, 0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: loginForm(),
            )
          ),
        ),
      ),
    ),
  );
}

void _handleLogin() async{
  var form = _formKey.currentState;
  if (form.validate()){
    form.save();
  
  var data = {
    'admission': admissionController.text,
    'idNumber': idController.text,
  };

  var response = await CallAPi().postData(data,'login');
  var body = json.decode(response.body);
  print(body);
  }
}
}