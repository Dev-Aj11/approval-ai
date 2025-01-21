import 'package:approval_ai/screens/agent_interactions/model/interaction_data.dart';
import 'package:approval_ai/screens/home/model/estimate_data.dart';
import 'package:approval_ai/screens/home/model/overview_data.dart';
import 'package:flutter/material.dart';

enum LenderDetailsEnum {
  messagesExchagned,
  estimateAnalysis,
  negotiationAnalysis
}

class LenderData {
  final String name;
  final String type;
  final String logoUrl;
  final String loanOfficer;
  final List<MessageData> messages;
  final List<LenderStatusEnum> currStatus;
  final List<LoanEstimateData>? estimateData;
  final String? estimateUrl;

  LenderData({
    required this.name,
    required this.type,
    required this.logoUrl,
    required this.loanOfficer,
    required this.currStatus,
    required this.messages,
    this.estimateUrl,
    this.estimateData,
  }) {
    if (estimateData != null) {
      if (estimateData!.length > 1) {
        // sort by descending order
        // most recent estimate first
        estimateData!.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      }
    }
  }

  get mostRecentEstimate {
    if (estimateData == null) {
      return null;
    }
    return estimateData!.first;
  }

  get initialEstimate {
    if (estimateData == null) {
      return null;
    }
    return estimateData!.last;
  }

  // Convenience getters
  int get emailsExchanged {
    int emailsExchanged = 0;
    for (var message in messages) {
      if (message.mode == "email") {
        emailsExchanged++;
      }
    }
    return emailsExchanged;
  }

  int get textsExchanged {
    int textsExchanged = 0;
    for (var message in messages) {
      if (message.mode == "text") {
        textsExchanged++;
      }
    }
    return textsExchanged;
  }

  int get phoneCallsExchanged {
    int phoneCalls = 0;
    for (var message in messages) {
      if (message.mode == "phone") {
        phoneCalls++;
      }
    }
    return phoneCalls;
  }

  String? get interestRate {
    if (estimateData == null) {
      return null;
    }
    return estimateData!.first.loanDetails.interestRate.initial.toString();
  }

  String? get principalPaidOff {
    if (estimateData == null) {
      return null;
    }
    return estimateData!.first.loanDetails.loanAmount.toString();
  }

  String? get monthlyPayment {
    if (estimateData == null) {
      return null;
    }
    return estimateData!.first.monthlyPaymentAndInterest.toString();
  }

  double? get totalPayments {
    if (estimateData == null) {
      return null;
    }
    final monthlyPayment = estimateData!.first.monthlyPaymentAndInterest;
    final closingCosts = estimateData!.first.closingCosts.totalClosingCosts;
    final term = estimateData!.first.loanDetails.term; // in years
    return (monthlyPayment * 12 * term) + closingCosts;
  }
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
