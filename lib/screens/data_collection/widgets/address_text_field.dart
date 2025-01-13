import 'package:approval_ai/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Place {
  final String description;
  final String placeId;

  Place({required this.description, required this.placeId});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      description: json['description'],
      placeId: json['place_id'],
    );
  }
}

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
  List<Place> _places = [];
  bool _isLoading = false;

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

  void _onFocusChange() {
    if (!widget.focusNode.hasFocus) {
      setState(() {
        _places = [];
      });
    }
  }

  Future<void> _getPlacePredictions(String input) async {
    if (input.isEmpty) {
      setState(() => _places = []);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await http.get(Uri.parse(
          'https://us-central1-approval-ai.cloudfunctions.net/placeAutocomplete?input=$input'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'OK') {
          final predictions = (json['predictions'] as List)
              .map((place) => Place.fromJson(place))
              .toList();
          setState(() => _places = predictions);
        } else {
          print('Error: ${json['status']}');
          setState(() => _places = []);
        }
      }
    } catch (e) {
      print('Error: $e');
      setState(() => _places = []);
    }

    setState(() => _isLoading = false);
  }

  void _onAddressSelected(String address) {
    setState(() {
      widget.controller.text = address;
      _places = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: widget.label,
          controller: widget.controller,
          focusNode: widget.focusNode,
          hint: 'Enter your address',
          suffixIcon: _isLoading
              ? const SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.location_on_outlined),
          onChanged: (value) {
            _getPlacePredictions(value);
            widget.onChanged?.call(value);
          },
          validator: _addressValidator,
        ),
        if (_places.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: _places
                  .map(
                    (suggestion) => InkWell(
                      onTapDown: (_) =>
                          _onAddressSelected(suggestion.description),
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
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
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
