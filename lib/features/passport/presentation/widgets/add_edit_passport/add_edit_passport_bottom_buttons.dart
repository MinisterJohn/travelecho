import 'package:flutter/material.dart';
import '../../../passport_exports.dart';

class AddEditTravelDocumentBottomButtons extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onSave;
  final VoidCallback onReset;
  final bool isEdit;
  final bool isLoading;

  const AddEditTravelDocumentBottomButtons({
    super.key,
    required this.formKey,
    required this.onSave,
    required this.onReset,
    this.isEdit = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: onReset,
              child: Text(
                "Reset",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.defaultColor400,
                ),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed:
                  isLoading
                      ? null
                      : () {
                        if (formKey.currentState!.validate()) {
                          onSave();
                        }
                      },
              child:
                  isLoading
                      ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                      : Text(
                        isEdit ? 'Update TravelDocument' : 'Add TravelDocument',
                        style: TextStyle(
                          fontSize: FontSize.size16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                        ),
                      ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
