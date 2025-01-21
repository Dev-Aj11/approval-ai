import 'package:approval_ai/models/loan_estimate.dart';
import 'package:approval_ai/screens/agent_interactions/screens/agent_interaction_screen.dart';
import 'package:approval_ai/screens/home/controller/home_controller.dart';
import 'package:approval_ai/screens/home/model/overview_data.dart';
import 'package:approval_ai/screens/home/screens/home_sections.dart';
import 'package:approval_ai/screens/home/screens/leaderboard_screen.dart';
import 'package:approval_ai/screens/how_it_works/screens/how_it_works.dart';
import 'package:approval_ai/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:approval_ai/screens/home/model/lender_data.dart';

// TODO: this should pull from firebase
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final HomeController _controller = HomeController();
  List<LenderData> _lenderDataItems = [];
  String currentPage = "Home";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await _controller.getLenderData();
    setState(() {
      _lenderDataItems = data;
      _isLoading = false;
    });
  }

  _buildAppBarButtons() {
    return [
      ButtonConfig(
          label: "Home",
          onPress: () {
            setState(() => currentPage = "Home");
          }),
      ButtonConfig(
          label: "Messages",
          onPress: () {
            setState(() => currentPage = "Messages");
          }),
      ButtonConfig(
        label: "How it works",
        onPress: () => showDialog(
          context: context,
          builder: (BuildContext context) => const HowItWorksScreen(),
        ),
      ),
      ButtonConfig(
          label: "Logout", onPress: () => _controller.signOut(context)),
    ];
  }

  _buildDashboard() {
    // udpate this to see leaderboard
    // check if at least one estimate is received to load leaderboard
    final recentLoanEstimates =
        _controller.getRecentLoanEstimatesForEachLender(_lenderDataItems);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      HomeScreenSections.buildWelcomeHeader(),
      SizedBox(height: 50),
      HomeScreenSections.buildOverviewStats(_controller.lenderStatusCount),
      SizedBox(height: 56),
      // load leaderboard only if >=1 estimates is received
      (recentLoanEstimates.isNotEmpty)
          ? Column(children: [
              LeaderboardScreen(loanEstimates: recentLoanEstimates),
              SizedBox(height: 56)
            ])
          : SizedBox(height: 0),
      HomeScreenSections.buildLenderInteractions(_isLoading, _lenderDataItems),
    ]);
  }

  _buildInteractions() {
    return AgentInteractionScreen(
        isLoading: _isLoading, lenderData: _lenderDataItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        buttons: _buildAppBarButtons(),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // get parent widget's width
          final width = constraints.maxWidth;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: 40,
              ),
              child: (currentPage == "Home")
                  ? _buildDashboard()
                  : _buildInteractions(), // change this to
            ),
          );
        },
      ),
    );
  }
}
