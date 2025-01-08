import 'package:flutter/material.dart';

enum LenderDetails { messagesExchagned, estimateAnalysis, negotiationAnalysis }

const kLenderExpansionCard = {
  LenderDetails.messagesExchagned: LenderExpandionCardDetails(
      icon: Icons.mail_outline, title: "Messages Exchanged"),
  LenderDetails.estimateAnalysis: LenderExpandionCardDetails(
      icon: Icons.analytics_outlined, title: "Loan Estimate Analysis"),
  LenderDetails.negotiationAnalysis: LenderExpandionCardDetails(
      icon: Icons.attach_money, title: "Negotiation Analysis"),
};

class LenderExpandionCardDetails {
  final IconData icon;
  final String title;

  const LenderExpandionCardDetails({
    required this.icon,
    required this.title,
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
