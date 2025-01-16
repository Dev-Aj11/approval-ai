import 'package:approval_ai/models/loan_estimate.dart';
import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/estimate_analysis_tile.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/messages_exchanged_tile.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/negotiation_analysis_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LenderExpansionTile extends StatelessWidget {
  final LenderMetricData lenderData;
  const LenderExpansionTile({required this.lenderData, super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: false, // change to true when editing
      iconColor: Colors.black,
      shape: _buildExpansionTileBorderStyle(false),
      collapsedShape: _buildExpansionTileBorderStyle(true),
      title: _builExpansionTileHeader(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: _buildExpandedTileContent(),
        ),
      ],
    );
  }

  _buildExpansionTileBorderStyle(isCollapsed) {
    if (isCollapsed) {
      return Border(top: BorderSide(color: Colors.grey[300]!, width: 1));
    } else {
      return Border(top: BorderSide(color: Colors.grey[600]!, width: 1));
    }
  }

  _builExpansionTileHeader() {
    var header = lenderData.tileHeader;
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

  _buildExpandedTileContent() {
    if (lenderData is LenderDataMessagesExchanged) {
      return LenderMessagesExchangedTile(lenderData: lenderData);
    } else if (lenderData is LenderDataEstimateAnalysis) {
      return LenderEstimateAnalysisTile(
        lenderData: lenderData,
        loanEstimate: SampleLoanEstimates.simpleLoan,
      );
    } else if (lenderData is LenderDataNegotiationAnalysis) {
      return LenderNegotiationAnalysisTile(
        lenderData: lenderData,
        loanEstimate: SampleLoanEstimates.simpleLoan,
      );
    }
  }
}
