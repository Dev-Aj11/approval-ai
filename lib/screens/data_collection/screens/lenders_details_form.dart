import 'package:approval_ai/screens/data_collection/model/user_data_model.dart';
import 'package:approval_ai/screens/data_collection/model/user_options.dart';
import 'package:approval_ai/screens/data_collection/widgets/custom_check_box.dart';
import 'package:approval_ai/screens/data_collection/widgets/custom_heading.dart';
import 'package:approval_ai/widgets/custom_field_heading.dart';
import 'package:approval_ai/widgets/primary_cta.dart';
import 'package:flutter/material.dart';

class LenderDetailsForm extends StatefulWidget {
  final Function(LenderPreference) onComplete;
  const LenderDetailsForm({required this.onComplete, super.key});

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

  _buildFormHeader() {
    return Center(
      child: CustomHeading(label: "Select your\npreferred lenders"),
    );
  }

  _buildLenderOptions() {
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
        ),
      ],
    );
  }

  Widget _buildCTA() {
    LenderPreference lenderPreference = LenderPreference(
      selectAll: isChecked[0],
      retail: isChecked[1],
      wholesale: isChecked[2],
      creditUnions: isChecked[3],
    );
    return PrimaryCta(
      label: "Next",
      smallSize: true,
      onPressCb: () => widget.onComplete(lenderPreference),
      isEnabled: isChecked.contains(true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormHeader(),
        SizedBox(height: 40.0),
        _buildLenderOptions(),
        SizedBox(height: 40),
        _buildCTA(),
      ],
    );
  }
}
