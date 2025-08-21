import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../community_exports.dart';

class Post extends StatefulWidget {
  final PostModel post;

  const Post({super.key, required this.post});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool _showCommentsPreview = false;

  /// Local cache for comments per post
  final Map<String, List<CommentModel>> _cachedComments = {};

  /// Toggle comment preview visibility
  void _toggleCommentsPreview() {
    final commentBloc = context.read<CommentBloc>();

    if (!_showCommentsPreview) {
      // Fetch comments for this post before showing
      commentBloc.add(GetCommentsEvent(widget.post.id, limit: 5));
    }

    setState(() {
      _showCommentsPreview = !_showCommentsPreview;
    });
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Post Header
          PostHeader(post: post),

          const SizedBox(height: 10),

          /// 🔹 Post Content
          GestureDetector(
            onTap: () {
              AppNavigator.push(
                context,
                MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: sl<PostBloc>()),
                    BlocProvider.value(value: sl<CommentBloc>()),
                    BlocProvider.value(value: sl<ReplyBloc>()),
                  ],
                  child: PostDetailPage(postId: post.id),
                ),
              );
            },
            child: PostContent(post: post),
          ),

          const SizedBox(height: 10),

          /// 🔹 Post Actions
          PostActions(
            post: post,
            isPreview: true,
            onCommentTap: _toggleCommentsPreview,
          ),

          const SizedBox(height: 10),

          /// 🔹 Comments Preview
          if (_showCommentsPreview)
            BlocBuilder<CommentBloc, CommentState>(
              builder: (context, state) {
                List<CommentModel> postComments = _cachedComments[post.id] ?? [];

                // Update cache if the state matches this post
                if (state is CommentsLoaded && state.postId == post.id) {
                  postComments = state.comments;
                  _cachedComments[post.id] = state.comments;
                }

                // Show loading indicator if this post is currently loading
                if (state is CommentLoading && state.postId == post.id) {
                  return const Center(
                    child: Text(
                      "Loading...",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.defaultColor400),
                    ),
                  );
                }

                // Show comments preview with cached or loaded comments
                return PostCommentsPreview(
                  post: post.copyWith(comments: postComments),
                  isPreview: true,
                );
              },
            ),
        ],
      ),
    );
  }
}
