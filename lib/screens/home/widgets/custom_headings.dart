import 'package:approval_ai/screens/home/model/overview_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSubHeading extends StatelessWidget {
  final String label;
  const CustomSubHeading({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class CustomLenerDetails extends StatelessWidget {
  final IconData icon;
  final String lenderInfo;
  const CustomLenerDetails(
      {required this.icon, required this.lenderInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        SizedBox(width: 6),
        Text(lenderInfo),
      ],
    );
  }
}

class LenderHeading extends StatelessWidget {
  final String lenderName;
  const LenderHeading({required this.lenderName, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      lenderName,
      style: GoogleFonts.playfairDisplay(
          fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

class LenderImg extends StatelessWidget {
  final String lenderImg;
  const LenderImg({required this.lenderImg, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 91,
      width: 154,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(lenderImg, fit: BoxFit.cover),
      ),
    );
  }
}

class LenderStatusBadge extends StatelessWidget {
  final List<LenderStatusEnum> type;
  const LenderStatusBadge({
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = kMetricStyles[type.first]!;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        style.lenderLabel,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
            color: style.foregroundColor,
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
