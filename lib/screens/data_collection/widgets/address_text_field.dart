import 'package:approval_ai/screens/data_collection/model/place.dart';
import 'package:approval_ai/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// A text field widget that provides address autocomplete functionality
class AddressTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function(Map<String, String>)? onAddressSelected;
  final bool showSuggestions;
  final FocusNode focusNode;
  final Function(String?) validator;

  const AddressTextField({
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.validator,
    this.onChanged,
    this.onAddressSelected,
    this.showSuggestions = true,
    super.key,
  });

  @override
  State<AddressTextField> createState() => _AddressTextFieldState();
}

class _AddressTextFieldState extends State<AddressTextField> {
  // MARK: - Properties
  List<Place> _suggestions = [];
  bool _isLoading = false;

  // MARK: - Lifecycle Methods
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    widget.focusNode.dispose();
    super.dispose();
  }

  // MARK: - Private Methods
  void _onFocusChange() {
    if (!widget.focusNode.hasFocus) {
      setState(() => _suggestions = []);
    }
  }

  Future<void> _getPlacePredictions(String input) async {
    if (input.isEmpty) {
      setState(() => _suggestions = []);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await _fetchPredictions(input);
      _handlePredictionsResponse(response);
    } catch (e) {
      print('Error fetching predictions: $e');
      setState(() => _suggestions = []);
    }

    setState(() => _isLoading = false);
  }

  Future<http.Response> _fetchPredictions(String input) {
    return http.get(Uri.parse(
        'https://us-central1-approval-ai.cloudfunctions.net/placeAutocomplete?input=$input'));
  }

  void _handlePredictionsResponse(http.Response response) {
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['status'] == 'OK') {
        final predictions = (json['predictions'] as List)
            .map((place) => Place.fromJson(place))
            .toList();
        setState(() => _suggestions = predictions);
      } else {
        print('API Error: ${json['status']}');
        setState(() => _suggestions = []);
      }
    }
  }

  // MARK: - UI Components
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(),
        if (_suggestions.isNotEmpty) _buildSuggestionsContainer(),
      ],
    );
  }

  Widget _buildTextField() {
    return CustomTextField(
      label: widget.label,
      controller: widget.controller,
      focusNode: widget.focusNode,
      hint: 'Enter your address',
      suffixIcon: _buildSuffixIcon(),
      onChanged: (value) {
        _getPlacePredictions(value);
        widget.onChanged?.call(value);
      },
      validator: _addressValidator,
    );
  }

  Widget _buildSuffixIcon() {
    return _isLoading
        ? const SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Icon(Icons.location_on_outlined);
  }

  Widget _buildSuggestionsContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      decoration: _getSuggestionsBoxDecoration(),
      child: Column(
        children: _suggestions
            .map((suggestion) => _buildSuggestionItem(suggestion))
            .toList(),
      ),
    );
  }

  BoxDecoration _getSuggestionsBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Widget _buildSuggestionItem(Place suggestion) {
    return InkWell(
      onTapDown: (_) => _onAddressSelected(suggestion.description),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Row(
          children: [
            const Icon(Icons.location_on_outlined, size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                suggestion.description,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onAddressSelected(String address) {
    setState(() {
      widget.controller.text = address;
      _suggestions = [];
    });
  }

  String? _addressValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an address';
    }
    if (value.length < 5) {
      return 'Please enter a valid address';
    }
    return null;
  }
}
