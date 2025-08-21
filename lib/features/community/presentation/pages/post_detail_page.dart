import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../community_exports.dart";

class PostDetailPage extends StatefulWidget {
  final String postId;
  const PostDetailPage({super.key, required this.postId});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(GetPostByIdEvent(widget.postId));
    context.read<CommentBloc>().add(
      GetCommentsEvent(widget.postId, skip: 0, limit: 20),
    );
  }

  void _addComment(String comment) {
    final content = comment.trim();
    if (content.isEmpty) return;
    context.read<CommentBloc>().add(CreateCommentEvent(widget.postId, content));
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Post", context),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets, // handles keyboard
        child: Container(
          padding: WidgetsSpacer.pagePadding,
          child: CommentInputField(onSend: _addComment),
        ),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading)
            return const Center(child: CircularProgressIndicator());

          if (state is PostLoaded) {
            final post = state.post;

            return SingleChildScrollView(
              padding: const EdgeInsets.only(
                bottom: 80,
              ), // space for input field
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostHeader(post: post),
                    WidgetsSpacer.verticalSpacer16,
                    PostContent(post: post),
                    WidgetsSpacer.verticalSpacer20,
                    PostActions(post: post),
                    WidgetsSpacer.verticalSpacer32,

                    BlocBuilder<CommentBloc, CommentState>(
                      builder: (context, cState) {
                        List<CommentModel> comments = [];
                        if (cState is CommentsLoaded &&
                            cState.postId == post.id) {
                          comments = cState.comments;
                        }
                        if (cState is CommentLoading &&
                            cState.postId == post.id) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (comments.isEmpty) {
                          return Center(child: Text("No comments yet."));
                        }

                        return Column(
                          children:
                              comments
                                  .map(
                                    (c) => CommentTile(
                                      postId: post.id,
                                      comment: c,
                                    ),
                                  )
                                  .toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
