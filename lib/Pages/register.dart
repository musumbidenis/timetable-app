import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pop(context);
          },
          ),
      ),
    );
  }
}