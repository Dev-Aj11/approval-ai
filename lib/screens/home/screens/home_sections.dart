import 'package:approval_ai/screens/home/model/overview_data.dart';
import 'package:approval_ai/screens/home/screens/lender_card_screen.dart';
import 'package:approval_ai/screens/home/widgets/custom_headings.dart';
import 'package:approval_ai/screens/home/widgets/custom_overview_card.dart';
import 'package:approval_ai/widgets/table_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:approval_ai/screens/home/controller/home_controller.dart';

class HomeScreenSections {
  static Widget buildWelcomeHeader(String firstName) {
    return Container(
      width: 1100,
      alignment: Alignment.centerLeft,
      child: Text(
        "Welcome, $firstName!",
        style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w600),
      ),
    );
  }

  static String constructUpdateStr(
      Map<LenderStatusEnum, int> lenderStatusCount) {
    int contacted = lenderStatusCount[LenderStatusEnum.contacted] ?? 0;
    int received = lenderStatusCount[LenderStatusEnum.received] ?? 0;
    int negotiating = lenderStatusCount[LenderStatusEnum.negotiating] ?? 0;
    int complete = lenderStatusCount[LenderStatusEnum.complete] ?? 0;

    if (received == 0) {
      return "We've reached out to $contacted lenders to gather loan estimates for you! Expect updates in 3-5 business days - hang tight!";
    } else if (received != 0 && negotiating == 0) {
      return "We've contacted $contacted lenders and received $received loan estimates. The negotiations are underway!";
    } else if (negotiating != 0 && complete == 0) {
      return "We are actively negotiating with $negotiating lenders to get you the best deal possible. Hang tight!";
    } else if (negotiating != 0 && complete != 0) {
      return "We've wrapped up negotiations with $complete lenders and are actively negotiating with $negotiating more. Hang tight.";
    } else {
      // negotiating == 0 && complete != 0
      return "The negotiations have concluded! We've successfully negotiated with $complete lenders.";
    }
  }

  static Widget buildOverviewStats(
      Map<LenderStatusEnum, int> lenderStatusCount, HomeController controller) {
    return Container(
      width: 1100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSubHeading(label: "Overview"),
          SizedBox(height: 8),
          Text(
            constructUpdateStr(lenderStatusCount),
            style: TableHelper.getRowStyle(),
          ),
          SizedBox(height: 24),
          Container(
            width: double.infinity,
            child: Wrap(
              spacing: 24,
              runSpacing: 24,
              // alignment: WrapAlignment.spaceBetween,
              children: List.generate(
                LenderStatusEnum.values.length,
                (index) {
                  var metricName = LenderStatusEnum.values[index];
                  return CustomOverviewCard(
                    metricData:
                        lenderStatusCount[metricName]!.toString(), // 4, 3, 2, 1
                    metricType: metricName,
                    controller: controller,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildLenderInteractions(
      bool isLoading, List<LenderData> lenderData) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSubHeading(label: "Lender Interactions"),
        SizedBox(height: 8),
        Text(
          "We are sweet-talking lenders over phone and emails. Here's the latest scoop...",
          style: TableHelper.getRowStyle(),
        ),
        SizedBox(height: 24),
        ...lenderData.map(
          (lenderData) => Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: LenderCardScreen(
              lenderData: lenderData,
            ),
          ),
        ),
      ],
    );
  }
}
