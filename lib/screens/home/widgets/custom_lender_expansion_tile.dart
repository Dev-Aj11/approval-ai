import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:approval_ai/screens/home/widgets/custom_lender_button.dart';
import 'package:approval_ai/screens/home/widgets/custom_overview_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLenderExpansionTile extends StatelessWidget {
  final LenderMetricData details;
  const CustomLenderExpansionTile({required this.details, super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: false, // change to true when editing
      iconColor: Colors.black,
      shape: Border(top: BorderSide(color: Colors.grey[600]!, width: 1)),
      collapsedShape: Border(
        top: BorderSide(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      title: _builExpansionTileHeader(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _buildExpandedTileButtonRow(),
              _buildExpandedTileMetrics()
            ],
          ),
        ),
      ],
    );
  }

  _builExpansionTileHeader() {
    var header = details.tileHeader;
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12),
      child: Row(
        children: [
          Icon(header.icon, color: Colors.black),
          SizedBox(width: 8),
          Text(
            header.title,
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
/*
  _buildExpandedTileButtonRow() {
    var btnRow = LenderDetailsData.instance.getButtons(details);
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: List.generate(
        btnRow.length,
        (index) {
          return CustomExpansionTileButtons(
            label: btnRow[index].btnTitle,
            icon: btnRow[index].icon,
            onPress: btnRow[index].onPress,
          );
        },
      ),
    );
  }*/

  _buildExpandedTileMetrics() {
    Map<String, String> metrics = details.toMap();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Wrap(
        spacing: 36,
        runSpacing: 24,
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.center,
        children: metrics.entries
            .map(
              (entry) => SizedBox(
                width: 150,
                child: MetricInfo(
                  metricName: entry.key,
                  data: entry.value,
                  centerData: true,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
