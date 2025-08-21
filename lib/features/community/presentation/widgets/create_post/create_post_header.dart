import 'package:flutter/material.dart';
import '../../../community_exports.dart';

class CreatePostHeader extends StatelessWidget {
  final ValueChanged<bool> onChanged;
  final bool isPublic;
  const CreatePostHeader({
    super.key,
    required this.onChanged,
    required this.isPublic,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Make a Post",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        CreatePostVisibility(isPublic: isPublic, onChanged: onChanged),
      ],
    );
  }
}
