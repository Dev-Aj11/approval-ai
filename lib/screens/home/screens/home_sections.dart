import 'package:approval_ai/screens/home/model/overview_data.dart';
import 'package:approval_ai/screens/home/screens/lender_card_screen.dart';
import 'package:approval_ai/screens/home/widgets/custom_headings.dart';
import 'package:approval_ai/screens/home/widgets/custom_overview_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:approval_ai/screens/home/model/lender_data.dart';

class HomeScreenSections {
  static Widget buildWelcomeHeader() {
    return Text(
      "Welcome, Sam! 👋",
      style: GoogleFonts.playfairDisplay(
          fontSize: 48, fontWeight: FontWeight.w600),
    );
  }

  static Widget buildOverviewStats(
      Map<LenderStatusEnum, int> lenderStatusCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSubHeading(label: "Overview"),
        SizedBox(height: 24),
        Wrap(
          spacing: 24.0,
          runSpacing: 16,
          children: List.generate(
            LenderStatusEnum.values.length,
            (index) {
              var metricName = LenderStatusEnum.values[index];
              return CustomOverviewCard(
                metricData:
                    lenderStatusCount[metricName]!.toString(), // 4, 3, 2, 1
                metricType: metricName,
              );
            },
          ),
        ),
      ],
    );
  }

  static Widget buildLenderDetails(
      bool isLoading, List<LenderData> lenderData) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSubHeading(label: "Lenders"),
        SizedBox(height: 24),
        ...lenderData.map(
          (lenderData) => Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: LenderCardScreen(lenderData: lenderData),
          ),
        ),
      ],
    );
  }
}
