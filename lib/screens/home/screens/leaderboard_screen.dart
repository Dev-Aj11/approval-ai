import 'package:approval_ai/screens/home/model/estimate_data.dart';
import './leaderboard_sections.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  final List<LoanEstimateData> loanEstimates;
  const LeaderboardScreen({super.key, required this.loanEstimates});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String selectedValue = "5 years";
  List<LoanEstimateData> bestLoanEstimates = [];

  void onSelectFilter(newValue) {
    setState(() {
      selectedValue = newValue!;
    });
  }

  void getBestLoanEstimates() {
    int userSelectedLoanTerm = int.parse(selectedValue.split(" ")[0]);
    if (widget.loanEstimates.length > 1) {
      // sort all loan estimates from lowest total payments to highest total payments
      // compareTo is comparing loan estimates from loan A with loan B
      widget.loanEstimates.sort(
        (a, b) => a.getTotalPayments(userSelectedLoanTerm).compareTo(
              b.getTotalPayments(userSelectedLoanTerm),
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    getBestLoanEstimates();
    int userSelectedLoanTerm = int.parse(selectedValue.split(" ")[0]);
    return Container(
      constraints: const BoxConstraints(maxWidth: 1100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LeaderboardSections.buildLeaderboardHeaderWithFilter(
              selectedValue, onSelectFilter),
          SizedBox(height: 0),
          LeaderboardSections.buildLeaderboardSubheading(),
          SizedBox(height: 24),
          LeaderboardSections.buildLeaderboardTable(
              widget.loanEstimates, userSelectedLoanTerm),
        ],
      ),
    );
  }
}
