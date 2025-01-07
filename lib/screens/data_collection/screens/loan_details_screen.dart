import 'package:approval_ai/screens/data_collection/screens/user_details_screen.dart';
import 'package:approval_ai/screens/data_collection/widgets/custom_drop_down.dart';
import 'package:approval_ai/widgets/custom_button_with_icon.dart';
import 'package:approval_ai/widgets/custom_field_heading.dart';
import 'package:approval_ai/widgets/primary_cta.dart';
import 'package:flutter/material.dart';
import 'package:approval_ai/screens/data_collection/widgets/custom_heading.dart';
import '../widgets/step_indicator.dart';
import '../widgets/custom_app_bar.dart';

class LoanDetailsScreen extends StatelessWidget {
  const LoanDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(64.0, 72, 64, 72),
          child: Center(
            child: SizedBox(
              width: 590,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  StepIndicator(currentStep: 1),
                  SizedBox(height: 43),
                  CustomHeading(label: "Select your \npreferred loan type"),
                  SizedBox(height: 40.0),
                  LoanTypeDetailsForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoanTypeDetailsForm extends StatefulWidget {
  const LoanTypeDetailsForm({super.key});

  @override
  State<LoanTypeDetailsForm> createState() => _LoanTypeDetailsFormState();
}

class _LoanTypeDetailsFormState extends State<LoanTypeDetailsForm> {
  final fixedRateLoanOptions = ["30 years", "20 years", "15 years", "10 years"];
  final armRateLoanOptions = [
    "10 years fixed",
    "7 years fixed",
    "5 years fixed",
    "3 years fixed"
  ];
  bool fixedSelected = true;
  late String loanTermSelected;

  @override
  void initState() {
    loanTermSelected = fixedRateLoanOptions.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInterestRateSection(),
          SizedBox(height: 32),
          _buildTermLengthSection(),
          SizedBox(height: 48),
          PrimaryCta(label: "Next", onPressCb: () => onPressNext(context)),
        ],
      ),
    );
  }

  void fixedRateSelected() {
    setState(() {
      fixedSelected = true;
      loanTermSelected = fixedRateLoanOptions.first;
    });
  }

  void armRateSelected() {
    setState(() {
      fixedSelected = false;
      loanTermSelected = armRateLoanOptions.first;
    });
  }

  void termLengthSelected(value) {
    setState(() {
      loanTermSelected = value;
    });
  }

  void onPressNext(context) {
    // should run validator
    Navigator.pushReplacementNamed(context, '/lenders');
  }

  Widget _buildInterestRateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomFieldHeading(label: "Interest Rate"),
        SizedBox(height: 12),
        // placing buttons side by side when there is space
        // wrap to next line when there isn't enough space
        Wrap(
          runSpacing: 16, // vertical spacing once the buttons wrap
          children: [
            CustomButtonWithIcon(
              label: "Fixed Rate",
              icon: Icons.attach_money,
              onPress: fixedRateSelected,
              isSelected: fixedSelected,
            ),
            SizedBox(
              width: 16,
            ),
            CustomButtonWithIcon(
              label: "Adjustable Rate",
              icon: Icons.access_time,
              onPress: armRateSelected,
              isSelected: !fixedSelected,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTermLengthSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomFieldHeading(label: "Term Length"),
        SizedBox(
          height: 12,
        ),
        CustomDropdown(
          currValue: loanTermSelected,
          onSelect: termLengthSelected,
          options: fixedSelected ? fixedRateLoanOptions : armRateLoanOptions,
        ),
      ],
    );
  }
}
