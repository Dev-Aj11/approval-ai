import 'package:approval_ai/models/loan_estimate.dart';
import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:approval_ai/screens/home/widgets/custom_headings.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/expansion_tile_button.dart';
import 'package:approval_ai/screens/home/widgets/metric_info.dart';
import 'package:approval_ai/screens/home/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardSections {
  static Widget buildLeaderboardHeaderWithFilter(selectedValue, onSelect) {
    return Row(
      children: [
        Expanded(child: CustomSubHeading(label: "Leaderboard")),
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
      final isDesktop = constraints.maxWidth > 600;
      return Container(
        width: isDesktop ? double.infinity : 330,
        decoration: isDesktop ? LeaderboardStyles.getDesktopStyle() : null,
        padding: isDesktop
            ? EdgeInsets.symmetric(horizontal: 36, vertical: 24)
            : EdgeInsets.zero,
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
  const DesktopLeaderboard({required this.rankings, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        ...rankings.map((ranking) => _buildRow(ranking)),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xffD9D9D9))),
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text("Rank")),
          Expanded(flex: 2, child: Text("Lender")),
          Expanded(flex: 2, child: Text("Interest Rate")),
          Expanded(flex: 2, child: Text("Total Payments")),
          Opacity(
            opacity: 0,
            child: ExpansionTileButton(
              label: "Connect",
              icon: Icons.message_outlined,
              onPress: () {},
            ),
          ),
        ],
      ),
    );
  }

  String _formatMoney(data) {
    final value = int.parse(data.replaceAll("\$", ""));
    return '\$${(value).toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )}';
  }

  Widget _buildRow(LenderLeaderboardMetric ranking) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        spacing: 24,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              child: RankImage(imagePath: ranking.rankImage),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                ranking.name,
                style: LeaderboardStyles.getLenderNameStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                _formatMoney(ranking.monthlyPayments),
                style: LeaderboardStyles.getMetricStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                _formatMoney(ranking.totalPayments),
                style: LeaderboardStyles.getMetricStyle(),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: ExpansionTileButton(
              label: "Connect",
              icon: Icons.message_outlined,
              onPress: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class MobileLeaderboard extends StatelessWidget {
  final List<LenderLeaderboardMetric> rankings;

  const MobileLeaderboard({required this.rankings, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
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
      width: double.infinity,
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
                metricName: "Monthly payments",
                centerData: true,
              ),
              SizedBox(width: 20),
              MetricInfo(
                data: _formatMoney(ranking.totalPayments),
                metricName: "Total payments",
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
