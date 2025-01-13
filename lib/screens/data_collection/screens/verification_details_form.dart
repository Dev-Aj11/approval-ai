import 'package:approval_ai/screens/data_collection/model/user_options.dart';
import 'package:approval_ai/screens/data_collection/widgets/custom_check_box.dart';
import 'package:approval_ai/screens/data_collection/widgets/custom_heading.dart';
import 'package:approval_ai/widgets/custom_field_heading.dart';
import 'package:approval_ai/widgets/primary_cta.dart';
import 'package:flutter/material.dart';

class VerificationDetailsForm extends StatefulWidget {
  final Function(bool) onComplete;
  const VerificationDetailsForm({required this.onComplete, super.key});

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

  Widget _buildFormHeading() {
    return Center(child: CustomHeading(label: "One last thing..."));
  }

  Widget _buildVerificaitonOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
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
          ),
        ],
      ),
    );
  }

  Widget _buildCTA() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: PrimaryCta(
        label: "Submit",
        onPressCb: () => widget.onComplete(true),
        smallSize: true,
        isEnabled: !isChecked.contains(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormHeading(),
        SizedBox(height: 40.0),
        _buildVerificaitonOptions(),
        SizedBox(height: 50),
        _buildCTA()
      ],
    );
  }
}
