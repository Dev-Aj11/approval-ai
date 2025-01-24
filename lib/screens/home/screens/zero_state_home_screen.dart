import 'package:approval_ai/widgets/custom_app_bar.dart';
import 'package:approval_ai/widgets/primary_cta.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:approval_ai/controllers/auth_provider.dart';

class ZeroStateHomeScreen extends StatelessWidget {
  const ZeroStateHomeScreen({super.key});

  Future<void> _onPressLogout(BuildContext context) async {
    try {
      await context.read<AuthProvider>().logout();
      context.go('/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign out failed: $e')),
      );
    }
  }

  _onPressGetStarted(BuildContext context) {
    context.push('/datacollection');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        buttons: [
          ButtonConfig(
            label: "Logout",
            onPress: () => _onPressLogout(context),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelomceHeader(context),
              SizedBox(height: 50),
              _buildSubHeading(context),
            ],
          ),
        ),
      ),
    );
  }

  _buildWelomceHeader(BuildContext context) {
    return Text(
      "Welcome! 👋",
      style: GoogleFonts.playfairDisplay(
          fontSize: 32, fontWeight: FontWeight.w600),
    );
  }

  _buildSubHeading(context) {
    return Center(
      child: Column(
        children: [
          _buildImage(context),
          Text(
            "Savings Await",
            style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
          SizedBox(height: 14),
          Container(
            constraints: BoxConstraints(minWidth: 200, maxWidth: 450),
            child: Column(
              children: [
                Text(
                  "Save thousands of dollars. Our AI helps you find and negotiate the best mortgage deals on the market.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 50),
                PrimaryCta(
                  label: "Get Started",
                  onPressCb: () => _onPressGetStarted(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImage(context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive image size
        double imageSize = constraints.maxWidth * 0.5;
        imageSize = imageSize.clamp(200.0, 400.0); // Min and max size

        return Image.asset(
          'assets/img/stack-of-money.png',
          width: imageSize,
          height: imageSize,
          fit: BoxFit.contain,
        );
      },
    );
  }
}
