import 'package:flutter/material.dart';

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width -180, 0);
    path.quadraticBezierTo(
      size.width -120,
      0,
      size.width -120,
      60,
    );
    path.quadraticBezierTo(
      size.width -120,
      120,
      size.width -60,
      120,
    );
    path.quadraticBezierTo(
      size.width  ,
      120,
      size.width,
      180,
    );
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
      size.width,
      size.height - 60 ,
      size.width - 60,
      size.height -60,
    );
    path.lineTo(60, size.height -60);
     path.quadraticBezierTo(
      0,
      size.height - 60 ,
     0,
      size.height - 120,
    );
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
