import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../budget_exports.dart';
import 'dart:io';

class ExpenseForm extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController amountController;
  final TextEditingController noteController;
  final String selectedCategory;
  final TextEditingController actualAmountController;
  XFile? receiptImage;
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
        TextField(
          controller: widget.titleController,
          enabled: !widget.isSaving,
          decoration: const InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(),
          ),
        ),
        WidgetsSpacer.verticalSpacer16,
        ExpenseCategorySelector(
          categories: expenseCategories,
          onCategorySelected: widget.onCategorySelected,
          initialCategory: widget.selectedCategory,
        ),
        WidgetsSpacer.verticalSpacer16,
        FormattedAmountField(
          controller: widget.amountController,
          currencySymbol: widget.prefixIcon,
          labelText: "Planned Amount",
        ),
        WidgetsSpacer.verticalSpacer16,
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
        Row(
          children: [
            Checkbox(
              value: isExpenseDone,
              onChanged: (bool? value) {
                setState(() {
                  isExpenseDone = value ?? false;
                });
              },
            ),
            const Text('Mark as Done'),
          ],
        ),
        if (isExpenseDone) ...[
          WidgetsSpacer.verticalSpacer16,

          FormattedAmountField(
            controller: widget.actualAmountController,
            currencySymbol: widget.prefixIcon,
            labelText: "Actual Spent Amount",
          ),
          WidgetsSpacer.verticalSpacer16,
          ElevatedButton(
            onPressed: _pickReceiptImage,
            child: Text(
              widget.receiptImage != null ? 'Upload Receipt' : 'Add Receipt',
              style: TextStyle(
                fontSize: FontSize.size16,
                fontWeight: FontWeight.w400,
                color: AppColors.white,
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
                        decoration: BoxDecoration(
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

  @override
  void dispose() {
    super.dispose();
  }
}
