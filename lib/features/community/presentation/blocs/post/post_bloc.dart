import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../../../community_exports.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final CreatePostUseCase createPost = sl();
  final AddPostMediaUseCase addPostMedia = sl(); // new use case
  final GetPostsUseCase getPosts = sl();
  final GetPostByIdUseCase getPostById = sl();
  final TogglePostLikeUseCase toggleLike = sl();
  final UpdatePostUseCase updatePost = sl();
  final DeletePostUseCase deletePost = sl();

  final Logger _logger = sl();

  List<PostModel> _cachedPosts = [];

  PostBloc() : super(PostInitial()) {
    on<CreatePostEvent>(_onCreatePost);
    on<CreatePostWithMediaEvent>(_onCreatePostWithMedia); // new handler
    on<GetPostsEvent>(_onGetPosts);
    on<TogglePostLikeEvent>(_onToggleLike);
    on<GetPostByIdEvent>(_onGetPostById);
    // on<UpdatePostEvent>(_onUpdatePost);
    on<DeletePostEvent>(_onDeletePost);
  }

  Future<void> _onCreatePost(CreatePostEvent e, Emitter<PostState> emit) async {
    emit(PostLoading());
    final result = await createPost(e.formData);
    result.fold((err) => emit(PostError(err)), (post) {
      _cachedPosts.insert(0, post);
      emit(PostsLoaded(List.from(_cachedPosts)));
    });
  }

  Future<void> _onCreatePostWithMedia(
    CreatePostWithMediaEvent e,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoading());
    final result = await createPost(e.formData);

    await result.fold((err) async => emit(PostError(err)), (post) async {
      // If there are files to upload, call AddPostMediaUseCase
      if (e.mediaFiles.isNotEmpty) {
        final mediaResult = await addPostMedia(
          postId: post.id,
          files: e.mediaFiles,
        );
        mediaResult.fold(
          (err) => _logger.e("Media upload failed: $err"), // optional logging
          (filesInfo) => _logger.i("Media uploaded: $filesInfo"),
        );
      }

      _cachedPosts.insert(0, post);
      emit(PostsLoaded(List.from(_cachedPosts)));
    });
  }

  Future<void> _onGetPosts(GetPostsEvent e, Emitter<PostState> emit) async {
    emit(PostLoading());
    final result = await getPosts(skip: e.skip, limit: e.limit);
    result.fold((err) => emit(PostError(err)), (posts) {
      _cachedPosts = posts;
      emit(PostsLoaded(List.from(_cachedPosts)));
    });
  }

  Future<void> _onGetPostById(
    GetPostByIdEvent e,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoading());
    final result = await getPostById(e.postId);
    result.fold((err) => emit(PostError(err)), (post) {
      final index = _cachedPosts.indexWhere((p) => p.id == post.id);
      if (index >= 0) {
        _cachedPosts[index] = post;
      } else {
        _cachedPosts.add(post);
      }
      emit(PostLoaded(post));
    });
  }

  Future<void> _onToggleLike(
    TogglePostLikeEvent e,
    Emitter<PostState> emit,
  ) async {
    final result = await toggleLike(e.postId);
    result.fold((err) => emit(PostError(err)), (isLiked) {
      _cachedPosts =
          _cachedPosts.map((p) {
            if (p.id == e.postId) {
              return p.copyWith(
                isLikedByViewer: isLiked,
                likeCount:
                    isLiked
                        ? p.likeCount + 1
                        : (p.likeCount > 0 ? p.likeCount - 1 : 0),
              );
            }
            return p;
          }).toList();
      emit(PostsLoaded(List.from(_cachedPosts)));
    });
  }

  Future<void> _onDeletePost(DeletePostEvent e, Emitter<PostState> emit) async {
    final result = await deletePost(e.postId);
    result.fold((err) => emit(PostError(err)), (_) {
      _cachedPosts.removeWhere((p) => p.id == e.postId);
      emit(PostsLoaded(List.from(_cachedPosts)));
    });
  }
}
