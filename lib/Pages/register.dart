import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:timetable/APIs/api.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

String _course;
int _year;

List courses = List();
List years = List();

bool _isLoading = false;

GlobalKey <FormState> _formKey = GlobalKey();

///Styling for texts///
TextStyle style = TextStyle(fontFamily: "Montserrat", fontSize: 20.0);

///Text Controllers///
TextEditingController admissionController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController idController = TextEditingController();
TextEditingController phoneController = TextEditingController();


  @override
  void initState() {
    super.initState();
    this.getCourses();
    this.getYears();
  }



Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
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




///////////Registration Form/////////////
Widget registerForm(){
  return Column(
    children: <Widget>[

      /////Avatar image/////
      CircleAvatar(
        child: Image.asset("assets/hero.png"),
        radius: 70.0,
      ),

      SizedBox(height: 25.0),

      /////Admission Number text field/////
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

      /////Name text field/////
      TextFormField(
        controller: nameController,
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

      /////Email text field/////
      TextFormField(
        controller: emailController,
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

      /////Phone Number text field/////
      TextFormField(
        controller: phoneController,
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

      /////Id Number text field/////
      TextFormField(
        controller: idController,
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

      /////Courses dropdown/////
      Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0),
            border: Border.all(),
          ),
        child: DropdownButton(
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 10,
          hint: Text("Select Course", style: style,),
          items: courses.map((item){
            return DropdownMenuItem(
              child: Text(item['courseTitle'], style: style,),
              value: item['courseCode'].toString(),
            );
          }).toList(),
          onChanged: (newVal){
            setState(() {
              _course = newVal;
            });
          },
          value: _course,
        ),
      ),

      SizedBox(height: 15.0),

      /////Academic years dropdown/////
      Container(
        padding: EdgeInsets.only(left: 20.0, right: 90.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0),
            border: Border.all(),
          ),
        child: DropdownButton(
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 10,
          hint: Text("Select Academic year", style: style,),
          items: years.map((item){
            return DropdownMenuItem(
              child: Row(
                children: <Widget>[
                  Text("Academic year ", style: style,),
                  Text(item['year'].toString(), style: style,),
                ],
              ),
          value: item['yosId'],
          );
          }).toList(),
          onChanged: (newVal){
            setState(() {
              _year = newVal;
            });
          },
          value: _year,
        ),
      ),

      SizedBox(height: 25.0),

      /////Registration button/////
      Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xff01A0C7),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: _handleRegister,      
          child: Text( _isLoading ? 'Registering ...': "Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
            color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),

      SizedBox(height: 15.0),

      /////Already have an account ---> Login()/////
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

////////////getCourses API////////////
void getCourses() async{
  var response = await CallAPi().getData('getCourses');
  var body = json.decode(response.body);
  setState(() {
    courses = body;
  });
}

////////////getYears API////////////
void getYears() async{
  var response = await CallAPi().getData('getYears');
  var body = json.decode(response.body);
  setState(() {
    years = body;
  });
}

////////////Handling user registration///////////
void _handleRegister() async{
  var form = _formKey.currentState;
  if (form.validate()){
    form.save();

  //User data to be pushed to db//
  var data = {
    'admission': admissionController.text,
    'name': nameController.text,
    'email': emailController.text,
    'idNumber': idController.text,
    'phone': phoneController.text,
    'course': _course,
    'year': _year
  };

  //Set the registration button to loading state//
  setState(() {
    _isLoading = true;
  });

  //Post user data to db via API//
  var response = await CallAPi().postData(data,'register');
  var body = json.decode(response.body);
  print(body);
  }

  //Return to login page
  Navigator.pop(context);
 }
}