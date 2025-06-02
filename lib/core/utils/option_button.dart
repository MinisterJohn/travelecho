import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../core_exports.dart';

class OptionButton extends StatelessWidget {
  final BuildContext context;
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDelete;

  const OptionButton({
    Key? key,
    required this.context,
    required this.text,
    required this.icon,
    required this.onTap,
    this.isDelete = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(icon, size: 16,
            //     color: isDelete ? Colors.red : AppColors.defaultColor
            // ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: isDelete ? Colors.red : AppColors.defaultColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
