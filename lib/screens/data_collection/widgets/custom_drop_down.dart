import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown extends StatelessWidget {
  final String currValue;
  final List<String> options;
  final Function onSelect;

  const CustomDropdown({
    required this.currValue,
    required this.options,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Layoutbuilder lets you create a widget that depends on parent widget's constraints
    // builder function gives you access to the constraints of parent widget imposes
    return LayoutBuilder(builder: (context, constraints) {
      return DropdownMenu<String>(
        width: constraints.maxWidth,
        enableFilter: false,
        enableSearch: false,
        requestFocusOnTap: false,
        initialSelection: currValue,
        onSelected: (value) => onSelect(value),
        inputDecorationTheme: InputDecorationTheme(
          // Customize the text field height
          contentPadding: EdgeInsets.symmetric(vertical: 22, horizontal: 24),
          enabledBorder: _buildBorder(width: 2, color: Colors.black),
        ),
        menuStyle: _buildMenuStyle(constraints.maxWidth),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        dropdownMenuEntries: options.map<DropdownMenuEntry<String>>(
          (String value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          },
        ).toList(),
      );
    });
  }

  MenuStyle _buildMenuStyle(double parentWidth) {
    return MenuStyle(
      backgroundColor: WidgetStateProperty.all(Colors.white),
      elevation: WidgetStateProperty.all(4),
      padding: WidgetStateProperty.all(EdgeInsets.zero),
      maximumSize: WidgetStateProperty.all(Size(parentWidth, double.infinity)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: Colors.grey.shade200),
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder({
    required double width,
    required Color color,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(width: width, color: color),
    );
  }
}
