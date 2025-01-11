import 'package:approval_ai/widgets/custom_field_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:math' show min;

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode; // not sure why this is needed?
  final bool obscureText;
  final bool digitsOnly;
  final bool textOnly;
  final bool isMoney;
  final String? prefix;
  final Widget? suffixIcon;
  final String? hint;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    required this.label,
    required this.controller,
    required this.focusNode,
    this.prefix,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.hint,
    this.onChanged,
    this.obscureText = false,
    this.digitsOnly = false,
    this.textOnly = false,
    this.isMoney = false,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // change style when text field is focused
  bool isFocused = false;
  final _moneyFormatter = NumberFormat.currency(
    locale: 'en_US',
    symbol: '', // Empty because we're using prefixText
    decimalDigits: 0,
  );

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

  List<TextInputFormatter> _buildInputFormatter() {
    if (widget.digitsOnly || widget.isMoney) {
      return [FilteringTextInputFormatter.digitsOnly];
    }
    if (widget.textOnly) {
      return [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))];
    }
    return [];
  }

  Widget _buildTextField(context) {
    return TextFormField(
      focusNode: widget.focusNode,
      inputFormatters: _buildInputFormatter(),
      controller: widget.controller,
      obscureText: widget.obscureText,
      validator: widget.validator,
      keyboardType: widget.isMoney
          ? const TextInputType.numberWithOptions(decimal: true)
          : widget.keyboardType,
      cursorColor: Colors.black,
      decoration: _getInputDecoration(context),
      style: _getTextStyle(),
      onChanged: widget.onChanged ?? (widget.isMoney ? _formatMoney : null),
    );
  }

  void _formatMoney(String value) {
    if (value.isEmpty) return;

    try {
      // Remove any existing commas first
      String cleanValue = value.replaceAll(',', '');

      // Parse to integer
      int? amount = int.tryParse(cleanValue);
      if (amount != null) {
        // Format with commas
        String formatted = _moneyFormatter.format(amount);

        // Only update if the value is different
        if (formatted != widget.controller.text) {
          widget.controller.value = TextEditingValue(
            text: formatted,
            selection: TextSelection.collapsed(offset: formatted.length),
          );
        }
      }
    } catch (e) {
      print('Error formatting money: $e');
    }
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
