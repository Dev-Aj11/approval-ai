import 'package:approval_ai/screens/home/model/overview_data.dart';
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
      child: _buildDialogContent(),
    );
  }

  Widget _buildDialogContent() {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 300,
        maxHeight: 350,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            ..._buildFilterOptions(),
            const SizedBox(height: 24),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Filter By',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  List<Widget> _buildFilterOptions() {
    return filterStates.entries
        .map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _buildFilterOption(entry),
            ))
        .toList();
  }

  Widget _buildFilterOption(MapEntry<LenderStatusEnum, bool> entry) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: entry.value,
            onChanged: (value) => _updateFilters(value, entry.key),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            activeColor: Colors.black,
            checkColor: Colors.white,
            side: const BorderSide(color: Colors.black),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          _getFilterName(entry.key),
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: _resetFilters,
          child: const Text('Reset', style: TextStyle(color: Colors.black)),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, filterStates),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff0065FE),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            minimumSize: const Size(100, 48),
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _updateFilters(bool? value, LenderStatusEnum key) {
    setState(() {
      filterStates[key] = value ?? false;
    });
  }

  void _resetFilters() {
    setState(() {
      filterStates.updateAll((key, value) => true);
    });
  }

  String _getFilterName(LenderStatusEnum key) {
    switch (key) {
      case LenderStatusEnum.contacted:
        return "Lender Contacted";
      case LenderStatusEnum.received:
        return "Estimate Received";
      case LenderStatusEnum.negotiating:
        return "Negotiation In Progress";
      case LenderStatusEnum.complete:
        return "Negotiation Complete";
    }
  }
}
