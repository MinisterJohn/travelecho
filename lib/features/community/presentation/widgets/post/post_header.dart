import 'package:flutter/material.dart';
import "../../../community_exports.dart";

class PostHeader extends StatefulWidget {
  final PostModel post;
  const PostHeader({super.key, required this.post});

  @override
  State<PostHeader> createState() => _PostHeaderState();
}

class _PostHeaderState extends State<PostHeader> {
  bool _isFollowing = false;

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage:
              (post.authorImage?.isNotEmpty ?? false)
                  ? NetworkImage(post.authorImage!)
                  : null,
          child:
              post.authorImage!.isEmpty
                  ? Text(
                    getInitials(post.author),
                    style: TextStyle(
                      color: getRandomRgbaColor(post.author),
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  : null,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.author ?? "Anonymous",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              post.createdAt != null ? timeAgo(post.createdAt) : "just now",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => setState(() => _isFollowing = !_isFollowing),
          child: Text(
            _isFollowing ? "Following" : "Follow",
            style: TextStyle(
              fontSize: 14,
              color:
                  _isFollowing
                      ? AppColors.primaryColor300
                      : AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
