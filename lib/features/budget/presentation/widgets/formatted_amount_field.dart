import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../budget_exports.dart';

class FormattedAmountField extends StatefulWidget {
  final TextEditingController controller;
  final dynamic currencySymbol;
  final String labelText;

  const FormattedAmountField({super.key, 
    required this.controller,
    required this.currencySymbol,
    required this.labelText,
  });

  @override
  State<FormattedAmountField> createState() => FormattedAmountFieldState();
}

class FormattedAmountFieldState extends State<FormattedAmountField> {
  String _badge = '';

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_formatAndBadge);
    _formatAndBadge();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_formatAndBadge);
    super.dispose();
  }

  void _formatAndBadge() {
    String text = widget.controller.text.replaceAll(',', '');
    if (text.isEmpty) {
      setState(() => _badge = '');
      return;
    }
    // Format with commas
    final number = int.tryParse(text);
    if (number == null) {
      setState(() => _badge = '');
      return;
    }
    final formatted = NumberFormat('#,###').format(number);
    if (widget.controller.text != formatted) {
      widget.controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
    // Set badge
    setState(() => _badge = _getMagnitudeBadge(number));
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            prefixIcon:
                widget.currencySymbol.isNotEmpty
                    ? Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Text(
                        widget.currencySymbol,
                        style: const TextStyle(fontSize: 28),
                      ),
                    )
                    : const Icon(Icons.attach_money),
            labelText: widget.labelText,
            border: const OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        if (_badge.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor100,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Text(
                _badge,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
