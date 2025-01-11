import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:approval_ai/screens/home/model/overview_data.dart';
import 'package:approval_ai/screens/home/widgets/custom_headings.dart';
import 'package:approval_ai/screens/home/widgets/custom_lender_expansion_tile.dart';
import 'package:flutter/material.dart';

class CustomLenderCard extends StatelessWidget {
  final String lender;
  final Status status;
  late final String lenderName;
  late final String lenderImg;
  late final String lenderType;
  late final String lenderLoanOfficer;

  CustomLenderCard({required this.lender, required this.status, super.key}) {
    lenderName = kLenderDetails[lender]!["name"]!;
    lenderImg = kLenderDetails[lender]!["logo"]!;
    lenderType = kLenderDetails[lender]!["type"]!;
    lenderLoanOfficer = kLenderDetails[lender]!["loanOfficer"]!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffD9D9D9),
          width: 1,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildLenderTitleRow(),
          CustomLenderExpansionTile(details: LenderDetails.messagesExchagned),
          CustomLenderExpansionTile(details: LenderDetails.estimateAnalysis),
          CustomLenderExpansionTile(details: LenderDetails.negotiationAnalysis)
        ],
      ),
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
          LenderImg(lenderImg: lenderImg),
          SizedBox(height: 8),
          _buildLenderMetadata(),
          SizedBox(height: 16),
          LenderStatusBadge(type: status),
        ],
      ),
    );
  }

  _buildDesktopLenderInfo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          LenderImg(lenderImg: lenderImg),
          SizedBox(width: 24),
          Expanded(child: _buildLenderMetadata()),
          LenderStatusBadge(type: status),
        ],
      ),
    );
  }

  _buildLenderMetadata() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LenderHeading(lenderName: lenderName),
        SizedBox(height: 8),
        Row(
          children: [
            CustomLenerDetails(
                icon: Icons.account_balance_outlined, lenderInfo: lenderType),
            SizedBox(width: 24),
            CustomLenerDetails(
                icon: Icons.person_outlined, lenderInfo: lenderLoanOfficer),
          ],
        ),
      ],
    );
  }
}
