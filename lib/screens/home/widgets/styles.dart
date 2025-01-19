// styles.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardStyles {
  static BoxDecoration getDesktopStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: Color(0xffD9D9D9),
        width: 1,
      ),
    );
  }

  static TextStyle getLenderNameStyle() {
    return GoogleFonts.playfairDisplay(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle getMetricStyle() {
    return GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );
  }
}
