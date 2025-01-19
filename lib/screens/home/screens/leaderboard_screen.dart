import 'package:approval_ai/models/loan_estimate.dart';
import './leaderboard_sections.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  final List<LoanEstimate> loanEstimates;
  const LeaderboardScreen({super.key, required this.loanEstimates});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String selectedValue = "5 years";
  List<LoanEstimate> bestLoanEstimates = [];

  @override
  void initState() {
    super.initState();
    getBestLoanEstimates();
  }

  void onSelectFilter(newValue) {
    setState(() {
      selectedValue = newValue!;
    });
  }

  void getBestLoanEstimates() {
    int userSelectedLoanTerm = int.parse(selectedValue.split(" ")[0]);
    // sort all loan estimates from lowest total payments to highest total payments
    // compareTo is comparing loan estimates from loan A with loan B
    widget.loanEstimates.sort(
      (a, b) => a.getTotalPayments(userSelectedLoanTerm).compareTo(
            b.getTotalPayments(userSelectedLoanTerm),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 16),
          LeaderboardSections.buildLeaderboardTable(
              widget.loanEstimates, userSelectedLoanTerm),
        ],
      ),
    );
  }
}
