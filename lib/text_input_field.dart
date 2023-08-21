import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final Widget label;
  final Function( String )? onChanged;

  const TextInputField({
    super.key,
    required this.label,
    this.onChanged,
  } );

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: label,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
