import 'package:approval_ai/screens/home/model/overview_data.dart';
import 'package:approval_ai/screens/home/screens/leaderboard_screen.dart';
import 'package:approval_ai/screens/home/widgets/custom_lender_card.dart';
import 'package:approval_ai/screens/home/widgets/custom_overview_card.dart';
import 'package:approval_ai/screens/home/widgets/custom_headings.dart';
import 'package:approval_ai/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  HomeScreen({super.key});

  Future<void> _signOut(context) async {
    try {
      await _auth.signOut();
      Navigator.pushNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign out failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        buttons: [
          ButtonConfig(label: "Home", onPress: () {}),
          ButtonConfig(label: "Logout", onPress: () => _signOut(context)),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        // get parent widget's width
        final width = constraints.maxWidth;
        return SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeHeader(),
                SizedBox(height: 50),
                _buildOverviewStats(),
                SizedBox(height: 56),
                _buildLeaderboard(),
                SizedBox(
                  height: 56,
                ),
                _buildLenderDetails(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildWelcomeHeader() {
    return Text(
      "Welcome, Sam! 👋",
      style: GoogleFonts.playfairDisplay(
          fontSize: 48, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildOverviewStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSubHeading(label: "Overview"),
        SizedBox(height: 24),
        Wrap(
          spacing: 24.0,
          runSpacing: 16,
          children: List.generate(
            Status.values.length,
            (index) {
              return CustomOverviewCard(
                metricData: "${Status.values.length - index}", // 4, 3, 2, 1
                metricType: Status.values[index],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboard() {
    return LeaderboardScreen();
  }

  Widget _buildLenderDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSubHeading(label: "Lenders"),
        SizedBox(height: 24),
        CustomLenderCard(
          lender: "US Bank",
          status: Status.contacted,
        ),
        SizedBox(height: 24),
        CustomLenderCard(
          lender: "Wells Fargo",
          status: Status.received,
        ),
        SizedBox(height: 24),
        CustomLenderCard(
          lender: "Citi Bank",
          status: Status.complete,
        ),
        SizedBox(height: 24),
        CustomLenderCard(
          lender: "Chase Bank",
          status: Status.complete,
        )
      ],
    );
  }
}
