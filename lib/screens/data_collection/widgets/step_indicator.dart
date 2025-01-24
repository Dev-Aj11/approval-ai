import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Step Indicator Widget
class StepIndicator extends StatelessWidget {
  final List<String> steps;
  final int currentStep;

  const StepIndicator({
    this.steps = const ['Overview', 'Loans', 'Verification'],
    required this.currentStep,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(steps.length * 2 - 1, (index) {
        if (index.isEven) {
          final stepIndex = index ~/ 2;
          return Column(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: stepIndex <= currentStep
                    ? Color(0xFF0065FE)
                    : Color(0xFFEAEAEA),
                child: Text(
                  '${stepIndex + 1}',
                  style: TextStyle(
                    color: stepIndex <= currentStep
                        ? Colors.white
                        : Color(0xff6D6B6B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Text(
                steps[stepIndex],
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: stepIndex <= currentStep
                        ? FontWeight.w500
                        : FontWeight.w400),
              ),
            ],
          );
        } else {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Divider(
                color: index ~/ 2 < currentStep
                    ? Color(0xFF0065FE)
                    : Color(0xFFEAEAEA),
                thickness: 1,
              ),
            ),
          );
        }
      }),
    );
  }
}
