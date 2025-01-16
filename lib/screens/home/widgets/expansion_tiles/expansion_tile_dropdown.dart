import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpansionTileDropdown extends StatefulWidget {
  final String currValue;
  final List<String> options;
  final Function onSelect;

  const ExpansionTileDropdown({
    required this.currValue,
    required this.options,
    required this.onSelect,
    super.key,
  });

  @override
  State<ExpansionTileDropdown> createState() => _ExpansionTileDropdownState();
}

class _ExpansionTileDropdownState extends State<ExpansionTileDropdown> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    // Layoutbuilder lets you create a widget that depends on parent widget's constraints
    // builder function gives you access to the constraints of parent widget imposes
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: _getDropDownBtnStyle(),
        child: DropdownButton(
            dropdownColor: Colors.white,
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
            isDense: true,
            underline: Container(), // remove underline
            value: widget.currValue,
            items:
                widget.options.map((e) => _buildDropdownMenuItem(e)).toList(),
            onChanged: (value) => widget.onSelect(value)),
      ),
    );
  }

  _getDropDownBtnStyle() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: isHovered
            ? Colors.black
            : const Color(0xffD5D3D3), // Light gray border
        width: isHovered ? 2 : 1,
      ),
      borderRadius: BorderRadius.circular(16),
    );
  }

  DropdownMenuItem<String> _buildDropdownMenuItem(String currValue) {
    return DropdownMenuItem(
      value: currValue,
      child: Text(currValue),
    );
  }
}
