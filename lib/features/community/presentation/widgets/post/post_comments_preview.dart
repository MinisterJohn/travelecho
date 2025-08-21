import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../../community_exports.dart";

class PostCommentsPreview extends StatefulWidget {
  final PostModel post;
  final bool isPreview;

  const PostCommentsPreview({
    super.key,
    required this.post,
    this.isPreview = false,
  });

  @override
  State<PostCommentsPreview> createState() => _PostCommentsPreviewState();
}

class _PostCommentsPreviewState extends State<PostCommentsPreview> {
  final TextEditingController _commentController = TextEditingController();

  void _addComment(String comment) {
    final content = comment.trim();
    if (content.isEmpty) return;

    context.read<CommentBloc>().add(
      CreateCommentEvent(widget.post.id, content),
    );

    _commentController.clear();
  }

  void _toggleLike(String commentId) {
    context.read<CommentBloc>().add(
      ToggleCommentLikeEvent(widget.post.id, commentId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final preview =
        widget.post.comments
            .take(widget.isPreview ? 5 : widget.post.comments.length)
            .toList();

    return Column(
      children: [
        if (preview.isEmpty)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("No comments yet."),
          )
        else
          ...preview.map((c) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Profile picture
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
                  const SizedBox(width: 10),

                  /// Comment content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Name + time
                        Row(
                          children: [
                            Text(
                              c.author.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              timeAgo(
                                c.createdAt,
                              ), // 🔹 requires createdAt in model
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 2),

                        /// Comment text
                        Text(c.content, style: const TextStyle(fontSize: 14)),

                        const SizedBox(height: 6),

                        /// Like & Reply Row
                        Row(
                          children: [
                            /// Like Button
                            GestureDetector(
                              onTap: () => _toggleLike(c.id),
                              child: Row(
                                children: [
                                  Icon(
                                    c.isLikedByViewer
                                        ? Icons.thumb_up
                                        : Icons.thumb_up_alt_outlined,
                                    size: 14,
                                    color:
                                        c.isLikedByViewer
                                            ? AppColors.primaryColor
                                            : AppColors.defaultColor400,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    "${c.likeCount}",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 20),

                            /// View replies
                            GestureDetector(
                              onTap: () {
                                AppNavigator.push(
                                  context,
                                  MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(value: sl<PostBloc>()),
                                      BlocProvider.value(
                                        value: sl<CommentBloc>(),
                                      ),
                                      BlocProvider.value(
                                        value: sl<ReplyBloc>(),
                                      ),
                                    ],
                                    child: PostDetailPage(
                                      postId: widget.post.id,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.reply_outlined,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    "${c.replyCount}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
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
            );
          }).toList(),

        const SizedBox(height: 8),

        /// 🔹 Add Comment Field
        CommentInputField(onSend: _addComment),
      ],
    );
  }
}
