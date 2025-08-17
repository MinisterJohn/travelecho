import 'package:flutter/material.dart';
import 'package:travelecho/config/config.exports.dart';

class CreateMemoryActionButtons extends StatelessWidget {
  final bool isLoading;
  final bool isUpdate;
  final VoidCallback onCreate;
  final VoidCallback onReset;
  const CreateMemoryActionButtons({
    super.key,
    required this.isLoading,
    required this.isUpdate,
    required this.onCreate,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: isLoading ? null : onCreate,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          child:
              isLoading
                  ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                  : Text(isUpdate ? 'Update Memory' : 'Create Memory'),
        ),
        const SizedBox(width: 16),
        TextButton(
          onPressed: onReset,
          child: const Text(
            'Reset',
            style: TextStyle(
              color: AppColors.defaultColor400,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
