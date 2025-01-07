import 'package:flutter/material.dart';

class CustomHeading extends StatelessWidget {
  final String label;
  const CustomHeading({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontFamily: "PlayfairDisplay",
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
      textAlign: TextAlign.center,
    );
    ;
  }
}
