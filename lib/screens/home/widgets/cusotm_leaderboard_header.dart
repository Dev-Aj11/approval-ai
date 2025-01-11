import 'package:approval_ai/screens/home/widgets/custom_headings.dart';
import 'package:flutter/material.dart';

class CusotmLeaderboardHeader extends StatelessWidget {
  final String selectedValue;
  final Function onPress;
  const CusotmLeaderboardHeader(
      {required this.selectedValue, required this.onPress, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: CustomSubHeading(label: "Leaderboard")),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: DropdownButton<String>(
              value: selectedValue, // Your currently selected value
              icon: Icon(Icons.keyboard_arrow_down),
              underline: Container(), // Removes the default underline
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              iconEnabledColor: Colors.black,
              dropdownColor: Colors.white, // Background color of dropdown
              focusColor: Colors.transparent,
              items: [
                '5 years',
                '10 years',
                '15 years',
                '20 years',
                '30 years',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text("Payments over $value"),
                );
              }).toList(),
              onChanged: (String? newValue) => onPress(newValue)),
        ),
      ],
    );
  }
}
