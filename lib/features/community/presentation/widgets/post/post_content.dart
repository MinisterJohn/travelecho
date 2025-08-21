import 'package:flutter/material.dart';
import './post_media.dart';
import "../../../community_exports.dart";

class PostContent extends StatelessWidget {
  final PostModel post;
  const PostContent({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(post.content ?? "", style: const TextStyle(fontSize: 20)),
        if (post.tags != null && post.tags!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children:
                post.tags!
                    .map(
                      (tag) => Text(
                        "#$tag",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
        post.media != null && post.media!.isNotEmpty
            ? buildPostMedia(context, post.media!)
            : const SizedBox.shrink(),
      ],
    );
  }
}
