import 'package:flutter/material.dart';

enum LenderDetails { messagesExchagned, estimateAnalysis, negotiationAnalysis }

const kLenderExpansionTileCardHeader = {
  LenderDetails.messagesExchagned: LenderExpansionTileCardHeader(
      icon: Icons.mail_outline, title: "Messages Exchanged"),
  LenderDetails.estimateAnalysis: LenderExpansionTileCardHeader(
      icon: Icons.analytics_outlined, title: "Loan Estimate Analysis"),
  LenderDetails.negotiationAnalysis: LenderExpansionTileCardHeader(
      icon: Icons.attach_money, title: "Negotiation Analysis"),
};

final kLenderExpansionTileButtonRow = {
  LenderDetails.messagesExchagned: [
    LenderExpansionTileButton(
        icon: Icons.download, btnTitle: "Download Messages ", onPress: () {})
  ],
  LenderDetails.estimateAnalysis: [
    LenderExpansionTileButton(
        icon: Icons.arrow_drop_down, btnTitle: "5 years", onPress: () {}),
    LenderExpansionTileButton(
        icon: Icons.open_in_new, btnTitle: "View Estimate ", onPress: () {})
  ],
  LenderDetails.negotiationAnalysis: [
    LenderExpansionTileButton(
        icon: Icons.download, btnTitle: "Download Messages ", onPress: () {})
  ]
};

final kLenderExpansionTileMetrics = {
  LenderDetails.messagesExchagned: [
    LenderExpansionTileMetric(data: "12", title: "Documents Shared "),
    LenderExpansionTileMetric(data: "12", title: "Emails Exchanged "),
    LenderExpansionTileMetric(data: "12", title: "Text Messages"),
    LenderExpansionTileMetric(data: "12", title: "Phone Calls"),
  ],
  LenderDetails.estimateAnalysis: [
    LenderExpansionTileMetric(data: "A+", title: "Grade"),
    LenderExpansionTileMetric(data: "3.75%", title: "Interest Rate"),
    LenderExpansionTileMetric(data: "\$1200", title: "Lender Payments"),
    LenderExpansionTileMetric(data: "\$1400", title: "Total Payments"),
  ],
  LenderDetails.negotiationAnalysis: [
    LenderExpansionTileMetric(data: "12", title: "Download Messages "),
    LenderExpansionTileMetric(data: "12", title: "Download Messages "),
    LenderExpansionTileMetric(data: "12", title: "Download Messages "),
    LenderExpansionTileMetric(data: "12", title: "Download Messages "),
  ]
};

class LenderExpansionTileCardHeader {
  final IconData icon;
  final String title;

  const LenderExpansionTileCardHeader({
    required this.icon,
    required this.title,
  });
}

class LenderExpansionTileButton {
  final IconData icon;
  final String btnTitle;
  final VoidCallback onPress;

  const LenderExpansionTileButton({
    required this.icon,
    required this.btnTitle,
    required this.onPress,
  });
}

class LenderExpansionTileMetric {
  final String data;
  final String title;

  const LenderExpansionTileMetric({
    required this.data,
    required this.title,
  });
}

// models/lender_ranking.dart
class LenderRanking {
  final String rankImage;
  final String name;
  final String interestRate;
  final String totalPayments;

  const LenderRanking({
    required this.rankImage,
    required this.name,
    required this.interestRate,
    required this.totalPayments,
  });
}

const kLenderDetails = {
  "US Bank": {
    "name": "US Bank",
    "type": "Retail Bank",
    "loanOfficer": "John Smith",
    "logo": "assets/img/us_bank.png"
  },
  "Wells Fargo": {
    "name": "Wells Fargo",
    "type": "Retail Bank",
    "loanOfficer": "Jane Doe",
    "logo": "assets/img/wells_fargo_bank.png"
  },
  "Citi Bank": {
    "name": "Citi Bank",
    "type": "Retail Bank",
    "loanOfficer": "Jane Doe",
    "logo": "assets/img/citi_bank.png"
  },
  "Chase Bank": {
    "name": "Chase Bank",
    "type": "Retail Bank",
    "loanOfficer": "Jane Doe",
    "logo": "assets/img/chase_bank.png"
  }
};

/*
const kLenderStatus = {
  "US Bank": {
    "messages_exchanged": [
      {"24": "Documents Shared"}
    ],
    "estimate_analysis": "Retail Bank",
    "negotiation_analysis": "John Smith",
  },
  "Wells Fargo": {
    "name": "Wells Fargo",
    "type": "Retail Bank",
    "loanOfficer": "Jane Doe",
    "logo": "assets/img/wells_fargo_bank.png"
  },
  "Citi Bank": {
    "name": "Citi Bank",
    "type": "Retail Bank",
    "loanOfficer": "Jane Doe",
    "logo": "assets/img/citi_bank.png"
  },
  "Chase Bank": {
    "name": "Wells Fargo",
    "type": "Retail Bank",
    "loanOfficer": "Jane Doe",
    "logo": "assets/img/chase_bank.png"
  }
};
*/
