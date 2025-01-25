import 'package:approval_ai/screens/agent_interactions/screens/agent_interaction_screen.dart';
import 'package:approval_ai/screens/home/controller/home_controller.dart';
import 'package:approval_ai/screens/home/screens/home_sections.dart';
import 'package:approval_ai/screens/home/screens/leaderboard_screen.dart';
import 'package:approval_ai/screens/how_it_works/screens/how_it_works.dart';
import 'package:approval_ai/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// TODO: this should pull from firebase
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller & State Management
  final HomeController _controller = HomeController();
  List<LenderData> _lenderDataItems = [];
  bool _isLoading = true;
  String _firstName = "";

  // Lifecycle Methods
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// Fetches initial data from the controller
  Future<void> _loadData() async {
    final data = await _controller.getLenderData();
    final firstName = await _controller.getUserFirstName();
    setState(() {
      _lenderDataItems = data;
      _isLoading = false;
      _firstName = firstName;
    });
  }

  /// Builds the top navigation buttons for desktop view
  List<ButtonConfig> _buildAppBarButtons() {
    return [
      ButtonConfig(
        label: "Home",
        onPress: () => _controller.setCurrentPage("Home"),
      ),
      ButtonConfig(
        label: "Messages",
        onPress: () => _controller.setCurrentPage("Messages"),
      ),
      ButtonConfig(
        label: "How it works",
        onPress: () => showDialog(
          context: context,
          builder: (BuildContext context) => const HowItWorksScreen(),
        ),
      ),
      ButtonConfig(
        label: "Logout",
        onPress: () => _controller.signOut(context),
      ),
    ];
  }

  /// Builds the main dashboard content
  Widget _buildDashboard() {
    final recentLoanEstimates =
        _controller.getRecentLoanEstimatesForEachLender(_lenderDataItems);

    return ChangeNotifierProvider(
      create: (context) => _controller,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Welcome Section
            HomeScreenSections.buildWelcomeHeader(_firstName),
            const SizedBox(height: 48),

            // Stats Section
            HomeScreenSections.buildOverviewStats(
                _controller.lenderStatusCount, _controller),
            const SizedBox(height: 48),

            // Divider
            _buildDivider(),
            const SizedBox(height: 48),

            // Leaderboard Section (conditional)
            if (recentLoanEstimates.isNotEmpty) ...[
              LeaderboardScreen(loanEstimates: recentLoanEstimates),
              const SizedBox(height: 56),
              _buildDivider(),

              // Divider
              const SizedBox(height: 48),
            ],

            // Lender Interactions
            HomeScreenSections.buildLenderInteractions(
                _isLoading, _lenderDataItems),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  /// Helper method to build consistent dividers
  Widget _buildDivider() {
    return Container(
      width: 1100,
      child: const Divider(color: Color(0xffdddddd), thickness: 1),
    );
  }

  _buildInteractions() {
    return AgentInteractionScreen(
        isLoading: _isLoading, lenderData: _lenderDataItems);
  }

  // on mobile, show drawer
  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xffE8F3FE)),
            child: Text(
              'Menu',
              style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          ),
          ..._buildAppBarButtons().map((button) => ListTile(
                title: Text(button.label,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  button.onPress();
                },
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        final bool isMobile = MediaQuery.of(context).size.width < 768;

        return Scaffold(
          appBar: CustomAppBar(
            buttons: isMobile ? [] : _buildAppBarButtons(),
            leading: isMobile
                ? IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  )
                : null,
          ),
          drawer: isMobile ? _buildDrawer() : null,
          body: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.10,
                    vertical: 40,
                  ),
                  child: (_controller.currentPage == "Home")
                      ? _buildDashboard()
                      : _buildInteractions(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
