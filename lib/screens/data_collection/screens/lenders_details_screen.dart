import 'package:approval_ai/screens/data_collection/model/user_options.dart';
import 'package:approval_ai/screens/data_collection/widgets/custom_app_bar.dart';
import 'package:approval_ai/screens/data_collection/widgets/custom_check_box.dart';
import 'package:approval_ai/screens/data_collection/widgets/custom_heading.dart';
import 'package:approval_ai/screens/data_collection/widgets/step_indicator.dart';
import 'package:approval_ai/widgets/custom_field_heading.dart';
import 'package:approval_ai/widgets/primary_cta.dart';
import 'package:flutter/material.dart';

class LendersDetailsScreen extends StatelessWidget {
  const LendersDetailsScreen({super.key});

  void onPressNext(context) {
    Navigator.pushReplacementNamed(context, '/verification');
  }

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepIndicator(currentStep: 2),
                  SizedBox(height: 43),
                  Center(
                      child: CustomHeading(
                          label: "Select your\npreferred lenders")),
                  SizedBox(height: 40.0),
                  LenderDetailsForm(),
                  SizedBox(height: 24),
                  PrimaryCta(
                    label: "Next",
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

class LenderDetailsForm extends StatefulWidget {
  const LenderDetailsForm({super.key});

  @override
  State<LenderDetailsForm> createState() => _LenderDetailsFormState();
}

class _LenderDetailsFormState extends State<LenderDetailsForm> {
  List<bool> isChecked = List.generate(kLenderOptions.length, (index) => false);

  void onCheck(index, value) {
    setState(() {
      if (index == 0) {
        isChecked = isChecked.map((e) {
          // if select all is false, then make everything true
          if (!isChecked[0]) {
            return true;
          }
          return false;
        }).toList();
      } else {
        isChecked[index] = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomFieldHeading(label: "Lenders"),
        SizedBox(height: 16),
        SingleChildScrollView(
          child: Column(
            children: List.generate(
              kLenderOptions.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: CustomCheckBox(
                  heading: kLenderOptions[index]["heading"]!,
                  subHeading: kLenderOptions[index]["subheading"]!,
                  isChecked: isChecked[index],
                  // basically I'm passing a function that expects one parameter as input from customCheckBox
                  // then I'm running the code inside the curly braces when it calls the funciton on selection
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


/*
        CustomCheckBox(
          heading: "Retail Banks",
          subHeading:
              "Big Banks like Chase, Wells Fargo that provide lots of loan options ",
          isChecked: isChecked,
          onCheck: onCheck,
        )
        */