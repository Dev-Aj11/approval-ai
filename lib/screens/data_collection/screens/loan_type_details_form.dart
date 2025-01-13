import 'package:approval_ai/screens/data_collection/model/user_data_model.dart';
import 'package:approval_ai/screens/data_collection/widgets/custom_drop_down.dart';
import 'package:approval_ai/widgets/custom_button_with_icon.dart';
import 'package:approval_ai/widgets/custom_field_heading.dart';
import 'package:approval_ai/widgets/primary_cta.dart';
import 'package:flutter/material.dart';
import 'package:approval_ai/screens/data_collection/widgets/custom_heading.dart';

class LoanTypeDetailsForm extends StatefulWidget {
  final Function(LoanPreference) onComplete;
  const LoanTypeDetailsForm({required this.onComplete, super.key});

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
    return Column(
      children: [
        CustomHeading(label: "Select your \npreferred loan type"),
        SizedBox(height: 40.0),
        Padding(
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
        ),
      ],
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
    // save to firebase - loanTermSelected and fixedSelected
    String loanType = fixedSelected ? "fixed" : "arm";
    int loanTerm = int.parse(loanTermSelected.split(" ")[0]);
    LoanPreference loanPreference =
        LoanPreference(type: loanType, term: loanTerm);
    widget.onComplete(loanPreference);
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
