import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonConfig {
  final String label;
  final VoidCallback onPress; // specific type alias for void Function()

  ButtonConfig({required this.label, required this.onPress});
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<ButtonConfig> buttons;

  const CustomAppBar({required this.buttons, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300, // Light grey border
            width: 1.0,
          ),
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/img/logo.png',
              height: 32,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 10),
            Text(
              "Approval AI",
              style: GoogleFonts.playfairDisplay(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff0065FE),
              ),
            ),
          ],
        ),
        actions: List.generate(
          buttons.length,
          (index) => TextButton(
            onPressed: buttons[index].onPress,
            child: Text(
              buttons[index].label,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
