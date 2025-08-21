import 'package:flutter/material.dart';
import "../../../community_exports.dart";
// import 'package:flutter/foundation.dart' as foundation;
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class CommentInputField extends StatefulWidget {
  final Function(String) onSend;
  final String placeholder;

  const CommentInputField({
    super.key,
    required this.onSend,
    this.placeholder = "Write a comment...",
  });

  @override
  State<CommentInputField> createState() => _CommentInputFieldState();
}

class _CommentInputFieldState extends State<CommentInputField> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text);
      _commentController.clear();
      setState(() {});
    }
  }

  // void _showEmojiBottomSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.white,
  //     builder: (context) {
  //       return SizedBox(
  //         height: 300,
  //         child: EmojiPicker(
  //           textEditingController: _commentController,
  //           onEmojiSelected: (category, emoji) {
  //             // Optional: handle if you want
  //             debugPrint("Emoji selected: ${emoji.emoji}");
  //           },
  //           onBackspacePressed: () {
  //             debugPrint("Backspace pressed");
  //           },
  //           config: Config(
  //             height: 256,

  //             // bgColor: const Color(0xFFF2F2F2),
  //             checkPlatformCompatibility: true,
  //             emojiViewConfig: EmojiViewConfig(
  //               emojiSizeMax:
  //                   28 *
  //                   (foundation.defaultTargetPlatform == TargetPlatform.iOS
  //                       ? 1.20
  //                       : 1.0),
  //             ),
  //             viewOrderConfig: const ViewOrderConfig(
  //               top: EmojiPickerItem.categoryBar,
  //               middle: EmojiPickerItem.emojiView,
  //               bottom: EmojiPickerItem.searchBar,
  //             ),
  //             skinToneConfig: const SkinToneConfig(),
  //             categoryViewConfig: const CategoryViewConfig(),
  //             bottomActionBarConfig: const BottomActionBarConfig(),
  //             searchViewConfig: const SearchViewConfig(),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Emoji button
        // IconButton(
        //   icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
        //   onPressed: _showEmojiBottomSheet,
        // ),

        /// Text field with send button inside
        Expanded(
          child: TextField(
            controller: _commentController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: widget.placeholder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.send,
                  color:
                      _commentController.text.trim().isEmpty
                          ? AppColors.defaultColor400
                          : AppColors.primaryColor,
                ),
                onPressed:
                    _commentController.text.trim().isEmpty ? null : _addComment,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
