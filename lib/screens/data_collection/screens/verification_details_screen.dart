import 'package:approval_ai/screens/data_collection/model/user_options.dart';
import 'package:approval_ai/widgets/custom_app_bar.dart';
import 'package:approval_ai/screens/data_collection/widgets/custom_check_box.dart';
import 'package:approval_ai/screens/data_collection/widgets/custom_heading.dart';
import 'package:approval_ai/screens/data_collection/widgets/step_indicator.dart';
import 'package:approval_ai/widgets/custom_field_heading.dart';
import 'package:approval_ai/widgets/primary_cta.dart';
import 'package:flutter/material.dart';

class VerificationDetailsScreen extends StatelessWidget {
  const VerificationDetailsScreen({super.key});

  void onPressNext(context) {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        buttons: [
          ButtonConfig(label: "Cancel", onPress: () {}),
          ButtonConfig(label: "Save & Exit", onPress: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(64.0, 72, 64, 72),
          child: Center(
            child: SizedBox(
              width: 590,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepIndicator(currentStep: 3),
                  SizedBox(height: 43),
                  Center(child: CustomHeading(label: "One last thing...")),
                  SizedBox(height: 40.0),
                  VerificationDetailsForm(),
                  SizedBox(height: 24.0),
                  PrimaryCta(
                    label: "Submit",
                    smallSize: true,
                    onPressCb: () => onPressNext(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VerificationDetailsForm extends StatefulWidget {
  const VerificationDetailsForm({super.key});

  @override
  State<VerificationDetailsForm> createState() =>
      _VerificationDetailsFormState();
}

class _VerificationDetailsFormState extends State<VerificationDetailsForm> {
  List<bool> isChecked = List.generate(kUserConsent.length, (index) => false);

  void onCheck(index, value) {
    setState(() {
      isChecked[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomFieldHeading(label: "I understand..."),
        SizedBox(height: 16),
        SingleChildScrollView(
          child: Column(
            children: List.generate(
              kUserConsent.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: CustomCheckBox(
                  heading: kUserConsent[index]["heading"]!,
                  subHeading: kUserConsent[index]["subheading"]!,
                  isChecked: isChecked[index],
                  onCheck: (value) {
                    onCheck(index, value);
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
