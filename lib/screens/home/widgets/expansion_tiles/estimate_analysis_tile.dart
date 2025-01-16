import 'package:approval_ai/models/loan_estimate.dart';
import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/expansion_tile_button.dart';
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

class LenderEstimateAnalysisTile extends StatefulWidget {
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
  LenderEstimateAnalysisTile(
      {super.key, required this.lenderData, required this.loanEstimate});

  @override
  State<LenderEstimateAnalysisTile> createState() =>
      _LenderEstimateAnalysisTileState();
}

class _LenderEstimateAnalysisTileState
    extends State<LenderEstimateAnalysisTile> {
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
        ExpansionTileButton(
          icon: Icons.open_in_new,
          label: "View Estimate",
          onPress: () {},
        )
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
    String principalPaidOff = widget.loanEstimate
        .getPrincipalPaidOff(userSelectedLoanTerm)
        .toString();
    String totalPayments =
        widget.loanEstimate.getTotalPayments(userSelectedLoanTerm).toString();
    Map<String, String> x = {
      "Total Payments": totalPayments,
      "Principal Paid Off": principalPaidOff,
      "Monthly Payment": widget.loanEstimate.monthlyPayment.floor().toString(),
      "Interest Rate": "${widget.loanEstimate.interestRate.toString()}%",
    };
    return x;
  }
}
