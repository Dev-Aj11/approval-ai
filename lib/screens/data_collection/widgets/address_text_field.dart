import 'dart:convert';

import 'package:approval_ai/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddressTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final Function(String) onAddressSelected;

  const AddressTextField({
    required this.label,
    required this.controller,
    required this.focusNode,
    this.validator,
    required this.onAddressSelected,
    super.key,
  });

  @override
  State<AddressTextField> createState() => _AddressTextFieldState();
}

class _AddressTextFieldState extends State<AddressTextField> {
  List<String> suggestions = [];
  OverlayEntry? _overlayEntry;
  final _placesKey = 'AIzaSyB1WWuh6fveysdRw1_HnwWobI4eNOfMiP0';
  final LayerLink _layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: CustomTextField(
        label: widget.label,
        controller: widget.controller,
        focusNode: widget.focusNode,
        validator: widget.validator,
        suffixIcon: const Icon(Icons.location_on_outlined),
        onChanged:
            _onSearchAddress, // We'll need to add this to CustomTextField
      ),
    );
  }

  void _onSearchAddress(String value) {
    // Call Places API here and show suggestions
    _getSuggestions(value);
  }

  void _getSuggestions(String input) async {
    if (input.isEmpty) {
      _removeOverlay();
      return;
    }

    // Here you would normally call the Places API
    // For now, let's use mock data
    try {
      final response = await http.get(
          Uri.parse(
              'https://maps.googleapis.com/maps/api/place/autocomplete/json'
              '?input=$input'
              '&components=country:us'
              '&key=$_placesKey'),
          headers: {"Access-Control-Allow-Origin": "*"});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        if (data['status'] == 'OK') {
          setState(() {
            suggestions = (data['predictions'] as List)
                .map((prediction) => prediction['description'] as String)
                .toList();
          });
          _showOverlay();
        }
      }
    } catch (e) {
      print('Error fetching suggestions: $e');
    }
  }

  void _showOverlay() {
    _removeOverlay();

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 200,
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(suggestions[index]),
                    onTap: () {
                      widget.controller.text = suggestions[index];
                      widget.onAddressSelected(suggestions[index]);
                      _removeOverlay();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }
}
