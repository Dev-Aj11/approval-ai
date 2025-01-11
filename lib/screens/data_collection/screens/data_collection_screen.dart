import 'package:approval_ai/screens/data_collection/screens/lenders_details_form.dart';
import 'package:approval_ai/screens/data_collection/screens/loan_type_details_form.dart';
import 'package:approval_ai/screens/data_collection/screens/user_data_form.dart';
import 'package:approval_ai/screens/data_collection/screens/verification_details_form.dart';
import 'package:approval_ai/screens/data_collection/widgets/step_indicator.dart';
import 'package:approval_ai/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class DataCollectionScreen extends StatefulWidget {
  const DataCollectionScreen({super.key});

  @override
  State<DataCollectionScreen> createState() => _DataCollectionScreenState();
}

class _DataCollectionScreenState extends State<DataCollectionScreen> {
  int currentStep = 0;

  Widget _buildCustomForm() {
    switch (currentStep) {
      case 0:
        return UserDataForm(onComplete: updateStep);
      case 1:
        return LoanTypeDetailsForm(onComplete: updateStep);
      case 2:
        return LenderDetailsForm(onComplete: updateStep);
      case 3:
        return VerificationDetailsForm(onComplete: updateStep);
      default:
        return Placeholder();
    }
  }

  PreferredSizeWidget _buildCustomAppBar() {
    return CustomAppBar(
      buttons: [
        ButtonConfig(label: "Cancel", onPress: () {}),
        ButtonConfig(label: "Save & Exit", onPress: () {}),
      ],
    );
  }

  void updateStep() {
    setState(() {
      if (currentStep < 3) {
        currentStep = currentStep + 1;
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildCustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(64.0, 72, 64, 72),
          child: Center(
            child: SizedBox(
              width: 590,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepIndicator(currentStep: currentStep),
                  SizedBox(height: 43),
                  _buildCustomForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
