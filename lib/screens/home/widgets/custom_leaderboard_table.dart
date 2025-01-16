// import 'package:approval_ai/screens/home/model/lender_data.dart';
// import 'package:approval_ai/screens/home/widgets/expansion_tiles/expansion_tile_button.dart';
// import 'package:approval_ai/screens/home/widgets/metric_info.dart';
// import 'package:approval_ai/screens/home/widgets/styles.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// // custom_leaderboard_table.dart
// class CustomLeaderboardTable extends StatelessWidget {
//   final List<LenderLeaderboardMetric> rankings = [
//     LenderLeaderboardMetric(
//         rankImage: "assets/img/rank_1.png",
//         name: "Chase Bank",
//         monthlyPayments: "3.75%",
//         totalPayments: "\$45,000"),
//     LenderLeaderboardMetric(
//         rankImage: "assets/img/rank_2.png",
//         name: "US Bank",
//         monthlyPayments: "3.85%",
//         totalPayments: "\$55,000"),
//     LenderLeaderboardMetric(
//         rankImage: "assets/img/rank_3.png",
//         name: "Bank of America",
//         monthlyPayments: "4.05%",
//         totalPayments: "\$65,000"),
//     // ... other rankings
//   ];

//   CustomLeaderboardTable({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       final isDesktop = constraints.maxWidth > 600;

//       return Container(
//         width: isDesktop ? double.infinity : 330,
//         decoration: isDesktop ? LeaderboardStyles.getDesktopStyle() : null,
//         padding: isDesktop
//             ? EdgeInsets.symmetric(horizontal: 36, vertical: 24)
//             : EdgeInsets.zero,
//         child: isDesktop
//             ? DesktopLeaderboard(rankings: rankings)
//             : MobileLeaderboard(rankings: rankings),
//       );
//     });
//   }
// }

// class DesktopLeaderboard extends StatelessWidget {
//   final List<LenderLeaderboardMetric> rankings;
//   const DesktopLeaderboard({required this.rankings, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildHeader(),
//         ...rankings.map((ranking) => _buildRow(ranking)),
//       ],
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         border: Border(bottom: BorderSide(color: Color(0xffD9D9D9))),
//       ),
//       child: Row(
//         children: [
//           Expanded(flex: 1, child: Text("Rank")),
//           Expanded(flex: 2, child: Text("Lender")),
//           Expanded(flex: 2, child: Text("Interest Rate")),
//           Expanded(flex: 2, child: Text("Total Payments")),
//           Opacity(
//             opacity: 0,
//             child: ExpansionTileButton(
//               label: "Connect",
//               icon: Icons.message_outlined,
//               onPress: () {},
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRow(LenderLeaderboardMetric ranking) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 16),
//       child: Row(
//         spacing: 24,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 1,
//             child: Container(
//               alignment: Alignment.centerLeft,
//               child: RankImage(imagePath: ranking.rankImage),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Container(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 ranking.name,
//                 style: LeaderboardStyles.getLenderNameStyle(),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Container(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 ranking.monthlyPayments,
//                 style: LeaderboardStyles.getMetricStyle(),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Container(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 ranking.totalPayments,
//                 style: LeaderboardStyles.getMetricStyle(),
//               ),
//             ),
//           ),
//           Container(
//             alignment: Alignment.centerLeft,
//             child: ExpansionTileButton(
//               label: "Connect",
//               icon: Icons.message_outlined,
//               onPress: () {},
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MobileLeaderboard extends StatelessWidget {
//   final List<LenderLeaderboardMetric> rankings;

//   const MobileLeaderboard({required this.rankings, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       spacing: 24,
//       children: rankings.map((ranking) => _buildLenderCard(ranking)).toList(),
//     );
//   }

//   Widget _buildLenderCard(ranking) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: Color(0xffD9D9D9),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Wrap(
//             children: [
//               RankImage(imagePath: ranking.rankImage),
//               SizedBox(width: 20),
//               Text(
//                 ranking.name,
//                 style: GoogleFonts.playfairDisplay(
//                     fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           Wrap(
//             children: [
//               MetricInfo(
//                 data: ranking.interestRate,
//                 metricName: "Interest Rate",
//                 centerData: true,
//               ),
//               SizedBox(width: 20),
//               MetricInfo(
//                 data: ranking.totalPayments,
//                 metricName: "Total payments",
//                 centerData: true,
//               )
//             ],
//           ),
//           SizedBox(height: 32),
//           ExpansionTileButton(
//             label: "Connect",
//             icon: Icons.message_outlined,
//             onPress: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }

// class RankImage extends StatelessWidget {
//   final String imagePath;
//   const RankImage({required this.imagePath, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Image.asset(
//       imagePath,
//       width: 50,
//       height: 50,
//       fit: BoxFit.contain,
//     );
//   }
// }
