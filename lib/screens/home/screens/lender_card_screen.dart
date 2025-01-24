import 'package:approval_ai/screens/home/model/estimate_data.dart';
import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:approval_ai/screens/home/widgets/custom_headings.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/lender_estimate_expansion_tile.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/lender_messages_expansion_tile.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/lender_negotiation_expansion_tile.dart';
import 'package:flutter/material.dart';

class LenderCardScreen extends StatelessWidget {
  final LenderData lenderData;

  const LenderCardScreen({required this.lenderData, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getLenderCardStyle(),
      width: 1100,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildLenderTitleRow(),
          SizedBox(height: 12),
          _buildMetricsExpansionTiles(),
        ],
      ),
    );
  }

  _getLenderCardStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: Color(0xffDDDDDD),
        width: 1,
      ),
    );
  }

  // build metrics expansion tiles if metrics exist in LenderData
  _buildMetricsExpansionTiles() {
    return Column(children: [
      _buildMessagesExpansionTile(),
      _buildLenderEstimateAnalysisExpansionTile(),
      _buildLenderNegotiationAnalysisExpansionTile(),
    ]);
  }

  _buildMessagesExpansionTile() {
    bool messagesExist =
        lenderData.messages != null && lenderData.messages!.isNotEmpty;
    if (!messagesExist) {
      return SizedBox();
    }
    return LenderMessagesExpansionTile(
      lenderMessages: lenderData.messages,
      emailsExchanged: lenderData.emailsExchanged,
      phoneCallsExchanged: lenderData.phoneCallsExchanged,
      textsExchanged: lenderData.textsExchanged,
    );
  }

  _buildLenderEstimateAnalysisExpansionTile() {
    List<LoanEstimateData>? loanEstimatesData = lenderData.estimateData;
    // get most recent and initial estimate
    LoanEstimateData? mostRecentEstimate;
    if (loanEstimatesData != null) {
      mostRecentEstimate = lenderData.mostRecentEstimate;
      return LenderEstimateAnalysisExpansionTile(
        loanEstimate: mostRecentEstimate!,
      );
    }
    return SizedBox.shrink();
  }

  _buildLenderNegotiationAnalysisExpansionTile() {
    List<LoanEstimateData>? loanEstimatesData = lenderData.estimateData;
    // get most recent and initial estimate
    LoanEstimateData? mostRecentEstimate;
    LoanEstimateData? initialEstimate;
    if (loanEstimatesData != null) {
      mostRecentEstimate = lenderData.mostRecentEstimate;
      if (loanEstimatesData.length > 1) {
        initialEstimate = lenderData.initialEstimate;
        return LenderNegotiationExpansionTile(
          initialLoanEstimate: initialEstimate!,
          finalLoanEstimate: mostRecentEstimate!,
        );
      }
    }
    return SizedBox.shrink();
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
