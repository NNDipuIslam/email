// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

class custom extends StatelessWidget {
  final String name;
  const custom({required this.name});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: mycustomclipper(),
          child: Container(
            height: 150,
            color: Colors.blue,
          ),
        ),
        Positioned(
          top: 70, // Adjust this value to position the text vertically
          left: 220, // Adjust this value to position the text horizontally
          child: Text(
            'Available Domains',
            style: TextStyle(
              color: Colors.white, // Adjust text color as needed
              fontSize: 20, // Adjust font size as needed
              fontWeight: FontWeight.bold, // Adjust font weight as needed
            ),
          ),
        ),
      ],
    );
  }
}

class mycustomclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    path.lineTo(0, h);
    path.quadraticBezierTo(w * 0.7, h - 100, w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
