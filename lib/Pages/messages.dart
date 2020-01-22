import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SnackBar(
          content: Text("error"),
          action: SnackBarAction(
            label: 'cancel',
            onPressed: (){},
          ),
        ),
      ),
    );
  }
}