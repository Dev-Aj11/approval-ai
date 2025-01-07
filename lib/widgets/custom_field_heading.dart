import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFieldHeading extends StatelessWidget {
  final String label;
  const CustomFieldHeading({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
