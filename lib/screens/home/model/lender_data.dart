import 'package:approval_ai/models/loan_estimate.dart';
import 'package:approval_ai/screens/home/model/overview_data.dart';
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
  // List<dynamic> getButtons();
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

  const LenderDataNegotiationAnalysis(
      {this.tileHeader = const LenderExpansionTileCardHeader(
          icon: Icons.attach_money, title: "Negotiation Analysis"),
      required this.totalSavings,
      required this.initialTotalPayments,
      required this.negotiatedTotalPayments});

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
  final List<LenderStatusEnum> currStatus;
  final Map<LenderDetailsEnum, LenderMetricData> metrics;

  const LenderData({
    required this.name,
    required this.type,
    required this.logoUrl,
    required this.loanOfficer,
    required this.currStatus,
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

class LenderLeaderboardMetric {
  final String rankImage;
  final String name;
  final String monthlyPayments;
  final String totalPayments;

  const LenderLeaderboardMetric({
    required this.rankImage,
    required this.name,
    required this.monthlyPayments,
    required this.totalPayments,
  });
}
