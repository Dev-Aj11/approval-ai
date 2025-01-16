import 'package:approval_ai/models/loan_estimate.dart';
import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/expansion_tile_dropdown.dart';
import 'package:approval_ai/screens/home/widgets/metric_info.dart';
import 'package:flutter/material.dart';

const kMoneyMetrics = [
  "Lender Payments",
  "Total Payments",
  "Total Savings",
  "Monthly Payment",
  "Principal Paid Off",
  "Initial Total Payments",
  "Negotiated Total Payments"
];

class LenderNegotiationAnalysisTile extends StatefulWidget {
  final LenderMetricData lenderData;
  final LoanEstimate loanEstimate;
  // this should be max loan term length
  final String defaultValue = "30 years";
  // this shoud be flexible based on the loan term length
  final List<String> termOptions = [
    "5 years",
    "10 years",
    "15 years",
    "20 years",
    "25 years",
    "30 years"
  ];
  LenderNegotiationAnalysisTile({
    super.key,
    required this.lenderData,
    required this.loanEstimate,
  });

  @override
  State<LenderNegotiationAnalysisTile> createState() => _LenderNeState();
}

class _LenderNeState extends State<LenderNegotiationAnalysisTile> {
  late String selectedValue;

  @override
  void initState() {
    selectedValue = widget.defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildButonRow(),
        _buildMetrics(),
      ],
    );
  }

  _buildButonRow() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        ExpansionTileDropdown(
          currValue: selectedValue,
          options: widget.termOptions,
          onSelect: (value) {
            setState(() {
              selectedValue = value;
            });
          },
        ),
      ],
    );
  }

  _buildMetrics() {
    Map<String, String> metrics = _getMetrics();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Wrap(
        spacing: 36,
        runSpacing: 24,
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.center,
        children: metrics.entries.map(
          (entry) {
            return SizedBox(
              width: 150,
              child: MetricInfo(
                metricName: entry.key,
                data: entry.value,
                centerData: true,
                isMoney: kMoneyMetrics.contains(entry.key),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  _getMetrics() {
    int userSelectedLoanTerm = int.parse(selectedValue.split(" ")[0]);
    return {
      "Total Payments": widget.loanEstimate
          .getTotalPayments(userSelectedLoanTerm)
          .floor()
          .toString(),
      "Negotiated Total Payments": widget.loanEstimate
          .getRevisedTotalPayments(userSelectedLoanTerm)!
          .floor()
          .toString(),
      "Total Savings": widget.loanEstimate
          .getTotalSavings(userSelectedLoanTerm)!
          .floor()
          .toString(),
    };
  }
}
