import 'package:approval_ai/screens/home/model/overview_data.dart';
import 'package:approval_ai/screens/home/widgets/metric_info.dart';
import 'package:flutter/material.dart';

class CustomOverviewCard extends StatelessWidget {
  final String metricData;
  final LenderStatusEnum metricType;
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
