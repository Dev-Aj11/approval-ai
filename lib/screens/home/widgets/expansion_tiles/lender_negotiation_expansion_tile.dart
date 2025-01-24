import 'package:approval_ai/screens/home/model/estimate_data.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/expansion_tile_dropdown.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/expansion_tile_helper.dart';
import 'package:approval_ai/screens/home/widgets/metric_info.dart';
import 'package:flutter/material.dart';

class LenderNegotiationExpansionTile extends StatefulWidget {
  final LoanEstimateData initialLoanEstimate;
  final LoanEstimateData finalLoanEstimate;
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
  LenderNegotiationExpansionTile({
    required this.initialLoanEstimate,
    required this.finalLoanEstimate,
    super.key,
  });

  @override
  State<LenderNegotiationExpansionTile> createState() =>
      _LenderNegotiationExpansionTileState();
}

class _LenderNegotiationExpansionTileState
    extends State<LenderNegotiationExpansionTile> {
  late String selectedValue;

  @override
  void initState() {
    selectedValue = widget.defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: false, // change to true when editing
      iconColor: Colors.black,
      shape: ExpansionTileHelper.getBorderStyle(false),
      collapsedShape: ExpansionTileHelper.getBorderStyle(true),
      title: _buildHeader(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return ExpansionTileHelper.buildExpansionTileHeader(
      title: "Negotiation Analysis",
      icon: Icons.attach_money,
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildButtonRow(),
        _buildMetrics(),
      ],
    );
  }

  Widget _buildButtonRow() {
    return ExpansionTileDropdown(
      currValue: selectedValue,
      options: widget.termOptions,
      onSelect: (value) {
        setState(() {
          selectedValue = value;
        });
      },
    );
  }

  Widget _buildMetrics() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Wrap(
        spacing: 36,
        runSpacing: 24,
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.center,
        children: _getMetrics().entries.map((entry) {
          return SizedBox(
            width: 150,
            child: MetricInfo(
              metricName: entry.key,
              data: entry.value,
              centerData: true,
              isMoney: ExpansionTileHelper.isMoneyMetric(entry.key),
            ),
          );
        }).toList(),
      ),
    );
  }

  Map<String, String> _getMetrics() {
    int userSelectedLoanTerm = int.parse(selectedValue.split(" ")[0]);
    double initialTotalPayments =
        widget.initialLoanEstimate.getTotalPayments(userSelectedLoanTerm);
    double finalTotalPayments =
        widget.finalLoanEstimate.getTotalPayments(userSelectedLoanTerm);
    var totalSavings = initialTotalPayments - finalTotalPayments;
    return {
      "Total Payments": initialTotalPayments.floor().toString(),
      "Negotiated Total Payments": finalTotalPayments.floor().toString(),
      "Total Savings": totalSavings.floor().toString(),
    };
  }
}
