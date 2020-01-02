import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
GlobalKey <FormState> _formKey = GlobalKey();

TextStyle style = TextStyle(fontFamily: "Montserrat", fontSize: 20.0);

TextEditingController admissionController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController idController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController courseController = TextEditingController();
TextEditingController yosController = TextEditingController();

String admission = "";
String name = "";
String email = "";
String idNumber = "";
String phone = "";
String course = "";
String yos = "";

  @override
Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text("REGISTER")),
        backgroundColor: Color(0xff01A0C7),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(36.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: registerForm(),
            ),
          ),
        ),
      ),
    );
  }
Widget registerForm(){
  return Column(
    children: <Widget>[
      CircleAvatar(
        child: Image.asset("assets/hero.png"),
        radius: 70.0,
      ),
      SizedBox(height: 25.0),
      TextFormField(
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
        obscureText: false,
        style: style,
        keyboardType: TextInputType.text,
        validator: (String value){
          if (value.isEmpty) {
            return "Full name is required";
          }else{
            return null;
          }
        },
        decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "full name",
        border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        ),
      SizedBox(height: 15.0),
      TextFormField(
        obscureText: false,
        style: style,
        keyboardType: TextInputType.emailAddress,
        validator: (String value){
          if (value.isEmpty) {
            return "email address is required";
          }else{
            return null;
          }
        },
        decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "email address",
        border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        ),
      SizedBox(height: 15.0),
      TextFormField(
        obscureText: false,
        style: style,
        keyboardType: TextInputType.number,
        validator: (String value){
          if (value.isEmpty) {
            return "phone number is required";
          }else{
            return null;
          }
        },
        decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "phone number",
        border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        ),
      SizedBox(height: 15.0),
      TextFormField(
        obscureText: false,
        style: style,
        keyboardType: TextInputType.number,
        validator: (String value){
          if (value.isEmpty) {
            return "id number is required";
          }else{
            return null;
          }
        },
        decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "id number",
        border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        ),
      SizedBox(height: 15.0),
      TextFormField(
        obscureText: false,
        style: style,
        keyboardType: TextInputType.text,
        validator: (String value){
          if (value.isEmpty) {
            return "course studying is required";
          }else{
            return null;
          }
        },
        decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "course",
        border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        ),
      SizedBox(height: 15.0),
      TextFormField(
        obscureText: false,
        style: style,
        keyboardType: TextInputType.text,
        validator: (String value){
          if (value.isEmpty) {
            return "year of study is required";
          }else{
            return null;
          }
        },
        decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "year of study",
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
          onPressed: () {
            _formKey.currentState.validate();
          },      
          child: Text("Register",
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
          Text("Already have an account?", style: TextStyle(color: Colors.black54),),
          SizedBox(width: 10.0),
          GestureDetector(
            child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff01A0C7),),),
              onTap: () {
                Navigator.pop(context);
              },
          ),
        ], 
      ),
    ],
   );
  }
}