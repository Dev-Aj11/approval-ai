import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCheckBox extends StatelessWidget {
  final String heading;
  final String subHeading;
  final Function onCheck;
  final bool isChecked;

  const CustomCheckBox({
    required this.heading,
    required this.subHeading,
    required this.onCheck,
    required this.isChecked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCheckbox(),
        SizedBox(width: 12),
        _buildCheckboxDescription(),
      ],
    );
  }

  _buildCheckbox() {
    return Transform.scale(
      scale: 1.3,
      child: Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        value: isChecked,
        onChanged: (value) {
          onCheck(value);
        },
      ),
    );
  }

  _buildCheckboxDescription() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 2),
          Text(
            subHeading,
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
