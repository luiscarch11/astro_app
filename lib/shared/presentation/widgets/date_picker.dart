import 'package:astro_app/shared/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class DateSelectorWidget extends StatelessWidget {
  const DateSelectorWidget({
    Key? key,
    required this.controller,
    required this.label,
    required this.showErrors,
    required this.onChanged,
    this.initialDate,
    this.minDate,
    this.maxDate,
    this.value,
  }) : super(key: key);
  final TextEditingController controller;
  final String label;
  final bool showErrors;
  final ValueChanged<DateTime> onChanged;
  final DateTime? initialDate;
  final DateTime? maxDate;
  final DateTime? minDate;
  final DateTime? value;
  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      onChanged: (value) {},
      onTap: () async {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
        await Future.delayed(const Duration(milliseconds: 300));
        if (context.mounted) {
          final nowDate = DateTime.now();

          final selectedDate = await showDatePicker(
            context: context,
            initialDate: value ?? nowDate,
            firstDate: minDate ?? DateTime(1900),
            lastDate: maxDate ?? nowDate,
          );
          if (selectedDate != null) {
            onChanged.call(
              selectedDate,
            );
          }
        }
      },
      controller: controller,
      readOnly: true,
    );
  }
}
