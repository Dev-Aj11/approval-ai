import 'package:flutter/material.dart';

class AuthTextButton extends StatelessWidget {
  final String label;
  final Function onPressedCb;
  const AuthTextButton(
      {required this.label, required this.onPressedCb, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressedCb(),
      style: TextButton.styleFrom(
        overlayColor: Colors.transparent,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class AuthText extends StatelessWidget {
  final String label;
  const AuthText({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: Color(0xff9A9A9A),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
