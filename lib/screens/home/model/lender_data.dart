import 'package:flutter/material.dart';

enum LenderDetailsEnum {
  messagesExchagned,
  estimateAnalysis,
  negotiationAnalysis
}

// Create a base class for common metric behavior
// abstract class enforces a contract with all subclasses that extend it
abstract class LenderMetricData {
  const LenderMetricData();

  // Optional: Add common methods or properties
  // this is an abstract method that all classes that extend LenderMetricData must implement
  LenderExpansionTileCardHeader get tileHeader;
  Map<String, String> toMap();
}

class LenderDataMessagesExchanged extends LenderMetricData {
  final LenderExpansionTileCardHeader tileHeader;
  final String emailsExchanged;
  final String textMessages;
  final String phoneCalls;

  const LenderDataMessagesExchanged(
      {this.tileHeader = const LenderExpansionTileCardHeader(
          icon: Icons.mail_outline, title: "Messages Exchanged"),
      this.emailsExchanged = "0",
      this.textMessages = "0",
      this.phoneCalls = "0"});

  @override
  Map<String, String> toMap() => {
        'Emails Exchanged': emailsExchanged,
        'Text Messages': textMessages,
        'Phone Calls': phoneCalls,
      };
}

class LenderDataEstimateAnalysis extends LenderMetricData {
  final LenderExpansionTileCardHeader tileHeader;
  final String interestRate;
  final String lenderPayments;
  final String totalPayments;

  const LenderDataEstimateAnalysis(
      {this.tileHeader = const LenderExpansionTileCardHeader(
          icon: Icons.analytics_outlined, title: "Loan Estimate Analysis"),
      required this.interestRate,
      required this.lenderPayments,
      required this.totalPayments});

  @override
  Map<String, String> toMap() => {
        'Interest Rate': interestRate,
        'Lender Payments': lenderPayments,
        'Total Payments': totalPayments,
      };
}

class LenderDataNegotiationAnalysis extends LenderMetricData {
  final LenderExpansionTileCardHeader tileHeader;
  final String totalSavings;
  final String initialTotalPayments;
  final String negotiatedTotalPayments;

  const LenderDataNegotiationAnalysis({
    this.tileHeader = const LenderExpansionTileCardHeader(
        icon: Icons.shopping_basket, title: "Negotiation Analysis"),
    required this.totalSavings,
    required this.initialTotalPayments,
    required this.negotiatedTotalPayments,
  });

  @override
  Map<String, String> toMap() => {
        'Total Savings': totalSavings,
        'Initial Total Payments': initialTotalPayments,
        'Negotiated Total Payments': negotiatedTotalPayments,
      };
}

class LenderData {
  final String name;
  final String type;
  final String logoUrl;
  final String loanOfficer;
  final Map<LenderDetailsEnum, LenderMetricData> metrics;

  const LenderData({
    required this.name,
    required this.type,
    required this.logoUrl,
    required this.loanOfficer,
    required this.metrics,
  });

  // Convenience getters
  LenderDataMessagesExchanged get messagesExchanged =>
      metrics[LenderDetailsEnum.messagesExchagned]
          as LenderDataMessagesExchanged;

  LenderDataEstimateAnalysis get estimateAnalysis =>
      metrics[LenderDetailsEnum.estimateAnalysis] as LenderDataEstimateAnalysis;

  LenderDataNegotiationAnalysis get negotiationAnalysis =>
      metrics[LenderDetailsEnum.negotiationAnalysis]
          as LenderDataNegotiationAnalysis;
}

// IGNORE THIS
class LenderDetailsData {
  static final instance = LenderDetailsData._();
  LenderDetailsData._();

  final cardHeaders = {
    LenderDetailsEnum.messagesExchagned: const LenderExpansionTileCardHeader(
        icon: Icons.mail_outline, title: "Messages Exchanged"),
    LenderDetailsEnum.estimateAnalysis: const LenderExpansionTileCardHeader(
        icon: Icons.analytics_outlined, title: "Loan Estimate Analysis"),
    LenderDetailsEnum.negotiationAnalysis: const LenderExpansionTileCardHeader(
        icon: Icons.attach_money, title: "Negotiation Analysis"),
  };

  final buttonRows = {
    LenderDetailsEnum.messagesExchagned: [
      LenderExpansionTileButton(
          icon: Icons.download, btnTitle: "Download Messages ", onPress: () {})
    ],
    LenderDetailsEnum.estimateAnalysis: [
      LenderExpansionTileButton(
          icon: Icons.arrow_drop_down, btnTitle: "5 years", onPress: () {}),
      LenderExpansionTileButton(
          icon: Icons.open_in_new, btnTitle: "View Estimate ", onPress: () {})
    ],
    LenderDetailsEnum.negotiationAnalysis: [
      LenderExpansionTileButton(
          icon: Icons.arrow_drop_down, btnTitle: "5 years", onPress: () {}),
    ]
  };

  final metrics = {
    LenderDetailsEnum.messagesExchagned: [
      const LenderExpansionTileMetric(data: "12", title: "Documents Shared "),
      const LenderExpansionTileMetric(data: "12", title: "Emails Exchanged "),
      const LenderExpansionTileMetric(data: "12", title: "Text Messages"),
      const LenderExpansionTileMetric(data: "12", title: "Phone Calls"),
    ],
    LenderDetailsEnum.estimateAnalysis: [
      const LenderExpansionTileMetric(data: "A+", title: "Grade"),
      const LenderExpansionTileMetric(data: "3.75%", title: "Interest Rate"),
      const LenderExpansionTileMetric(data: "\$1200", title: "Lender Payments"),
      const LenderExpansionTileMetric(data: "\$1400", title: "Total Payments"),
    ],
    LenderDetailsEnum.negotiationAnalysis: [
      const LenderExpansionTileMetric(data: "\$200", title: "Total Savings"),
      const LenderExpansionTileMetric(
          data: "\$1200", title: "Initial\nTotal Payments"),
      const LenderExpansionTileMetric(
          data: "\$1000", title: "Negotiated \nTotal Payments")
    ]
  };

  LenderExpansionTileCardHeader getHeader(LenderDetailsEnum detail) =>
      cardHeaders[detail]!;

  List<LenderExpansionTileButton> getButtons(LenderDetailsEnum detail) =>
      buttonRows[detail]!;

  List<LenderExpansionTileMetric> getMetrics(LenderDetailsEnum detail) =>
      metrics[detail]!;
}

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

class LenderRepository {
  static final instance = LenderRepository._();
  LenderRepository._();

  final Map<String, Map<String, String>> details = {
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

  Map<String, String>? getLenderDetails(String lenderName) =>
      details[lenderName];
}

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
