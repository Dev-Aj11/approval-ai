import 'package:flutter/material.dart';

class PrimaryCta extends StatelessWidget {
  final String label;
  final Function onPressCb;
  final bool smallSize;
  const PrimaryCta(
      {required this.label,
      required this.onPressCb,
      this.smallSize = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    ;
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
        onPressed: () async {
          await onPressCb();
        },
        child: Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
