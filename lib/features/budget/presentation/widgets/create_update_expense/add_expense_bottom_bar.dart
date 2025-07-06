import 'package:flutter/material.dart';
import '../../../budget_exports.dart';

class AddExpenseBottomBar extends StatelessWidget {
  final VoidCallback onReset;
  final VoidCallback? onSave;
  final bool isSaving;
  final bool isFormValid;
  final bool isEdit;

  const AddExpenseBottomBar({
    super.key,
    required this.onReset,
    required this.onSave,
    required this.isSaving,
    required this.isFormValid,
    required this.isEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: onReset,
            child: Text(
              'Reset',
              style: TextStyle(
                fontSize: FontSize.size16,
                fontWeight: FontWeight.w400,
                color: AppColors.defaultColor400,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: isSaving || !isFormValid ? null : onSave,
            child:
                isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                      isEdit ? 'Update Expense' : 'Save Expense',
                      style: TextStyle(
                        fontSize: FontSize.size16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
