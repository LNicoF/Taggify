import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final Widget? label;
  final String? initialText ;
  final Function( String )? onChanged;

  const TextInputField({
    super.key,
    this.label,
    this.initialText,
    this.onChanged,
  } );

  @override
  Widget build(BuildContext context) {
    return TextField(
      /**/
      decoration: InputDecoration(
        label: label,
        border: const OutlineInputBorder(),
      ),
      /**/

      controller: TextEditingController(
        text: initialText,
      ),

      onChanged: onChanged,
    );
  }
}
