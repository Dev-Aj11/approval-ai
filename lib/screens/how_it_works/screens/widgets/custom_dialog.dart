import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class CustomDialog extends StatelessWidget {
  final String header;
  final String imgPath;
  final String content;
  final String btnText;
  final Function onPressNext;
  const CustomDialog({
    super.key,
    required this.header,
    required this.content,
    required this.onPressNext,
    required this.imgPath,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        // ensure there is a minimum padding of 48px on smaller screens
        horizontal: max(MediaQuery.of(context).size.width * 0.04, 48.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("What Happens Next?",
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 14),
          Image(
            image: AssetImage(imgPath),
            // ensure the image is at least 300px wide and 300px high
            width: 300,
            height: 300,
          ),
          SizedBox(height: 14),
          Text(
            header,
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color(0xff0065FE),
            ),
          ),
          SizedBox(height: 20),
          Text(
            content,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 32),
          Container(
            alignment: Alignment.topRight,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff0065FE),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 22),
                foregroundColor: Colors.white,
              ),
              onPressed: () => onPressNext(),
              child: Text(btnText),
            ),
          ),
        ],
      ),
    );
  }
}
