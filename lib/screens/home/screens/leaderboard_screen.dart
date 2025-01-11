import 'package:approval_ai/screens/home/widgets/cusotm_leaderboard_header.dart';
import 'package:approval_ai/screens/home/widgets/custom_leaderboard_table.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String selectedValue = "5 years";

  void updateFilterValue(newValue) {
    setState(() {
      selectedValue = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CusotmLeaderboardHeader(
            selectedValue: selectedValue,
            onPress: (newValue) {
              updateFilterValue(newValue);
            }),
        SizedBox(height: 24),
        CustomLeaderboardTable()
      ],
    );
  }
}
