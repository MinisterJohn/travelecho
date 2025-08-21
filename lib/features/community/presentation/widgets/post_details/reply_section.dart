import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../../community_exports.dart";

class ReplySection extends StatelessWidget {
  final String postId;
  final String commentId;
  final TextEditingController controller;

  const ReplySection({
    super.key,
    required this.postId,
    required this.commentId,
    required this.controller,
  });

  void _sendReply(BuildContext context, String text) {
    final content = text.trim();
    if (content.isEmpty) return;
    context.read<ReplyBloc>().add(CreateReplyEvent(postId, commentId, content));
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReplyBloc, ReplyState>(
      builder: (context, rState) {
        if (rState is ReplyLoading && rState.commentId == commentId) {
          return const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Center(
              child: Text(
                "Loading...",
                style: TextStyle(color: AppColors.defaultColor400),
              ),
            ),
          );
        }

        List<ReplyModel> replies = [];
        if (rState is RepliesLoaded && rState.commentId == commentId) {
          replies = [];
        }

        return Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (replies.isNotEmpty)
                ...replies.map(
                  (r) => ListTile(
                    leading: CircleAvatar(
                      radius: 14,
                      child: Text(getInitials(r.authorName)),
                    ),
                    title: Text(r.authorName),
                    subtitle: Text(r.content),
                  ),
                ),
              if (replies.isEmpty)
                Center(
                  child: Text(
                    "No replies yet",
                    style: TextStyle(color: AppColors.defaultColor400),
                  ),
                ),
              
              WidgetsSpacer.verticalSpacer8,
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CommentInputField(
                  placeholder: "Write a reply...",
                  onSend: (text) => _sendReply(context, text),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
