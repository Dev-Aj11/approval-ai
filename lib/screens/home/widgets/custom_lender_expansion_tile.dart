import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:approval_ai/screens/home/widgets/custom_lender_button.dart';
import 'package:approval_ai/screens/home/widgets/custom_overview_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLenderExpansionTile extends StatelessWidget {
  final LenderDetails details;
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
              _buildExpandedTileButtonRow(),
              _buildExpandedTileMetrics()
            ],
          ),
        ),
      ],
    );
  }

  _builExpansionTileHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12),
      child: Row(
        children: [
          Icon(kLenderExpansionTileCardHeader[details]!.icon,
              color: Colors.black),
          SizedBox(width: 8),
          Text(
            kLenderExpansionTileCardHeader[details]!.title,
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  _buildExpandedTileButtonRow() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: List.generate(
        kLenderExpansionTileButtonRow[details]!.length,
        (index) {
          return CustomExpansionTileButtons(
              label: kLenderExpansionTileButtonRow[details]![index].btnTitle,
              icon: kLenderExpansionTileButtonRow[details]![index].icon,
              onPress: kLenderExpansionTileButtonRow[details]![index].onPress);
        },
      ),
    );
  }

  _buildExpandedTileMetrics() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Wrap(
        spacing: 36,
        runSpacing: 24,
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.center,
        children: List.generate(
          kLenderExpansionTileMetrics[details]!.length,
          (index) {
            return SizedBox(
              width: 150,
              child: MetricInfo(
                metricName: kLenderExpansionTileMetrics[details]![index].title,
                data: kLenderExpansionTileMetrics[details]![index].data,
                centerData: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
