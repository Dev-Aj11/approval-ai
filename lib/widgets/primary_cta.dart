import 'package:flutter/material.dart';

class PrimaryCta extends StatelessWidget {
  final String label;
  final Function onPressCb;
  final bool smallSize;
  final bool? isEnabled;
  const PrimaryCta(
      {required this.label,
      required this.onPressCb,
      this.smallSize = false,
      this.isEnabled = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (smallSize) ? 120 : double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.fromLTRB(32, 24, 32, 24),
          backgroundColor: Color(0xFF0065FE),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(24),
            ),
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: (isEnabled == true)
            ? () async {
                await onPressCb();
              }
            : null,
        child: Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
