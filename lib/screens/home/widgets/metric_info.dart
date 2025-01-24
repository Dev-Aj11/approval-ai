import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MetricInfo extends StatelessWidget {
  final String data;
  final String metricName;
  final bool centerData;
  final bool isMoney;
  const MetricInfo(
      {required this.data,
      required this.metricName,
      this.centerData = false,
      this.isMoney = false,
      super.key});

  String _formatMoney(String data) {
    final value = int.parse(data.replaceAll(",", ""));
    return '\$${(value).toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          centerData ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          isMoney ? _formatMoney(data) : data,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          metricName,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
