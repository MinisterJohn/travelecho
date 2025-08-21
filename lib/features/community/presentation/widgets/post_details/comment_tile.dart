import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../../community_exports.dart";

class CommentTile extends StatefulWidget {
  final String postId;
  final CommentModel comment;

  const CommentTile({super.key, required this.postId, required this.comment});

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  final Map<String, TextEditingController> _replyControllers = {};
  bool _repliesVisible = false;

  @override
  void initState() {
    super.initState();
    _replyControllers.putIfAbsent(
      widget.comment.id,
      () => TextEditingController(),
    );
  }

  void _toggleReplies() {
    setState(() => _repliesVisible = !_repliesVisible);
    if (_repliesVisible) {
      context.read<ReplyBloc>().add(
        GetRepliesEvent(widget.postId, widget.comment.id, skip: 0, limit: 10),
      );
    }
  }

  void _toggleLike() {
    context.read<CommentBloc>().add(
      ToggleCommentLikeEvent(widget.postId, widget.comment.id),
    );
  }

  void _addReply(String reply) {
    final content = reply.trim();
    if (content.isEmpty) return;
    context.read<ReplyBloc>().add(
      CreateReplyEvent(widget.postId, widget.comment.id, content),
    );
    _replyControllers[widget.comment.id]?.clear();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.comment;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage:
                    (c.author.image?.isNotEmpty ?? false)
                        ? NetworkImage(c.author.image!)
                        : null,
                child:
                    (c.author.image == null || c.author.image!.isEmpty)
                        ? Text(getInitials(c.author.name))
                        : null,
              ),
              WidgetsSpacer.horizontalSpacer8,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          c.author.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        WidgetsSpacer.horizontalSpacer8,
                        Text(
                          timeAgo(c.createdAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.defaultColor400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(c.content, style: const TextStyle(fontSize: 18)),
                    WidgetsSpacer.verticalSpacer8,
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _toggleLike,
                          child: Row(
                            children: [
                              Icon(
                                c.isLikedByViewer
                                    ? Icons.thumb_up
                                    : Icons.thumb_up_alt_outlined,
                                size: 18,
                                color:
                                    c.isLikedByViewer
                                        ? AppColors.primaryColor
                                        : AppColors.defaultColor400,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                "${c.likeCount}",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        WidgetsSpacer.horizontalSpacer20,
                        GestureDetector(
                          onTap: _toggleReplies,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.reply_outlined,
                                size: 18,
                                color: AppColors.defaultColor400,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                "${c.replyCount}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.defaultColor400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          WidgetsSpacer.verticalSpacer8,
          if (_repliesVisible)
            ReplySection(
              postId: widget.postId,
              commentId: c.id,
              controller: _replyControllers[c.id]!,
            ),
        ],
      ),
    );
  }
}
