import 'package:flutter/material.dart';
import '../../../passport_exports.dart';

class TravelDocumentForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController passportNumberController;
  final String? selectedTravelDocuments;
  final ValueChanged<String> onTravelDocumentSelected;
  final ValueChanged<String> onCountrySelected;
  final TextEditingController fullNameController;
  final TextEditingController nationalityController;
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final TextEditingController placeOfIssueController;
  final VoidCallback onPickIssueDate;
  final Future<void> Function() onPickExpiryDate;

  const TravelDocumentForm({
    super.key,
    required this.formKey,
    required this.passportNumberController,
    required this.selectedTravelDocuments,
    required this.onTravelDocumentSelected,
    required this.onCountrySelected,
    required this.fullNameController,
    required this.nationalityController,
    required this.issueDate,
    required this.expiryDate,
    required this.placeOfIssueController,
    required this.onPickIssueDate,
    required this.onPickExpiryDate,
  });

  @override
  State<TravelDocumentForm> createState() => _TravelDocumentFormState();
}

class _TravelDocumentFormState extends State<TravelDocumentForm> {
  String? expiryDateError;

  @override
  void didUpdateWidget(covariant TravelDocumentForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    _validateExpiryDate();
  }

  void _validateExpiryDate() {
    if (widget.expiryDate == null) {
      expiryDateError = 'Required';
    } else if (widget.issueDate != null &&
        !widget.expiryDate!.isAfter(widget.issueDate!)) {
      expiryDateError = 'Expiry date must be after issue date';
    } else {
      expiryDateError = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        spacing: 16,
        children: [
          TextFormField(
            controller: widget.passportNumberController,
            decoration: const InputDecoration(
              labelText: 'TravelDocument Number',
            ),
            validator: (value) => validateTravelDocumentNumber(value),
          ),
          TravelDocumentsDropdown(
            selectedTravelDocuments: widget.selectedTravelDocuments,
            onSelected: widget.onTravelDocumentSelected,
          ),
          TextFormField(
            controller: widget.fullNameController,
            decoration: const InputDecoration(labelText: 'Full Name'),
            validator:
                (value) => value == null || value.isEmpty ? 'Required' : null,
          ),
          TravelDocumentCountryDropdown(
            selectedCountry: widget.nationalityController.text,
            onSelected: widget.onCountrySelected,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    widget.onPickIssueDate();
                    setState(() {
                      _validateExpiryDate();
                    });
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Issue Date',
                      ),
                      controller: TextEditingController(
                        text:
                            widget.issueDate == null
                                ? ''
                                : "${widget.issueDate!.year}-${widget.issueDate!.month.toString().padLeft(2, '0')}-${widget.issueDate!.day.toString().padLeft(2, '0')}",
                      ),
                      validator:
                          (value) =>
                              widget.issueDate == null ? 'Required' : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    await widget.onPickExpiryDate();
                    setState(() {
                      _validateExpiryDate();
                    });
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Expiry Date',
                        errorText: expiryDateError,
                      ),
                      controller: TextEditingController(
                        text:
                            widget.expiryDate == null
                                ? ''
                                : "${widget.expiryDate!.year}-${widget.expiryDate!.month.toString().padLeft(2, '0')}-${widget.expiryDate!.day.toString().padLeft(2, '0')}",
                      ),
                      validator: (value) => expiryDateError,
                    ),
                  ),
                ),
              ),
            ],
          ),
          TextFormField(
            controller: widget.placeOfIssueController,
            decoration: const InputDecoration(
              labelText: 'Place of Issue (optional)',
            ),
          ),
        ],
      ),
    );
  }
}
