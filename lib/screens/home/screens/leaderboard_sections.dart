import 'package:approval_ai/models/loan_estimate.dart';
import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:approval_ai/screens/home/widgets/custom_headings.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/expansion_tile_button.dart';
import 'package:approval_ai/screens/home/widgets/metric_info.dart';
import 'package:approval_ai/screens/home/widgets/styles.dart';
import 'package:approval_ai/widgets/table_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardSections {
  static Widget buildLeaderboardHeaderWithFilter(selectedValue, onSelect) {
    return Row(
      children: [
        Expanded(child: CustomSubHeading(label: "Best Deals")),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: DropdownButton<String>(
              value: selectedValue, // Your currently selected value
              icon: Icon(Icons.keyboard_arrow_down),
              underline: Container(), // Removes the default underline
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              iconEnabledColor: Colors.black,
              dropdownColor: Colors.white, // Background color of dropdown
              focusColor: Colors.transparent,
              items: [
                '5 years',
                '10 years',
                '15 years',
                '20 years',
                '30 years',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text("Payments over $value"),
                );
              }).toList(),
              onChanged: (String? newValue) => onSelect(newValue)),
        ),
      ],
    );
  }

  static Widget buildLeaderboardSubheading() {
    return Text(
      "We've crunched the numbers (so you don't have to). Here are the best deals so far!",
      style: TableHelper.getRowStyle(),
    );
  }

  static Widget buildLeaderboardTable(
      List<LoanEstimate> bestLoanEstimates, userSelectedLoanTerm) {
    final List<LenderLeaderboardMetric> rankings =
        List.generate(bestLoanEstimates.length, (index) {
      String rankImage = _getImgPath(index);
      String monthlyPayments =
          bestLoanEstimates[index].monthlyPayment.floor().toString();
      String totalPayments = bestLoanEstimates[index]
          .getTotalPayments(userSelectedLoanTerm)
          .toString();

      return LenderLeaderboardMetric(
        rankImage: rankImage,
        name: bestLoanEstimates[index].lenderName,
        monthlyPayments: "\$$monthlyPayments",
        totalPayments: "\$$totalPayments",
      );
    });

    return LayoutBuilder(builder: (context, constraints) {
      final isDesktop = constraints.maxWidth > 900;
      return Container(
        width: double.infinity,
        decoration: isDesktop ? LeaderboardStyles.getDesktopStyle() : null,
        child: isDesktop
            ? DesktopLeaderboard(rankings: rankings)
            : MobileLeaderboard(rankings: rankings),
      );
    });
  }

  static String _getImgPath(index) {
    if (index == 0) {
      return "assets/img/rank_1.png";
    } else if (index == 1) {
      return "assets/img/rank_2.png";
    }
    return "assets/img/rank_3.png";
  }
}

class DesktopLeaderboard extends StatelessWidget {
  final List<LenderLeaderboardMetric> rankings;
  final List<String> columns = [
    'rank',
    'lender',
    'monthlyPayment',
    'totalPayments',
    ""
  ];
  DesktopLeaderboard({required this.rankings, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        ...rankings.map((ranking) => _buildRow(ranking, context)),
      ],
    );
  }

  Widget _buildHeader() {
    return TableHelper.buildLeaderboardTableHeader(columns);
  }

  String _formatMoney(data) {
    final value = int.parse(data.replaceAll("\$", ""));
    return '\$${(value).toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )}';
  }

  Widget _buildRow(LenderLeaderboardMetric ranking, BuildContext context) {
    return TableHelper.buildTableRow(
      lenderData: null,
      lenderLeaderboardData: ranking,
      columns: columns,
      context: context,
    );
  }
}

class MobileLeaderboard extends StatelessWidget {
  final List<LenderLeaderboardMetric> rankings;

  const MobileLeaderboard({required this.rankings, super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      direction: Axis.horizontal,
      children: rankings.map((ranking) => _buildLenderCard(ranking)).toList(),
    );
  }

  String _formatMoney(data) {
    final value = int.parse(data.replaceAll("\$", ""));
    return '\$${(value).toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )}';
  }

  Widget _buildLenderCard(ranking) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffD9D9D9),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              RankImage(imagePath: ranking.rankImage),
              SizedBox(width: 20),
              Text(
                ranking.name,
                style: GoogleFonts.playfairDisplay(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16),
          Wrap(
            children: [
              MetricInfo(
                data: _formatMoney(ranking.monthlyPayments),
                metricName: "Monthly Payment",
                centerData: true,
              ),
              SizedBox(width: 20),
              MetricInfo(
                data: _formatMoney(ranking.totalPayments),
                metricName: "Total Payments",
                centerData: true,
              )
            ],
          ),
          SizedBox(height: 32),
          ExpansionTileButton(
            label: "Connect",
            icon: Icons.message_outlined,
            onPress: () {},
          ),
        ],
      ),
    );
  }
}

class RankImage extends StatelessWidget {
  final String imagePath;
  const RankImage({required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: 50,
      height: 50,
      fit: BoxFit.contain,
    );
  }
}
