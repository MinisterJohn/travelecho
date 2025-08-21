import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../budget_exports.dart';
import 'dart:io';

class ExpenseForm extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController amountController;
  final TextEditingController noteController;
  final TextEditingController actualAmountController;
  XFile? receiptImage;
  final String selectedCategory;
  final bool isSaving;
  final Function(String) onCategorySelected;
  final String prefixIcon;

  ExpenseForm({
    super.key,
    required this.titleController,
    required this.amountController,
    required this.noteController,
    required this.actualAmountController,
    this.receiptImage,
    required this.selectedCategory,
    required this.isSaving,
    required this.onCategorySelected,
    required this.prefixIcon,
  });

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  bool isExpenseDone = false;

  @override
  void initState() {
    super.initState();
    isExpenseDone = widget.actualAmountController.text.isNotEmpty;

    // ✅ Listen for amount changes and rebuild when they change
    widget.amountController.addListener(_onAmountChanged);
    widget.actualAmountController.addListener(_onAmountChanged);
  }

  void _onAmountChanged() {
    if (mounted) {
      setState(() {}); // rebuilds the form when planned/actual amount changes
    }
  }

  @override
  void dispose() {
    widget.amountController.removeListener(_onAmountChanged);
    widget.actualAmountController.removeListener(_onAmountChanged);
    super.dispose();
  }

  Future<void> _pickReceiptImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        widget.receiptImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ Title field with validation
        TextFormField(
          controller: widget.titleController,
          enabled: !widget.isSaving,
          decoration: const InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(),
          ),
          validator:
              (value) =>
                  value == null || value.trim().isEmpty
                      ? "Enter a title"
                      : null,
        ),
        WidgetsSpacer.verticalSpacer16,

        // ✅ Category with validation
        FormField<String>(
          initialValue: widget.selectedCategory,
          validator:
              (value) =>
                  value == null || value == "Select Category"
                      ? "Select a category"
                      : null,
          builder:
              (field) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpenseCategorySelector(
                    categories: expenseCategories,
                    onCategorySelected: (category) {
                      widget.onCategorySelected(category);
                      field.didChange(category);
                    },
                    initialCategory: widget.selectedCategory,
                  ),
                  if (field.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        field.errorText!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              ),
        ),
        WidgetsSpacer.verticalSpacer16,

        // ✅ Planned amount with validation
        FormattedAmountField(
          controller: widget.amountController,
          currencySymbol: widget.prefixIcon,
          labelText: "Planned Amount",
          validator: (value) {
            if (value == null || value.isEmpty) return "Enter planned amount";
            return null;
          },
        ),

        WidgetsSpacer.verticalSpacer16,

        // Note
        TextField(
          controller: widget.noteController,
          enabled: !widget.isSaving,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Note',
            border: OutlineInputBorder(),
          ),
        ),
        WidgetsSpacer.verticalSpacer16,

        // Checkbox + conditional fields
        Row(
          children: [
            const Text('Track Expense'),
            Transform.scale(
              scale: 0.6,
              child: Switch(
                value: isExpenseDone,
                activeColor: AppColors.primaryColor,
                onChanged: (bool value) {
                  setState(() {
                    isExpenseDone = value;
                  });
                },
              ),
            ),
          ],
        ),

        if (isExpenseDone) ...[
          WidgetsSpacer.verticalSpacer16,

          // ✅ Actual amount (only if expense tracking is enabled)
          FormattedAmountField(
            controller: widget.actualAmountController,
            currencySymbol: widget.prefixIcon,
            labelText: "Actual Spent Amount",
            validator: (value) {
              if (!isExpenseDone) return null;
              if (value == null || value.isEmpty) return "Enter actual amount";
              return null;
            },
          ),
          WidgetsSpacer.verticalSpacer16,

          TextButton.icon(
            onPressed: _pickReceiptImage,
            icon: const Icon(Icons.receipt_long_outlined),
            label: Text(
              widget.receiptImage != null ? 'Upload Receipt' : 'Add Receipt',
              style: TextStyle(
                fontSize: FontSize.size16,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryColor,
              ),
            ),
          ),

          if (widget.receiptImage != null) ...[
            WidgetsSpacer.verticalSpacer16,
            Text('Receipt uploaded: ${widget.receiptImage!.name}'),
            WidgetsSpacer.verticalSpacer8,
            SizedBox(
              height: 120,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(widget.receiptImage!.path),
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.receiptImage = null;
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ],
    );
  }
}
