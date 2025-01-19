import 'package:approval_ai/screens/agent_interactions/model/interaction_data.dart';
import 'package:approval_ai/screens/agent_interactions/widgets/interaction_table.dart';
import 'package:approval_ai/screens/home/model/overview_data.dart';
import 'package:approval_ai/screens/home/widgets/custom_headings.dart';
import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  final Map<LenderStatusEnum, bool> filterStates;
  const FilterDialog({super.key, required this.filterStates});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late final Map<LenderStatusEnum, bool> filterStates;

  @override
  void initState() {
    super.initState();
    filterStates = Map.from(widget.filterStates);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 300,
          maxHeight: 350,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter By',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
              SizedBox(height: 24),
              ...filterStates.entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: entry.value,
                            onChanged: (bool? value) {
                              setState(() {
                                filterStates[entry.key] = value ?? false;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            activeColor: Colors.black,
                            checkColor: Colors.white,
                            side: BorderSide(color: Colors.black),
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          entry.key.name,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        filterStates.updateAll((key, value) => true);
                      });
                    },
                    child: Text('Reset', style: TextStyle(color: Colors.black)),
                  ),
                  SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, filterStates);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      minimumSize: Size(100, 48),
                    ),
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AgentInteractionScreen extends StatefulWidget {
  final List<InteractionData> interactionData;
  final bool isLoading;
  const AgentInteractionScreen(
      {super.key, required this.interactionData, required this.isLoading});

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
    final filteredInteractions = widget.interactionData.where((interaction) {
      return filterStates[interaction.status[0]] ?? true;
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

  _buildInteractionsTable(
      context, List<InteractionData> filteredInteractionData) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InteractionTable(
        interactionData: filteredInteractionData,
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
