import 'package:approval_ai/firebase_functions.dart';
import 'package:approval_ai/screens/home/model/overview_data.dart';
import 'package:approval_ai/screens/home/screens/leaderboard_screen.dart';
import 'package:approval_ai/screens/home/widgets/custom_lender_card.dart';
import 'package:approval_ai/screens/home/widgets/custom_overview_card.dart';
import 'package:approval_ai/screens/home/widgets/custom_headings.dart';
import 'package:approval_ai/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:approval_ai/screens/home/model/lender_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<LenderData> _lenderData = [];
  bool _isLoading = true;

  void initState() {
    super.initState();
    _getLenderData();
  }

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

  Future<void> _getLenderData() async {
    try {
      final querySnapshotOnLenders = await FirebaseFunctions.getLenderDetails();
      final documentSnapshotOnUsers = await FirebaseFunctions.getUserData();
      final userInfo = documentSnapshotOnUsers.data() as Map<String, dynamic>;
      final userLenderStatusInfo = userInfo["lenderData"];

      final updatedLenderData =
          querySnapshotOnLenders.docs.map((lenderDataDoc) {
        final lenderInfo = lenderDataDoc.data() as Map<String, dynamic>;
        final loanOfficerInfo =
            lenderInfo['loanOfficer'] as Map<String, dynamic>;
        final lenderName = lenderInfo['name'];
        return LenderData(
          name: lenderName,
          type: lenderInfo['bankType'],
          logoUrl: lenderInfo['logoUrl'],
          loanOfficer: loanOfficerInfo.keys.first,
          metrics: _buildLenderMetrics(userLenderStatusInfo[lenderDataDoc.id]),
        );
      }).toList();

      setState(() {
        _lenderData = updatedLenderData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // You might want to show an error message here
    }
  }

  Map<LenderDetailsEnum, LenderMetricData> _buildLenderMetrics(
      userLenderStatus) {
    final metrics = <LenderDetailsEnum, LenderMetricData>{};
    if (userLenderStatus['messagesExchanged'] != null) {
      final messagesExchanged = userLenderStatus['messagesExchanged'];
      metrics[LenderDetailsEnum.messagesExchagned] =
          LenderDataMessagesExchanged(
        emailsExchanged: messagesExchanged['emailsExchanged'],
        textMessages: messagesExchanged['textMessages'],
        phoneCalls: messagesExchanged['phoneCalls'],
      );
    }

    if (userLenderStatus['estimateAnalysis'] != null) {
      final estimateAnalysis = userLenderStatus['estimateAnalysis'];
      metrics[LenderDetailsEnum.estimateAnalysis] = LenderDataEstimateAnalysis(
        interestRate: estimateAnalysis['interestRate'],
        lenderPayments: estimateAnalysis['lenderPayments'],
        totalPayments: estimateAnalysis['totalPayments'],
      );
    }

    if (userLenderStatus['negotiationAnalysis'] != null) {
      final negotiationAnalysis = userLenderStatus['negotiationAnalysis'];
      metrics[LenderDetailsEnum.negotiationAnalysis] =
          LenderDataNegotiationAnalysis(
        totalSavings: negotiationAnalysis['totalSavings'],
        initialTotalPayments: negotiationAnalysis['initialTotalPayments'],
        negotiatedTotalPayments: negotiationAnalysis['negotiatedTotalPayments'],
      );
    }
    return metrics;
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
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSubHeading(label: "Lenders"),
        SizedBox(height: 24),
        ..._lenderData.map(
          (lenderData) => Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: CustomLenderCard(lenderData: lenderData),
          ),
        ),
      ],
    );
  }
}
