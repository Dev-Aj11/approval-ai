import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:approval_ai/screens/home/widgets/custom_headings.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/lender_expansion_tile.dart';
import 'package:flutter/material.dart';

class LenderCardScreen extends StatelessWidget {
  final LenderData lenderData;

  const LenderCardScreen({required this.lenderData, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getLenderCardStyle(),
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildLenderTitleRow(),
          _buildMetricsExpansionTiles(lenderData.metrics),
        ],
      ),
    );
  }

  _getLenderCardStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: Color(0xffD9D9D9),
        width: 1,
      ),
    );
  }

  // build metrics expansion tiles if metrics exist in LenderData
  _buildMetricsExpansionTiles(
      Map<LenderDetailsEnum, LenderMetricData> metrics) {
    var messages = LenderDetailsEnum.messagesExchagned;
    var estimate = LenderDetailsEnum.estimateAnalysis;
    var negotiation = LenderDetailsEnum.negotiationAnalysis;

    return Column(
      children: [
        metrics.containsKey(messages)
            ? LenderExpansionTile(lenderData: metrics[messages]!)
            : SizedBox(),
        metrics.containsKey(estimate)
            ? LenderExpansionTile(lenderData: metrics[estimate]!)
            : SizedBox(),
        metrics.containsKey(negotiation)
            ? LenderExpansionTile(lenderData: metrics[negotiation]!)
            : SizedBox(),
      ],
    );
  }

  _buildLenderTitleRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _buildMobileLenderInfo();
        }
        return _buildDesktopLenderInfo();
        // Default layout for larger screens
      },
    );
  }

  _buildMobileLenderInfo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LenderImg(lenderImg: lenderData.logoUrl),
          SizedBox(height: 8),
          _buildLenderMetadata(),
          SizedBox(height: 16),
          LenderStatusBadge(type: lenderData.currStatus),
        ],
      ),
    );
  }

  _buildDesktopLenderInfo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          LenderImg(lenderImg: lenderData.logoUrl),
          SizedBox(width: 24),
          Expanded(child: _buildLenderMetadata()),
          LenderStatusBadge(type: lenderData.currStatus),
        ],
      ),
    );
  }

  _buildLenderMetadata() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LenderHeading(lenderName: lenderData.name),
        SizedBox(height: 8),
        Row(
          children: [
            CustomLenerDetails(
              icon: Icons.account_balance_outlined,
              lenderInfo: lenderData.type,
            ),
            SizedBox(width: 24),
            CustomLenerDetails(
              icon: Icons.person_outlined,
              lenderInfo: lenderData.loanOfficer,
            ),
          ],
        ),
      ],
    );
  }
}
