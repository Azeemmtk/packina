import 'package:flutter/cupertino.dart';

class WaveClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0, size.height-150);
    var firstStart= Offset(size.width / 3, size.height-200);
    var firstEnd= Offset(size.width / 2, size.height-100);
    path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart= Offset(size.width / 1.5, size.height);
    var secondEnd= Offset(size.width, size.height-50);
    path.quadraticBezierTo(secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
