import 'package:flutter/material.dart';

class CreatePostContent extends StatelessWidget {
  final TextEditingController controller;
  const CreatePostContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 5,
      decoration: const InputDecoration(
        hintText: "What's on your mind?",
        border: OutlineInputBorder(),
      ),
    );
  }
}
