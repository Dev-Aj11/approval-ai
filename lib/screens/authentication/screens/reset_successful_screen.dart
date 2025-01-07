import 'package:approval_ai/widgets/primary_cta.dart';
import 'package:flutter/material.dart';
import 'package:approval_ai/screens/authentication/widgets/header.dart';

class ResetSuccessfulScreen extends StatelessWidget {
  const ResetSuccessfulScreen({super.key});

  void _onPressBackToLogin(context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Create Header
              Expanded(
                  flex: 1,
                  child: Header(
                      label: 'Check your inbox',
                      subheading:
                          "We've sent you an email. Follow the instructions to access your account.",
                      newAccount: true)),
              // Create Sign Up Form
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    PrimaryCta(
                      label: "Back to login",
                      onPressCb: () => _onPressBackToLogin(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
