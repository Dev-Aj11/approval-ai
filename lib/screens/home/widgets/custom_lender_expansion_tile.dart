import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:approval_ai/screens/home/widgets/custom_lender_button.dart';
import 'package:approval_ai/screens/home/widgets/custom_overview_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLenderExpansionTile extends StatelessWidget {
  final LenderDetails details;
  const CustomLenderExpansionTile({required this.details, super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: Border(
        top: BorderSide(color: Colors.grey[600]!, width: 1),
      ),
      collapsedShape: Border(
        top: BorderSide(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12),
        child: Row(
          children: [
            Icon(kLenderExpansionCard[details]!.icon, color: Colors.black),
            SizedBox(width: 8),
            Text(
              kLenderExpansionCard[details]!.title,
              style:
                  GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLenderButton(
                label: "Download Messages",
                icon: Icons.download,
                onPress: () {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Row(
                  children: [
                    Expanded(
                      child: MetricInfo(
                        data: "234",
                        metricName: "Documents Shared",
                        centerData: true,
                      ),
                    ),
                    Expanded(
                      child: MetricInfo(
                        data: "234",
                        metricName: "Documents Shared",
                        centerData: true,
                      ),
                    ),
                    Expanded(
                      child: MetricInfo(
                        data: "234",
                        metricName: "Documents Shared",
                        centerData: true,
                      ),
                    ),
                    Expanded(
                      child: MetricInfo(
                        data: "234",
                        metricName: "Documents Shared",
                        centerData: true,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
