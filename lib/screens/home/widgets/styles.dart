// styles.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardStyles {
  static BoxDecoration getDesktopStyle() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Color(0xffdddddd),
        width: 1,
      ),
    );
  }

  static TextStyle getMetricStyle() {
    return GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );
  }

  static TextStyle getBoldMetricStyle() {
    return GoogleFonts.inter(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    );
  }
}
