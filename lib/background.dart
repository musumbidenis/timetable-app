import 'package:flutter/material.dart';

class Background extends StatelessWidget {

final screenHeight;

  const Background({Key key, this.screenHeight}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomShapeClipper(),
      child: Container(
        height: screenHeight * 0.3,
        color: Color(0xff01A0C7),
      ),
    );
  }
}

class BottomShapeClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset curveStartPoint = Offset(0, size.height * 0.65);
    Offset curveEndPoint = Offset(size.width, size.height * 0.65);
    path.lineTo(curveStartPoint.dx, curveEndPoint.dy);
    path.quadraticBezierTo(size.width/2, size.height, curveEndPoint.dx, curveStartPoint.dy);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper){
    return true;
  }
}