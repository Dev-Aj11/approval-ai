/*
  "loanDetails": {
    "term": "30” (int), 
    "purpose": "Purchase",
    "product": "7/6 mo. Adjustable Rate",
    "loanType": "Conventional",
    "loanAmount": "number",
    "interestRate": {
      "initial": 3.875,
      "adjustable": {
        "isAdjustable": true,
        "details": {
          "adjustmentFrequency": "6 months",
          "initialChangeMonth": "85",?
          "indexMargin": "30-day Average SOFR + 3%",
          "minRate": "3",
          "maxRate": "8.875”,
          "firstChangeLimit": "5",
          "subsequentChangeLimit": "1"
        }
      }
    },
    "monthlyPrincipalAndInterest": "4326.18",
    "monthlyPaymentRange": {
      "min": "3963",
      "max": "6718"
    },
    "prepaymentPenalty": false,
    "balloonPayment": false
  },
  "closingCosts": {
    "totalClosingCosts": "number",
    "breakdown": {
      "loanCosts": {
        "originationCharges": "number",
        "servicesCannotShopFor": "number",
        "servicesCanShopFor": "number"
      },
      "otherCosts": {
        "taxes": "number",
        "prepaids": "number",
        "escrow": "number",
        "optionalCosts": "number"
      }
    },
    "cashToClose": "number"
  },
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';

class LoanEstimateData {
  final String lenderName;
  final String estimateUrl;
  final bool balloonPayment;
  final bool prepaymentPenalty;
  final double monthlyPaymentAndInterest;
  final Timestamp timestamp;
  final ClosingCosts closingCosts;
  final Comparisons comparisons;
  final LoanDetails loanDetails;
  final MonthlyPaymentRange monthlyPaymentRange;

  const LoanEstimateData({
    required this.lenderName,
    required this.estimateUrl,
    required this.balloonPayment,
    required this.prepaymentPenalty,
    required this.monthlyPaymentAndInterest,
    required this.timestamp,
    required this.closingCosts,
    required this.comparisons,
    required this.loanDetails,
    required this.monthlyPaymentRange,
  });

  // temr should be in years
  double getTotalPayments(customLoanTerm) {
    var newLoanTerm =
        (customLoanTerm != null) ? customLoanTerm : loanDetails.term;
    return ((monthlyPaymentAndInterest * newLoanTerm * 12) +
        closingCosts.totalClosingCosts);
  }

  double getPrincipalPaidOff(customLoanTerm) {
    // Loan details// Principal
    double annualInterestRate =
        loanDetails.interestRate.initial / 100; // Annual interest rate
    double monthlyInterestRate =
        annualInterestRate / 12; // Monthly interest rate

    // Initialize variables
    double remainingBalance = loanDetails.loanAmount;
    double totalInterest = 0.0;
    double totalPrincipal = 0.0;

    // List to store the amortization schedule
    List<Map<String, dynamic>> amortizationSchedule = [];

    // Generate the amortization schedule
    for (int month = 1; month <= (customLoanTerm * 12); month++) {
      double interestPayment = remainingBalance * monthlyInterestRate;
      double principalPayment = monthlyPaymentAndInterest - interestPayment;
      remainingBalance -= principalPayment;

      // Add to cumulative totals
      totalInterest += interestPayment;
      totalPrincipal += principalPayment;

      // Add month details to the schedule
      amortizationSchedule.add({
        'Month': month,
        'Payment': monthlyPaymentAndInterest,
        'Principal': principalPayment,
        'Interest': totalInterest,
        'Remaining Balance': remainingBalance,
      });

      // Stop if the loan is fully paid off
      if (remainingBalance <= 0) break;
    }
    // check the math on this -1
    return totalPrincipal;
  }
}

class Comparisons {
  final double annualPercentageRate;
  final double principalPaidIn5Years;
  final double totalInterestPercentage;
  final double totalPaidIn5Years;

  const Comparisons({
    required this.annualPercentageRate,
    required this.principalPaidIn5Years,
    required this.totalInterestPercentage,
    required this.totalPaidIn5Years,
  });
}

class ClosingCosts {
  final double totalClosingCosts;
  final double cashToClose;
  final ClosingCostsBreakdown breakdown;

  const ClosingCosts({
    required this.totalClosingCosts,
    required this.cashToClose,
    required this.breakdown,
  });
}

class ClosingCostsBreakdown {
  final LoanCosts loanCosts;
  final OtherCosts otherCosts;

  const ClosingCostsBreakdown({
    required this.loanCosts,
    required this.otherCosts,
  });
}

class LoanCosts {
  final double originationCharges;
  final double servicesCannotShopFor;
  final double servicesCanShopFor;

  const LoanCosts({
    required this.originationCharges,
    required this.servicesCannotShopFor,
    required this.servicesCanShopFor,
  });
}

class OtherCosts {
  final double taxes;
  final double prepaids;
  final double escrow;
  final double optionalCosts;

  const OtherCosts({
    required this.taxes,
    required this.prepaids,
    required this.escrow,
    required this.optionalCosts,
  });
}

class LoanDetails {
  final double loanAmount;
  final InterestRate interestRate;
  final int term;

  const LoanDetails({
    required this.loanAmount,
    required this.interestRate,
    required this.term,
  });
}

class InterestRate {
  final double initial;
  final Adjustable adjustable;

  const InterestRate({
    required this.initial,
    required this.adjustable,
  });
}

class Adjustable {
  final bool isAdjustable;
  AdjustmentDetails? details;

  Adjustable({
    required this.isAdjustable,
    this.details,
  });
}

class AdjustmentDetails {
  final int adjustmentFrequency;
  final int initialChangeMonth;
  final int indexMargin;
  final double minRate;
  final double maxRate;
  final int firstChangeLimit;
  final int subsequentChangeLimit;

  const AdjustmentDetails({
    required this.adjustmentFrequency,
    required this.initialChangeMonth,
    required this.indexMargin,
    required this.minRate,
    required this.maxRate,
    required this.firstChangeLimit,
    required this.subsequentChangeLimit,
  });
}

class MonthlyPaymentRange {
  final double min;
  final double max;

  const MonthlyPaymentRange({
    required this.min,
    required this.max,
  });
}
