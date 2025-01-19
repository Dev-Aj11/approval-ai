import 'package:approval_ai/screens/agent_interactions/model/interaction_data.dart';
import 'package:approval_ai/screens/agent_interactions/screens/messages_screen.dart';
import 'package:approval_ai/screens/agent_interactions/widgets/table_helper.dart';
import 'package:approval_ai/screens/home/widgets/custom_headings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InteractionTable extends StatelessWidget {
  final List<InteractionData> interactionData;
  const InteractionTable({super.key, required this.interactionData});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columns = TableConfig.getColumnsForScreenSize(screenWidth);

    return Column(
      children: [
        _buildTableHeader(columns),
        ...interactionData.map((data) => _buildRow(data, columns, context)),
      ],
    );
  }

  Widget _buildTableHeader(List<String> columns) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: columns
            .map((column) => Expanded(
                  flex: column == 'preview' ? 2 : 1,
                  child: Text(
                    TableConfig.columnHeaders[column]!,
                    style: TableHelper.getHeaderStyle(),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildRow(
      InteractionData data, List<String> columns, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:
            columns.map((column) => _buildCell(column, data, context)).toList(),
      ),
    );
  }

  Widget _buildCell(String column, InteractionData data, BuildContext context) {
    switch (column) {
      case 'lender':
        return Expanded(
          child: Text(data.lender, style: TableHelper.getLenderNameStyle()),
        );
      case 'status':
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LenderStatusBadge(type: data.status),
              ],
            ),
          ),
        );
      case 'lastContacted':
        return Expanded(
          child: Text(
            DateFormat('MMM d, h:mm a').format(data.lastContacted),
            style: TableHelper.getRowStyle(),
          ),
        );
      case 'messages':
        return Expanded(
          child: Text(
            data.messages.length.toString(),
            style: TableHelper.getRowStyle(),
          ),
        );
      case 'preview':
        return Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.preview, style: TableHelper.getRowStyle()),
              TableHelper.buildPreviewBtn(onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => MessagesScreen(interactionData: data),
                );
              }),
            ],
          ),
        );
      case 'estimate':
        return Expanded(
          child: data.estimateUrl != null
              ? TableHelper.buildEstimateBtn(onPressed: () {})
              : const SizedBox(),
        );
      default:
        return const Expanded(child: SizedBox());
    }
  }
}
