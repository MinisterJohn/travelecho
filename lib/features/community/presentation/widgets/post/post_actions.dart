import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import "../../../community_exports.dart";

class PostActions extends StatelessWidget {
  final PostModel post;
  final bool isPreview;
  final VoidCallback? onCommentTap;

  const PostActions({super.key, required this.post, this.isPreview = false, this.onCommentTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        /// Like
        GestureDetector(
          onTap: () {
            context.read<PostBloc>().add(TogglePostLikeEvent(post.id));
          },
          child: Row(
            children: [
              Icon(
                post.isLikedByViewer ? Icons.favorite : LineIcons.heart,
                size: 20,
                color:
                    post.isLikedByViewer
                        ? AppColors.primaryColor
                        : AppColors.defaultColor400,
              ),
              const SizedBox(width: 4),
              Text(
                post.likeCount.toString(),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),

        /// Comment
        GestureDetector(
          onTap:
              !isPreview
                  ? null
                  : onCommentTap,
          child: Row(
            children: [
              const Icon(
                Icons.comment_outlined,
                size: 20,
                color: AppColors.defaultColor400,
              ),
              const SizedBox(width: 4),
              Text(
                post.commentCount.toString(),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),

        /// Share
        const Icon(
          Icons.share_outlined,
          size: 20,
          color: AppColors.defaultColor400,
        ),
      ],
    );
  }
}
