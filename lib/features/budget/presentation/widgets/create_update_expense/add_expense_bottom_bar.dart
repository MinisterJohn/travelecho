import 'package:flutter/material.dart';
import '../../../budget_exports.dart';

class AddExpenseBottomBar extends StatelessWidget {
  final VoidCallback onReset;
  final VoidCallback onSave;
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: isSaving ? null : onReset,
                // style: TextButton.styleFrom(
                //   padding: const EdgeInsets.symmetric(vertical: 14),
                //   // side: BorderSide(color: AppColors.defaultColor400),
                //   // shape: RoundedRectangleBorder(
                //   //   borderRadius: BorderRadius.circular(8),
                //   // ),
                // ),
                child: Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: FontSize.size16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: isSaving || !isFormValid ? null : onSave,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: AppColors.primaryColor,
                  disabledBackgroundColor: AppColors.primaryColor300,
                ),
                child:
                    isSaving
                        ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                        : Text(
                          isEdit ? 'Update Expense' : 'Save Expense',
                          style: TextStyle(
                            fontSize: FontSize.size16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
