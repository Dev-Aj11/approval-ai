import 'package:approval_ai/models/loan_estimate.dart';
import 'package:approval_ai/screens/home/controller/home_controller.dart';
import 'package:approval_ai/screens/home/model/overview_data.dart';
import 'package:approval_ai/screens/home/screens/home_sections.dart';
import 'package:approval_ai/screens/home/screens/leaderboard_screen.dart';
import 'package:approval_ai/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:approval_ai/screens/home/model/lender_data.dart';

// TODO: this should pull from firebase
final kLoanEstimates = [
  SampleLoanEstimates.simpleLoan,
  SampleLoanEstimates.simpleLoanV2,
  SampleLoanEstimates.simpleLoanV3,
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final HomeController _controller = HomeController();
  List<LenderData> _lenderData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await _controller.getLenderData();
    setState(() {
      _lenderData = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // udpate this to see leaderboard
    // check if at least one estimate is received to load leaderboard
    bool oneEstimateReceived =
        _controller.lenderStatusCount[LenderStatusEnum.received]! > 0;
    return Scaffold(
      appBar: CustomAppBar(
        buttons: [
          ButtonConfig(label: "Home", onPress: () {}),
          ButtonConfig(
              label: "Logout", onPress: () => _controller.signOut(context)),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        // get parent widget's width
        final width = constraints.maxWidth;
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeScreenSections.buildWelcomeHeader(),
                SizedBox(height: 50),
                HomeScreenSections.buildOverviewStats(
                    _controller.lenderStatusCount),
                SizedBox(height: 56),
                // load this only if estimates are received
                // change this
                (oneEstimateReceived)
                    ? Column(children: [
                        LeaderboardScreen(loanEstimates: kLoanEstimates),
                        SizedBox(height: 56)
                      ])
                    : SizedBox(height: 0),
                HomeScreenSections.buildLenderDetails(_isLoading, _lenderData),
              ],
            ),
          ),
        );
      }),
    );
  }
}
