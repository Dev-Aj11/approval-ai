import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:approval_ai/screens/home/widgets/custom_lender_button.dart';
import 'package:approval_ai/screens/home/widgets/custom_overview_card.dart';
import 'package:approval_ai/screens/home/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// custom_leaderboard_table.dart
class CustomLeaderboardTable extends StatelessWidget {
  final List<LenderRanking> rankings = [
    LenderRanking(
        rankImage: "assets/img/rank_1.png",
        name: "Chase Bank",
        interestRate: "3.75%",
        totalPayments: "\$45,000"),
    LenderRanking(
        rankImage: "assets/img/rank_2.png",
        name: "US Bank",
        interestRate: "3.85%",
        totalPayments: "\$55,000"),
    LenderRanking(
        rankImage: "assets/img/rank_3.png",
        name: "Bank of America",
        interestRate: "4.05%",
        totalPayments: "\$65,000"),
    // ... other rankings
  ];

  CustomLeaderboardTable({super.key});

  @override
  Widget build(BuildContext context) {
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
}

class DesktopLeaderboard extends StatelessWidget {
  final List<LenderRanking> rankings;
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
    return LeaderboardHeader();
  }

  Widget _buildRow(LenderRanking ranking) {
    return LeaderboardRow(ranking: ranking);
  }
}

class MobileLeaderboard extends StatelessWidget {
  final List<LenderRanking> rankings;

  const MobileLeaderboard({required this.rankings, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      children:
          rankings.map((ranking) => LenderCard(ranking: ranking)).toList(),
    );
  }
}

class LenderCard extends StatelessWidget {
  final LenderRanking ranking;
  const LenderCard({required this.ranking, super.key});

  @override
  Widget build(BuildContext context) {
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
                data: ranking.interestRate,
                metricName: "Interest Rate",
                centerData: true,
              ),
              SizedBox(width: 20),
              MetricInfo(
                data: ranking.totalPayments,
                metricName: "Total payments",
                centerData: true,
              )
            ],
          ),
          SizedBox(height: 32),
          CustomExpansionTileButtons(
            label: "Connect",
            icon: Icons.message_outlined,
            onPress: () {},
          ),
        ],
      ),
    );
  }
}

// widgets/leaderboard_header.dart
class LeaderboardHeader extends StatelessWidget {
  const LeaderboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: CustomExpansionTileButtons(
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

// widgets/leaderboard_row.dart
class LeaderboardRow extends StatelessWidget {
  final LenderRanking ranking;

  const LeaderboardRow({required this.ranking, super.key});

  @override
  Widget build(BuildContext context) {
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
                ranking.interestRate,
                style: LeaderboardStyles.getMetricStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                ranking.totalPayments,
                style: LeaderboardStyles.getMetricStyle(),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: CustomExpansionTileButtons(
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





/*
class CustomLeaderboardTable extends StatelessWidget {
  const CustomLeaderboardTable({super.key});

  _getDesktopLeaderboardStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: Color(0xffD9D9D9),
        width: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double screenWidth = constraints.maxWidth;
      bool isDesktop = screenWidth > 600;
      return Container(
        width: (isDesktop) ? double.infinity : 300,
        decoration:
            (isDesktop) ? _getDesktopLeaderboardStyle() : BoxDecoration(),
        padding: (isDesktop)
            ? EdgeInsets.symmetric(horizontal: 36, vertical: 24)
            : EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLeaderboardHeader(screenWidth),
            _buildLenderRankings(screenWidth),
          ],
        ),
      );
    });
  }

  _buildLeaderboardHeader(screenWidth) {
    if (screenWidth < 600) {
      return SizedBox.shrink();
    }
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xffD9D9D9))),
      ),
      child: Row(
        spacing: 24,
        children: [
          Expanded(flex: 1, child: Text("Rank")),
          Expanded(flex: 2, child: Text("Lender")),
          Expanded(flex: 2, child: Text("Interest Rate")),
          Expanded(flex: 2, child: Text("Total Payments")),
          Opacity(
            opacity: 0,
            child: CustomExpansionTileButtons(
              label: "Connect",
              icon: Icons.message_outlined,
              onPress: () {},
            ),
          ),
        ],
      ),
    );
  }

  _buildLenderRankings(screenWidth) {
    if (screenWidth < 600) {
      return _buildMobileLenderRankings();
    } else {
      return _buildDesktopLenderRankings();
    }
  }

  _buildDesktopLenderRankings() {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        children: [
          _buildDesktopLenderRankingsRow(
              "assets/img/rank_1.png", "Chase Bank", "3.75%", "\$45,000"),
          _buildDesktopLenderRankingsRow(
              "assets/img/rank_2.png", "Wells Fargo", "3.9%", "\$48,000"),
          _buildDesktopLenderRankingsRow(
              "assets/img/rank_3.png", "US Bank", "4.1%", "\$50,000"),
        ],
      ),
    );
  }

  _buildMobileLenderRankings() {
    return Column(
      spacing: 24,
      children: [
        _buildMobileLenderRankingCard(
            "assets/img/rank_1.png", "US Bank", "3.75%", "\$45,000"),
        _buildMobileLenderRankingCard(
            "assets/img/rank_2.png", "Wells Fargo", "3.75%", "\$45,000"),
        _buildMobileLenderRankingCard(
            "assets/img/rank_3.png", "Chase Bank", "3.75%", "\$45,000"),
      ],
    );
  }

  _buildMobileLenderRankingCard(
      rankImgPath, lenderName, interestRate, totalPayments) {
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
              Image.asset(
                rankImgPath,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 20),
              Text(
                lenderName,
                style: GoogleFonts.playfairDisplay(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16),
          Wrap(
            children: [
              MetricInfo(
                data: interestRate,
                metricName: "Interest Rate",
                centerData: true,
              ),
              SizedBox(width: 20),
              MetricInfo(
                data: totalPayments,
                metricName: "Total payments",
                centerData: true,
              )
            ],
          ),
          SizedBox(height: 32),
          CustomExpansionTileButtons(
            label: "Connect",
            icon: Icons.message_outlined,
            onPress: () {},
          ),
        ],
      ),
    );
  }

  _buildDesktopLenderRankingsRow(
      rankingImg, lenderName, interestRate, totalPayments) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        spacing: 24,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                rankingImg,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(lenderName,
                style: GoogleFonts.playfairDisplay(
                    fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 2,
            child: Text(
              interestRate,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              totalPayments,
              style:
                  GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          CustomExpansionTileButtons(
            label: "Connect",
            icon: Icons.message_outlined,
            onPress: () {},
          )
        ],
      ),
    );
  }
}
*/