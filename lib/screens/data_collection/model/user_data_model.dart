class UserData {
  final String firstName;
  final String lastName;
  final int grossIncome;
  final int ssn;
  final String address;
  final int loanAmount;
  final int purchasePrice;

  UserData({
    required this.firstName,
    required this.lastName,
    required this.grossIncome,
    required this.ssn,
    required this.address,
    required this.loanAmount,
    required this.purchasePrice,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'grossIncome': grossIncome,
        'ssn': ssn,
        'address': address,
        'loanAmount': loanAmount,
        'purchasePrice': purchasePrice,
      };

  // Create from JSON
  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        firstName: json['firstName'],
        lastName: json['lastName'],
        grossIncome: json['grossIncome'],
        ssn: json['ssn'],
        address: json['address'],
        loanAmount: json['loanAmount'],
        purchasePrice: json['purchasePrice'],
      );
}

class LenderPreference {
  final bool selectAll;
  final bool retail;
  final bool wholesale;
  final bool creditUnions;

  LenderPreference({
    required this.selectAll,
    required this.retail,
    required this.wholesale,
    required this.creditUnions,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() => {
        'selectAll': selectAll,
        'retail': retail,
        'wholesale': wholesale,
        'creditUnions': creditUnions,
      };

  // Create from JSON
  factory LenderPreference.fromJson(Map<String, dynamic> json) =>
      LenderPreference(
        selectAll: json['selectAll'],
        retail: json['retail'],
        wholesale: json['wholesale'],
        creditUnions: json['creditUnions'],
      );
}

class LoanPreference {
  final String type;
  final int term;

  LoanPreference({required this.type, required this.term});

  // Convert to JSON
  Map<String, dynamic> toJson() => {
        'type': type,
        'term': term,
      };
  // Create from JSON
  factory LoanPreference.fromJson(Map<String, dynamic> json) => LoanPreference(
        type: json['type'],
        term: json['term'],
      );
}
