import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String label;
  final String subheading;
  final bool newAccount;
  const Header(
      {required this.label,
      this.subheading = "",
      this.newAccount = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/img/logo.png', width: 80, height: 80),
        SizedBox(
          height: 12,
        ),
        // image as well
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        (subheading.isEmpty) ? SizedBox.shrink() : SizedBox(height: 16),
        (subheading.isEmpty)
            ? SizedBox.shrink()
            : Text(
                subheading,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
        // SizedBox(height: 64),
      ],
    );
  }
}
