import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpansionTileHelper {
  static Border getBorderStyle(bool isCollapsed) {
    if (isCollapsed) {
      return Border(top: BorderSide(color: Colors.grey[300]!, width: 1));
    } else {
      return Border(top: BorderSide(color: Colors.grey[600]!, width: 1));
    }
  }

  static Widget buildExpansionTileHeader(
      {required IconData icon, required String title}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  static bool isMoneyMetric(String metric) {
    List<String> moneyMetrics = [
      "Lender Payments",
      "Total Payments",
      "Total Savings",
      "Monthly Payment",
      "Principal Paid Off",
      "Initial Total Payments",
      "Negotiated Total Payments"
    ];
    return moneyMetrics.contains(metric);
  }
}
