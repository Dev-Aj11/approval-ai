import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:approval_ai/widgets/table_helper.dart';
import 'package:flutter/material.dart';

// DONE. Hooked to firebase
class InteractionTable extends StatelessWidget {
  final List<LenderData> lenderData;
  const InteractionTable({super.key, required this.lenderData});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columns = TableConfig.getColumnsForScreenSize(screenWidth);

    return Column(
      children: [
        _buildTableHeader(columns),
        ...lenderData.map((data) => _buildRow(data, columns, context)),
      ],
    );
  }

  Widget _buildTableHeader(List<String> columns) {
    return TableHelper.buildInteractionTableHeader(columns);
  }

  Widget _buildRow(
      LenderData data, List<String> columns, BuildContext context) {
    return TableHelper.buildTableRow(
        lenderData: data, columns: columns, context: context);
  }
}
