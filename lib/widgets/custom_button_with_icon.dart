import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPress;
  final bool isSelected;

  const CustomButtonWithIcon({
    required this.label,
    required this.icon,
    required this.onPress,
    required this.isSelected,
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
    return BorderSide(
      color: isSelected ? Colors.black : Color(0xffD5D3D3),
      width: isSelected ? 2 : 1,
    );
  }

  // Get text style based on selection state
  TextStyle _getTextStyle() {
    return GoogleFonts.inter(
      color: isSelected ? Colors.black : Colors.grey[600],
      fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
      fontSize: 16,
    );
  }

  // Button style configuration
  ButtonStyle _getButtonStyle() {
    return ButtonStyle(
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      ),
      foregroundColor: WidgetStateProperty.all(
        isSelected ? Colors.white : Color(0xffD5D3D3),
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
          Icon(
            icon,
            size: 24,
            color: isSelected ? Colors.black : Colors.grey[400],
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: _getTextStyle(),
          ),
        ],
      ),
    );
  }
}
