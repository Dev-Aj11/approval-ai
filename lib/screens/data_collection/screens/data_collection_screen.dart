import 'package:approval_ai/firebase_functions.dart';
import 'package:approval_ai/screens/data_collection/model/user_data_model.dart';
import 'package:approval_ai/screens/data_collection/screens/loan_type_details_form.dart';
import 'package:approval_ai/screens/data_collection/screens/user_data_form.dart';
import 'package:approval_ai/screens/data_collection/screens/verification_details_form.dart';
import 'package:approval_ai/screens/data_collection/widgets/step_indicator.dart';
import 'package:approval_ai/screens/how_it_works/screens/how_it_works.dart';
import 'package:approval_ai/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:approval_ai/controllers/auth_provider.dart';
import 'package:provider/provider.dart';

class DataCollectionScreen extends StatefulWidget {
  const DataCollectionScreen({super.key});

  @override
  State<DataCollectionScreen> createState() => _DataCollectionScreenState();
}

class _DataCollectionScreenState extends State<DataCollectionScreen> {
  int currentStep = 0;
  Map<String, dynamic> userInfoAndPreferences = {};

  Widget _buildCustomForm(context) {
    switch (currentStep) {
      case 0:
        return UserDataForm(
            onComplete: (UserData userData) =>
                onUserDataComplete(userData, context));
      case 1:
        return LoanTypeDetailsForm(
            onComplete: (LoanPreference loanData) =>
                onLoanTypeComplete(loanData, context));
      // case 2:
      //   return LenderDetailsForm(
      //     onComplete: (LenderPreference lenderData) =>
      //         onLenderTypeComplete(lenderData),
      //   );
      case 2:
        return VerificationDetailsForm(
            onComplete: (acceptedTerms) =>
                onVerificationComplete(acceptedTerms, context));
      default:
        return Placeholder();
    }
  }

  PreferredSizeWidget _buildCustomAppBar() {
    return CustomAppBar(
      buttons: [
        ButtonConfig(
          label: "Cancel",
          onPress: () {
            context.go('/zerostatehome');
          },
        ),
      ],
    );
  }

  void updateStep(BuildContext context) {
    setState(() {
      if (currentStep < 2) {
        currentStep = currentStep + 1;
      } else {
        FirebaseFunctions.addUserDetails({'userData': userInfoAndPreferences});
        context.read<AuthProvider>().setOnboardingComplete(true);
        context.go('/home');
        // show dialog after navigating to home page
        Future.delayed(Duration(milliseconds: 100), () {
          showDialog(
            context: context,
            builder: (context) => const HowItWorksScreen(),
            barrierDismissible: false,
          );
        });
      }
    });
  }

  void onUserDataComplete(UserData userData, context) {
    userInfoAndPreferences["personalInfo"] = userData.toJson();
    updateStep(context);
  }

  void onLoanTypeComplete(LoanPreference loanTypeData, context) {
    userInfoAndPreferences["loanPreference"] = loanTypeData.toJson();
    updateStep(context);
  }

  // void onLenderTypeComplete(LenderPreference lenderTypeData) {
  //   userInfoAndPreferences["lenderPreference"] = lenderTypeData.toJson();
  //   updateStep();
  // }

  void onVerificationComplete(acceptedTerms, context) {
    userInfoAndPreferences["acceptedTerms"] = acceptedTerms;
    updateStep(context);
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
                  _buildCustomForm(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
