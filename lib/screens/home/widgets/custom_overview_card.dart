import 'package:approval_ai/screens/home/model/overview_data.dart';
import 'package:approval_ai/screens/home/widgets/metric_info.dart';
import 'package:approval_ai/widgets/table_helper.dart';
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
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffD9D9D9),
          width: 1,
        ),
      ),
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 16, top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Text column
              MetricInfo(
                data: metricData,
                metricName: kMetricInfo[metricType]!.getMetricName(),
              ),
              SizedBox(width: 24),
              // Circular icon container
              kMetricInfo[metricType]!.buildMetricIcon(),
            ],
          ),
          SizedBox(height: 12),
          Container(
            width: 60,
            alignment: Alignment.centerLeft,
            child: TextButton(
              style: TableHelper.getButtonStyle(),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text("View"),
                  const SizedBox(width: 4),
                  Transform.translate(
                    offset: const Offset(0, 3),
                    child: const Icon(
                      Icons.chevron_right,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
