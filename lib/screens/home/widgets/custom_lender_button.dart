import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLenderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPress;

  const CustomLenderButton({
    required this.label,
    required this.icon,
    required this.onPress,
    super.key,
  });

  // Handle border style based on state
  BorderSide _getBorderStyle(Set<WidgetState> states) {
    // if hovered return a border with thicnkess 2
    if (states.contains(WidgetState.hovered)) {
      return const BorderSide(
        color: Colors.black,
        width: 2,
      );
    }
    return BorderSide(color: Color(0xffD5D3D3));
  }

  // Get text style based on selection state
  TextStyle _getTextStyle() {
    return GoogleFonts.inter(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );
  }

  // Button style configuration
  ButtonStyle _getButtonStyle() {
    return ButtonStyle(
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      ),
      foregroundColor: WidgetStateProperty.all(
        Colors.white,
      ),
      backgroundColor: WidgetStateProperty.all(Colors.white),
      overlayColor: WidgetStateProperty.all(Colors.white),
      side: WidgetStateProperty.resolveWith(_getBorderStyle),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPress,
      style: _getButtonStyle(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: _getTextStyle()),
          const SizedBox(width: 6),
          Icon(icon, size: 24, color: Colors.black),
        ],
      ),
    );
  }
}
