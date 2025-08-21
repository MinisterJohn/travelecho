import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import '../../community_exports.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  // 🔹 UseCases
  final CreatePostUseCase createPostUseCase = sl<CreatePostUseCase>();
  final GetPostsUseCase getPostsUseCase = sl<GetPostsUseCase>();
  final TogglePostLikeUseCase togglePostLikeUseCase = sl<TogglePostLikeUseCase>();
  final CreateCommentUseCase createCommentUseCase = sl<CreateCommentUseCase>();
  final GetCommentsUseCase getCommentsUseCase = sl<GetCommentsUseCase>();
  final UpdateCommentUseCase updateCommentUseCase = sl<UpdateCommentUseCase>();
  final DeleteCommentUseCase deleteCommentUseCase = sl<DeleteCommentUseCase>();
  final GetRepliesUseCase getRepliesUseCase = sl<GetRepliesUseCase>();
  final CreateReplyUseCase createReplyUseCase = sl<CreateReplyUseCase>();
  final ToggleCommentLikeUseCase toggleCommentLikeUseCase = sl<ToggleCommentLikeUseCase>();

  List<PostModel> _cachedPosts = [];

  CommunityBloc() : super(CommunityInitial()) {
    // ✅ Create post
    on<CreatePostEvent>((event, emit) async {
      emit(CommunityLoading());
      final result = await createPostUseCase(event.formData);

      result.fold(
        (error) {
          emit(CommunityError(error, posts: _safeCachedPosts()));
        },
        (post) {
          _cachedPosts.insert(0, post);
          emit(CommunityPostsLoaded(List.from(_cachedPosts)));
        },
      );
    });

    // ✅ Get posts
    on<GetPostsEvent>((event, emit) async {
      emit(CommunityLoading());
      final result = await getPostsUseCase(skip: event.skip, limit: event.limit);

      result.fold(
        (error) {
          emit(CommunityError(error, posts: _safeCachedPosts()));
        },
        (posts) {
          _cachedPosts = posts;
          emit(CommunityPostsLoaded(List.from(_cachedPosts)));
        },
      );
    });

    // ✅ Toggle post like
    on<ToggleLikeEvent>((event, emit) async {
      final result = await togglePostLikeUseCase(event.postId);

      result.fold(
        (error) {
          emit(CommunityError(error, posts: _safeCachedPosts()));
        },
        (isLiked) {
          _cachedPosts = _cachedPosts.map((post) {
            if (post.id == event.postId) {
              return post.copyWith(
                isLikedByViewer: isLiked,
                likeCount: isLiked
                    ? post.likeCount + 1
                    : (post.likeCount > 0 ? post.likeCount - 1 : 0),
              );
            }
            return post;
          }).toList();

          emit(CommunityPostsLoaded(List.from(_cachedPosts)));
        },
      );
    });

    // ✅ Create comment
    on<CreateCommentEvent>((event, emit) async {
      final result = await createCommentUseCase(
        postId: event.postId,
        content: event.content,
        parentComment: event.parentComment,
      );

      result.fold(
        (error) {
          emit(CommunityError(error, posts: _safeCachedPosts()));
        },
        (comment) {
          _cachedPosts = _cachedPosts.map((post) {
            if (post.id == event.postId) {
              return post.copyWith(
                commentCount: post.commentCount + 1,
                comments: [...post.comments, comment],
              );
            }
            return post;
          }).toList();

          emit(CommunityPostsLoaded(List.from(_cachedPosts)));
        },
      );
    });

    // ✅ Get comments
    on<GetCommentsEvent>((event, emit) async {
      emit(CommunityLoadingComments());
      final result = await getCommentsUseCase(
        postId: event.postId,
        skip: event.skip,
        limit: event.limit,
        sort: event.sort,
        select: event.select,
        populate: event.populate,
      );

      result.fold(
        (error) {
          emit(CommunityError(error, posts: _safeCachedPosts()));
        },
        (comments) {
          _cachedPosts = _cachedPosts.map((post) {
            if (post.id == event.postId) {
              return post.copyWith(comments: comments);
            }
            return post;
          }).toList();

          emit(CommunityPostsLoaded(List.from(_cachedPosts)));
        },
      );
    });

    // ✅ Update comment
    on<UpdateCommentEvent>((event, emit) async {
      final result = await updateCommentUseCase(
        postId: event.postId,
        commentId: event.commentId,
        content: event.content,
      );

      result.fold(
        (error) => emit(CommunityError(error, posts: _safeCachedPosts())),
        (_) {
          _cachedPosts = _cachedPosts.map((post) {
            if (post.id == event.postId) {
              final updatedComments = post.comments.map((c) {
                return c.id == event.commentId ? c.copyWith(content: event.content) : c;
              }).toList();
              return post.copyWith(comments: updatedComments);
            }
            return post;
          }).toList();

          emit(CommunityPostsLoaded(List.from(_cachedPosts)));
        },
      );
    });

    // ✅ Delete comment
    on<DeleteCommentEvent>((event, emit) async {
      final result = await deleteCommentUseCase(
        postId: event.postId,
        commentId: event.commentId,
      );

      result.fold(
        (error) => emit(CommunityError(error, posts: _safeCachedPosts())),
        (_) {
          _cachedPosts = _cachedPosts.map((post) {
            if (post.id == event.postId) {
              final updatedComments =
                  post.comments.where((c) => c.id != event.commentId).toList();
              return post.copyWith(
                comments: updatedComments,
                commentCount: post.commentCount > 0 ? post.commentCount - 1 : 0,
              );
            }
            return post;
          }).toList();

          emit(CommunityPostsLoaded(List.from(_cachedPosts)));
        },
      );
    });

    // ✅ Get replies
    on<GetRepliesEvent>((event, emit) async {
      emit(CommunityLoadingReplies());
      final result = await getRepliesUseCase(
        postId: event.postId,
        commentId: event.commentId,
        skip: event.skip,
        limit: event.limit,
      );

      result.fold(
        (error) => emit(CommunityError(error, posts: _safeCachedPosts())),
        (replies) {
          _cachedPosts = _cachedPosts.map((post) {
            if (post.id == event.postId) {
              final updatedComments = post.comments.map((c) {
                if (c.id == event.commentId) {
                  // return c.copyWith(replies: replies);
                }
                return c;
              }).toList();
              return post.copyWith(comments: updatedComments);
            }
            return post;
          }).toList();

          emit(CommunityPostsLoaded(List.from(_cachedPosts)));
        },
      );
    });

    // ✅ Create reply
    on<CreateReplyEvent>((event, emit) async {
      final result = await createReplyUseCase(
        postId: event.postId,
        commentId: event.commentId,
        content: event.content,
      );

      result.fold(
        (error) => emit(CommunityError(error, posts: _safeCachedPosts())),
        (reply) {
          _cachedPosts = _cachedPosts.map((post) {
            if (post.id == event.postId) {
              final updatedComments = post.comments.map((c) {
                if (c.id == event.commentId) {
                  // return c.copyWith(replies: [...c.replies, reply]);
                }
                return c;
              }).toList();
              return post.copyWith(comments: updatedComments);
            }
            return post;
          }).toList();

          emit(CommunityPostsLoaded(List.from(_cachedPosts)));
        },
      );
    });

    // ✅ Toggle comment like
    on<ToggleCommentLikeEvent>((event, emit) async {
      final result = await toggleCommentLikeUseCase(
        postId: event.postId,
        commentId: event.commentId,
      );

      result.fold(
        (error) => emit(CommunityError(error, posts: _safeCachedPosts())),
        (isLiked) {
          _cachedPosts = _cachedPosts.map((post) {
            if (post.id == event.postId) {
              final updatedComments = post.comments.map((c) {
                if (c.id == event.commentId) {
                  return c.copyWith(
                    isLikedByViewer: isLiked,
                    likeCount: isLiked
                        ? c.likeCount + 1
                        : (c.likeCount > 0 ? c.likeCount - 1 : 0),
                  );
                }
                return c;
              }).toList();
              return post.copyWith(comments: updatedComments);
            }
            return post;
          }).toList();

          emit(CommunityPostsLoaded(List.from(_cachedPosts)));
        },
      );
    });
  }

  List<PostModel> _safeCachedPosts() =>
      state is CommunityPostsLoaded ? (state as CommunityPostsLoaded).posts : _cachedPosts;
}
