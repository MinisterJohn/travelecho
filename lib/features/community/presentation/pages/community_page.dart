import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../community_exports.dart";

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with RouteAware {
  List<PostModel> _posts = []; // 🔹 Local cache of posts

  @override
  void initState() {
    super.initState();
    // ✅ Fetch posts when page opens
    context.read<PostBloc>().add(GetPostsEvent());
  }

  void _openCreatePostSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return BlocProvider.value(
              value: sl<PostBloc>(),
              child: CreatePostPage(scrollController: scrollController),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(
        "",
        context,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () => _openCreatePostSheet(context),
              icon: const Icon(Icons.auto_awesome),
              label: const Text(
                "Share your story",
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
      body: BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostError) {
            // ✅ Show error message but don’t clear posts
            DisplayMessage.errorMessage(state.message, context);
          } else if (state is PostsLoaded) {
            // ✅ Save posts locally when successfully loaded
            setState(() {
              _posts = state.posts;
            });
          }
        },
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            // 🔹 Initial loader when no posts yet
            if (_posts.isEmpty && state is PostLoading) {
              return const Stack(
                children: [
                  SizedBox.expand(),
                  _LoadingOverlay(message: "Loading posts..."),
                ],
              );
            }

            // 🔹 Show posts (even if error occurred later)
            if (_posts.isNotEmpty) {
              return Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      context.read<PostBloc>().add(GetPostsEvent());
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _posts.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final post = _posts[index];
                        return BlocProvider.value(
                          value: sl<CommentBloc>(),
                          child: Post(post: post),
                        );
                      },
                    ),
                  ),
                  if (state is PostLoading)
                    const _LoadingOverlay(message: "Updating..."),
                ],
              );
            }

            // 🔹 No posts and not loading
            return RefreshIndicator(
              onRefresh: () async {
                context.read<PostBloc>().add(GetPostsEvent());
              },
              child: const Center(child: Text("No posts available")),
            );
          },
        ),
      ),
    );
  }
}

class _LoadingOverlay extends StatelessWidget {
  final String message;
  const _LoadingOverlay({required this.message});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
