import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.controller,
    this.textInputType,
    this.onTap,
    this.readOnly = false,
    this.hideBorders = false,
    this.label = '',
    this.center = true,
    required this.onChanged,
  });
  final bool readOnly;
  final String label;
  final bool hideBorders;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final ValueChanged<String> onChanged;
  final TextInputType? textInputType;
  final bool center;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      onTap: onTap,
      readOnly: readOnly,
      onChanged: onChanged,
      textAlign: center ? TextAlign.center : TextAlign.start,
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        contentPadding: EdgeInsets.zero,
        border: hideBorders ? null : const OutlineInputBorder(),
      ),
    );
  }
}
