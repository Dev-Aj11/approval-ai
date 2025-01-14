import 'package:approval_ai/screens/home/model/overview_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOverviewCard extends StatelessWidget {
  final String metricData;
  final Status metricType;
  const CustomOverviewCard({
    required this.metricData,
    required this.metricType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffD9D9D9),
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(22),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Circular icon container
          kMetricInfo[metricType]!.getMetricIcon(),
          SizedBox(width: 24),
          // Text column
          MetricInfo(
            data: metricData,
            metricName: kMetricInfo[metricType]!.getMetricName(),
          ),
        ],
      ),
    );
  }
}

class MetricInfo extends StatelessWidget {
  final String data;
  final String metricName;
  final bool centerData;
  const MetricInfo(
      {required this.data,
      required this.metricName,
      this.centerData = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          centerData ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          data,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          metricName,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
