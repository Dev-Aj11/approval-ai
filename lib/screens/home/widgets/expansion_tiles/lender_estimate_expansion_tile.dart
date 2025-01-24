import 'package:approval_ai/screens/home/model/estimate_data.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/expansion_tile_button.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/expansion_tile_dropdown.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/expansion_tile_helper.dart';
import 'package:approval_ai/screens/home/widgets/metric_info.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LenderEstimateAnalysisExpansionTile extends StatefulWidget {
  final LoanEstimateData loanEstimate;
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
  LenderEstimateAnalysisExpansionTile({required this.loanEstimate, super.key});

  @override
  State<LenderEstimateAnalysisExpansionTile> createState() =>
      _LenderEstimateAnalysisExpansionTileState();
}

class _LenderEstimateAnalysisExpansionTileState
    extends State<LenderEstimateAnalysisExpansionTile> {
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
      title: "Loan Estimate Analysis",
      icon: Icons.analytics_outlined,
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
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
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
          onPress: () async {
            final Uri url = Uri.parse(widget.loanEstimate.estimateUrl);
            if (!await launchUrl(url)) {
              throw Exception(
                  'Could not launch ${widget.loanEstimate.estimateUrl}');
            }
          },
        ),
      ],
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
    return {
      'Total Payments': widget.loanEstimate
          .getTotalPayments(userSelectedLoanTerm)
          .floor()
          .toString(),
      'Principal Paid Off': widget.loanEstimate
          .getPrincipalPaidOff(userSelectedLoanTerm)
          .floor()
          .toString(),
      'Monthly Payment':
          widget.loanEstimate.monthlyPaymentAndInterest.floor().toString(),
      'Interest Rate':
          "${widget.loanEstimate.loanDetails.interestRate.initial.toString()}%",
    };
  }
}
