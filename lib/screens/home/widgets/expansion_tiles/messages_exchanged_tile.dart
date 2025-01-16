import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/expansion_tile_button.dart';
import 'package:approval_ai/screens/home/widgets/metric_info.dart';
import 'package:flutter/material.dart';

class LenderMessagesExchangedTile extends StatelessWidget {
  final LenderMetricData lenderData;
  const LenderMessagesExchangedTile({super.key, required this.lenderData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildButonRow(),
        _buildMetrics(),
      ],
    );
  }

  _buildButonRow() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        ExpansionTileButton(
          icon: Icons.download,
          label: "Download Messages",
          onPress: () {},
        )
      ],
    );
  }

  _buildMetrics() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Wrap(
        spacing: 36,
        runSpacing: 24,
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.center,
        children: lenderData.toMap().entries.map((entry) {
          return SizedBox(
            width: 150,
            child: MetricInfo(
              metricName: entry.key,
              data: entry.value,
              centerData: true,
            ),
          );
        }).toList(),
      ),
    );
  }
}
