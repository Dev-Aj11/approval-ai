import 'package:approval_ai/widgets/custom_field_heading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode; // not sure why this is needed?
  final bool obscureText;
  final String? prefix;
  final Widget? suffixIcon;
  final String? hint;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.focusNode,
    this.prefix,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.hint,
    this.obscureText = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // change style when text field is focused
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocused = widget.focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildLabel(),
      SizedBox(height: 12),
      _buildTextField(context)
    ]);
  }

  Widget _buildLabel() {
    return CustomFieldHeading(label: widget.label);
  }

  Widget _buildTextField(context) {
    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: widget.obscureText,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      cursorColor: Colors.black,
      decoration: _getInputDecoration(context),
      style: _getTextStyle(),
    );
  }

  InputDecoration _getInputDecoration(BuildContext context) {
    // change style if text field is selected or text field contains text
    final bool isActiveState =
        widget.focusNode.hasFocus || widget.controller.text.isNotEmpty;

    return InputDecoration(
      filled: true,
      hoverColor:
          isActiveState ? Colors.transparent : Theme.of(context).hoverColor,
      fillColor: isActiveState ? Colors.transparent : const Color(0xFFF5F7F9),
      hintText: widget.hint,
      prefixText: widget.prefix,
      suffixIcon: widget.suffixIcon,
      contentPadding: const EdgeInsets.fromLTRB(16, 20, 0, 20),
      enabledBorder: _buildBorder(
        width: 1,
        color: widget.controller.text.isNotEmpty
            ? Colors.black
            : Colors.transparent,
      ),
      focusedBorder: _buildBorder(width: 2, color: Colors.black),
      errorBorder: _buildBorder(width: 1, color: Colors.red),
      focusedErrorBorder: _buildBorder(width: 1, color: Colors.red),
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

  TextStyle _getTextStyle() {
    return GoogleFonts.inter(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }
}
