import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../budget_exports.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // remove commas before parsing
    final int? value = int.tryParse(newValue.text.replaceAll(',', ''));
    if (value == null) return oldValue;

    final formatted = NumberFormat('#,###').format(value);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}



class FormattedAmountField extends StatefulWidget {
  final TextEditingController controller;
  final dynamic currencySymbol;
  final String labelText;
  final String? Function(String?) validator;

  const FormattedAmountField({
    super.key,
    required this.controller,
    required this.currencySymbol,
    required this.labelText,
    required this.validator,
  });

  @override
  State<FormattedAmountField> createState() => _FormattedAmountFieldState();
}

class _FormattedAmountFieldState extends State<FormattedAmountField> {
  String _badge = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.number,
          validator: widget.validator,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CurrencyInputFormatter(),
          ],
          decoration: InputDecoration(
            labelText: widget.labelText,
            prefixText: widget.currencySymbol?.toString() ?? '',
          ),
          onChanged: (value) {
            final number = int.tryParse(value.replaceAll(',', ''));
            if (number != null) {
              setState(() => _badge = _getMagnitudeBadge(number));
            } else {
              setState(() => _badge = '');
            }
          },
        ),
        if (_badge.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor300,
              border: Border.all(color: Colors.transparent),
            ),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
            child: Text(
              _badge,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ).copyWith(color: AppColors.primaryColor),
            ),
          ),
      ],
    );
  }

  String _getMagnitudeBadge(int value) {
    if (value >= 1000000000) return "Billions";
    if (value >= 1000000) return "Millions";
    if (value >= 100000) return "Hundred Thousands";
    if (value >= 10000) return "Ten Thousands";
    if (value >= 1000) return "Thousands";
    if (value >= 100) return "Hundreds";
    return "Tens";
  }
}
