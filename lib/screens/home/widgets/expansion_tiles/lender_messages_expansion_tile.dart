import 'package:approval_ai/screens/agent_interactions/model/interaction_data.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/expansion_tile_button.dart';
import 'package:approval_ai/screens/home/widgets/expansion_tiles/expansion_tile_helper.dart';
import 'package:approval_ai/screens/home/widgets/metric_info.dart';
import 'package:flutter/material.dart';

class LenderMessagesExpansionTile extends StatelessWidget {
  final List<MessageData> lenderMessages;
  final int emailsExchanged;
  final int phoneCallsExchanged;
  final int textsExchanged;
  const LenderMessagesExpansionTile(
      {required this.lenderMessages,
      required this.emailsExchanged,
      required this.phoneCallsExchanged,
      required this.textsExchanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: false, // change to true when editing
      iconColor: Colors.black,
      shape: ExpansionTileHelper.getBorderStyle(false),
      collapsedShape: ExpansionTileHelper.getBorderStyle(true),
      title: _buildHeader(),
      children: _buildExpandedTileContent(),
    );
  }

  Widget _buildHeader() {
    return ExpansionTileHelper.buildExpansionTileHeader(
      title: "Messages Exchanged",
      icon: Icons.mail_outline,
    );
  }

  List<Widget> _buildExpandedTileContent() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildButonRow(),
            _buildMetrics(),
          ],
        ),
      )
    ];
  }

  Widget _buildButonRow() {
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

  Widget _buildMetrics() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Wrap(
        spacing: 36,
        runSpacing: 24,
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.center,
        children: _getMetrics().entries.map((entry) {
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

  Map<String, String> _getMetrics() {
    return {
      'Emails Exchanged': emailsExchanged.toString(),
      'Text Messages': textsExchanged.toString(),
      'Phone Calls': phoneCallsExchanged.toString(),
    };
  }
}
