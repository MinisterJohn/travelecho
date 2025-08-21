import 'package:flutter/material.dart';

class CreatePostVisibility extends StatelessWidget {
  final bool isPublic;
  final ValueChanged<bool> onChanged;

  const CreatePostVisibility({
    super.key,
    required this.isPublic,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(isPublic ? "Public" : "Private"),
        Transform.scale(
          scale: 0.8,
          child: Switch(value: isPublic, onChanged: onChanged),
        ),
      ],
    );
  }
}
