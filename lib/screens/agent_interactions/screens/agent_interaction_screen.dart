import 'package:approval_ai/screens/agent_interactions/screens/filter_dialog_screen.dart';
import 'package:approval_ai/screens/agent_interactions/widgets/interaction_table.dart';
import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:approval_ai/screens/home/model/overview_data.dart';
import 'package:approval_ai/screens/home/widgets/custom_headings.dart';
import 'package:flutter/material.dart';

class AgentInteractionScreen extends StatefulWidget {
  final List<LenderData> lenderData;
  final bool isLoading;
  const AgentInteractionScreen(
      {super.key, required this.lenderData, required this.isLoading});

  @override
  State<AgentInteractionScreen> createState() => _AgentInteractionScreenState();
}

class _AgentInteractionScreenState extends State<AgentInteractionScreen> {
  Map<LenderStatusEnum, bool> filterStates = {
    LenderStatusEnum.contacted: true,
    LenderStatusEnum.received: true,
    LenderStatusEnum.negotiating: true,
    LenderStatusEnum.complete: true,
  };

  @override
  Widget build(BuildContext context) {
    final filteredInteractions = widget.lenderData.where((lender) {
      return filterStates[lender.currStatus[0]] ?? true;
    }).toList();

    return widget.isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              _buildHeader(context),
              SizedBox(height: 16),
              _buildInteractionsTable(context, filteredInteractions),
            ],
          );
  }

  _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomSubHeading(label: "AI Agent Interactions"),
          ElevatedButton(
            onPressed: () async {
              final newFilterStates = await showDialog(
                context: context,
                builder: (context) => FilterDialog(filterStates: filterStates),
              );
              if (newFilterStates != null) {
                setState(() {
                  filterStates = newFilterStates;
                });
              }
            },
            style: _getFilterButtonStyle(),
            child: Row(
              children: [
                Icon(Icons.filter_list, color: Colors.black),
                SizedBox(width: 4),
                Text("Filter", style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildInteractionsTable(context, List<LenderData> filteredLenderData) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InteractionTable(
        lenderData: filteredLenderData,
      ),
    );
  }

  _getFilterButtonStyle() {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.grey.shade100;
        } else if (states.contains(WidgetState.hovered)) {
          return Colors.grey.shade200;
        }
        return Colors.white;
      }),
      foregroundColor: WidgetStateProperty.all(Colors.black),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      elevation: WidgetStateProperty.all(0),
      side: WidgetStateProperty.all(
        BorderSide(color: Colors.grey.shade300, width: 1),
      ),
    );
  }
}
