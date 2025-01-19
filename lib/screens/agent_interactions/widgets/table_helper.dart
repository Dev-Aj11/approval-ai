import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Helper class for shared table components and styles
class TableHelper {
  /// Creates a preview button with customizable onPressed behavior
  static Widget buildPreviewBtn({
    required VoidCallback onPressed,
    String label = 'View Message',
  }) {
    return TextButton(
      style: getButtonStyle(),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(label),
          Transform.translate(
            offset: const Offset(0, 5),
            child: const Icon(
              Icons.chevron_right,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  /// Creates an estimate button with customizable onPressed behavior
  static Widget buildEstimateBtn({
    required VoidCallback onPressed,
    String label = 'View Document',
  }) {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextButton(
        style: getButtonStyle(),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(label),
            const SizedBox(width: 4),
            Transform.translate(
              offset: const Offset(0, 3),
              child: const Icon(
                Icons.open_in_new,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the common button style used across table buttons
  static ButtonStyle getButtonStyle() {
    return ButtonStyle(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      padding: WidgetStateProperty.all(EdgeInsets.zero),
      iconColor: WidgetStateProperty.all(Colors.black),
      foregroundColor: WidgetStateProperty.all(Colors.black),
      textStyle: WidgetStateProperty.all(
        GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Returns the header text style used in tables
  static TextStyle getHeaderStyle() {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }

  /// Returns the row text style used in tables
  static TextStyle getRowStyle() {
    return GoogleFonts.inter(
      fontSize: 14,
      color: const Color(0xff697282),
      fontWeight: FontWeight.w400,
    );
  }

  /// Returns the lender name text style used in tables
  static TextStyle getLenderNameStyle() {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }

  /// Checks if the current screen width is mobile-sized
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }
}

class TableConfig {
  static const Map<String, double> columnWidths = {
    'lender': 200,
    'status': 150,
    'lastContacted': 150,
    'messages': 100,
    'preview': 300,
    'estimate': 150,
  };

  static const Map<String, String> columnHeaders = {
    'lender': 'Lender',
    'status': 'Status',
    'lastContacted': 'Last Contacted',
    'messages': 'Messages',
    'preview': 'Preview',
    'estimate': 'Estimate',
  };

  static List<String> getColumnsForScreenSize(double width) {
    if (width > 1400) {
      return [
        'lender',
        'status',
        'lastContacted',
        'messages',
        'preview',
        'estimate'
      ];
    } else if (width >= 800) {
      return ['lender', 'status', 'preview', 'estimate'];
    } else {
      return ['lender', 'preview'];
    }
  }
}
