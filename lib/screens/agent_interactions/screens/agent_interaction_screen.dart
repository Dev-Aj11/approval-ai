import 'package:approval_ai/screens/agent_interactions/model/interaction_data.dart';
import 'package:approval_ai/screens/agent_interactions/widgets/desktop_interaction_table.dart';
import 'package:approval_ai/screens/home/widgets/custom_headings.dart';
import 'package:flutter/material.dart';

class AgentInteractionScreen extends StatelessWidget {
  final List<InteractionData> interactionData;
  final bool isLoading;
  const AgentInteractionScreen(
      {super.key, required this.interactionData, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              _buildHeader(),
              _buildInteractionsTable(context),
            ],
          );
  }

  _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomSubHeading(label: "AI Agent Interactions"),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
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
            ),
            child: Row(
              children: [
                Icon(Icons.filter_list, color: Colors.black),
                SizedBox(width: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildInteractionsTable(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // if (screenWidth > 1400) {
    //   interactionTableType = InteractionTable(interactionData: interactionData);
    // } else if (screenWidth < 1400 && screenWidth >= 800) {
    //   interactionTableType =
    //       TabletInteractionTable(interactionData: interactionData);
    // } else {
    //   interactionTableType =
    //       MobileInteractionTable(interactionData: interactionData);
    // }
    return Placeholder();
    /*
    var interactionTableType =
        InteractionTable(interactionData: interactionData);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: interactionTableType,
    );*/
  }
}
