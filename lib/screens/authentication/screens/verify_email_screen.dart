import 'package:approval_ai/widgets/primary_cta.dart';
import 'package:flutter/material.dart';
import 'package:approval_ai/screens/authentication/widgets/header.dart';
import 'package:go_router/go_router.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  void _onPressBackToLogin(BuildContext context) {
    context.push('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Header(
                  label: 'Verify your email',
                  subheading:
                      "You're almost there! Just click on the link in the email to complete your sign up and get started.",
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    PrimaryCta(
                      label: "Back to Login",
                      // pass context to login
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
