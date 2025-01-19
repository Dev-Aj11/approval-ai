class LoanEstimate {
  final String lenderName;
  final double loanAmount;
  final int loanTerm; // in years
  final double interestRate;
  final bool isFixedRate; // adjusta
  final double monthlyPayment;
  final double closingCosts;
  final double? newInterestRate;
  final double? newClosingCosts;
  final double? newMonthlyPayments;
  final int? fixedRateLoanTerm; // if isFixedRate is false

  LoanEstimate({
    required this.lenderName,
    required this.loanAmount,
    required this.loanTerm,
    required this.interestRate,
    required this.isFixedRate,
    required this.monthlyPayment,
    required this.closingCosts,
    this.newInterestRate,
    this.newClosingCosts,
    this.newMonthlyPayments,
    this.fixedRateLoanTerm,
  });

  int getTotalPayments(customLoanTerm) {
    var newLoanTerm = (customLoanTerm != null) ? customLoanTerm : loanTerm;
    return ((monthlyPayment * newLoanTerm * 12) + closingCosts).floor();
  }

  int? getRevisedTotalPayments(customLoanTerm) {
    var revisedMonthlyPayment =
        (newMonthlyPayments != null) ? newMonthlyPayments : monthlyPayment;
    var revisedClosingCosts =
        (newClosingCosts != null) ? newClosingCosts : closingCosts;
    var newLoanTerm = (customLoanTerm != null) ? customLoanTerm : loanTerm;
    return ((revisedMonthlyPayment! * newLoanTerm * 12) + revisedClosingCosts!)
        .floor();
  }

  int? getTotalSavings(customLoanTerm) {
    var newLoanTerm = (customLoanTerm != null) ? customLoanTerm : loanTerm;
    var totalPayment = (monthlyPayment * newLoanTerm * 12) + closingCosts;
    var revisedTotalPayment = getRevisedTotalPayments(customLoanTerm);
    return (totalPayment - revisedTotalPayment!).floor();
  }

  int getPrincipalPaidOff(customLoanTerm) {
    // Loan details// Principal
    double annualInterestRate = interestRate / 100; // Annual interest rate
    double monthlyInterestRate =
        annualInterestRate / 12; // Monthly interest rate

    // Initialize variables
    double remainingBalance = loanAmount;
    double totalInterest = 0.0;
    double totalPrincipal = 0.0;

    // List to store the amortization schedule
    List<Map<String, dynamic>> amortizationSchedule = [];

    // Generate the amortization schedule
    for (int month = 1; month <= (customLoanTerm * 12); month++) {
      double interestPayment = remainingBalance * monthlyInterestRate;
      double principalPayment = monthlyPayment - interestPayment;
      remainingBalance -= principalPayment;

      // Add to cumulative totals
      totalInterest += interestPayment;
      totalPrincipal += principalPayment;

      // Add month details to the schedule
      amortizationSchedule.add({
        'Month': month,
        'Payment': monthlyPayment,
        'Principal': principalPayment,
        'Interest': interestPayment,
        'Remaining Balance': remainingBalance,
      });

      // Stop if the loan is fully paid off
      if (remainingBalance <= 0) break;
    }
    // check the math on this -1
    return (totalPrincipal - 1).floor();
  }
}

class SampleLoanEstimates {
  // simple loan; 30 years
  static LoanEstimate simpleLoan = LoanEstimate(
    lenderName: "Bank of America",
    interestRate: 4.8,
    isFixedRate: true,
    loanAmount: 920000,
    loanTerm: 30,
    monthlyPayment: 3861.54,
    closingCosts: 1000,
    newClosingCosts: 500,
    newMonthlyPayments: 3800,
  );

  // simple loan; 30 years
  static LoanEstimate simpleLoanV2 = LoanEstimate(
    lenderName: "US Bank",
    interestRate: 4.2,
    isFixedRate: true,
    loanAmount: 920000,
    loanTerm: 30,
    monthlyPayment: 3599.17,
    closingCosts: 1000,
    newClosingCosts: 500,
    newMonthlyPayments: 3400,
  );

  // simple loan; 30 years
  static LoanEstimate simpleLoanV3 = LoanEstimate(
    lenderName: "Chase Bank",
    interestRate: 4.5,
    isFixedRate: true,
    loanAmount: 920000,
    loanTerm: 30,
    monthlyPayment: 3729.20,
    closingCosts: 1000,
    newClosingCosts: 500,
    newMonthlyPayments: 3000,
  );

  // adjustable rate loan; 7 year ARM
  static LoanEstimate getArjunLoanEstimate = LoanEstimate(
      lenderName: "Chase Bank",
      interestRate: 3.785,
      isFixedRate: false,
      loanAmount: 920000,
      loanTerm: 30,
      monthlyPayment: 4327.12,
      fixedRateLoanTerm: 7,
      closingCosts: 1000);

  // fixed rate loan; 15 years
  static LoanEstimate getHellyLoanEstimate = LoanEstimate(
      lenderName: "PNC Bank",
      interestRate: 2.785,
      isFixedRate: true,
      loanAmount: 1200000,
      loanTerm: 15,
      monthlyPayment: 5212.12,
      closingCosts: 10000);
}
