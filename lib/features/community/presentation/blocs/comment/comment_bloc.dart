import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../community_exports.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CreateCommentUseCase createComment = sl();
  final GetCommentsUseCase getComments = sl();
  final UpdateCommentUseCase updateComment = sl();
  final DeleteCommentUseCase deleteComment = sl();
  final ToggleCommentLikeUseCase toggleCommentLike = sl();

  // 🔹 Cache comments per postId
  final Map<String, List<CommentModel>> _commentsCache = {};

  CommentBloc() : super(CommentInitial()) {
    on<CreateCommentEvent>(_onCreateComment);
    on<GetCommentsEvent>(_onGetComments);
    on<UpdateCommentEvent>(_onUpdateComment);
    on<DeleteCommentEvent>(_onDeleteComment);
    on<ToggleCommentLikeEvent>(_onToggleCommentLike);
  }

  Future<void> _onCreateComment(
    CreateCommentEvent e,
    Emitter<CommentState> emit,
  ) async {
    final result = await createComment(
      postId: e.postId,
      content: e.content,
      parentComment: e.parentComment,
    );

    result.fold((err) => emit(CommentError(err)), (comment) {
      final current = _commentsCache[e.postId] ?? [];
      _commentsCache[e.postId] = [comment, ...current]; // prepend new comment
      emit(CommentsLoaded(e.postId, List.from(_commentsCache[e.postId]!)));
    });
  }

  Future<void> _onGetComments(
    GetCommentsEvent e,
    Emitter<CommentState> emit,
  ) async {
    // Serve cached comments first if available
    if (_commentsCache.containsKey(e.postId)) {
      emit(CommentsLoaded(e.postId, List.from(_commentsCache[e.postId]!)));
    }

    emit(CommentLoading(e.postId));

    final result = await getComments(
      postId: e.postId,
      skip: e.skip,
      limit: e.limit,
    );
    result.fold((err) => emit(CommentError(err)), (comments) {
      _commentsCache[e.postId] = comments;
      emit(CommentsLoaded(e.postId, List.from(comments)));
    });
  }

  Future<void> _onUpdateComment(
    UpdateCommentEvent e,
    Emitter<CommentState> emit,
  ) async {
    final result = await updateComment(
      postId: e.postId,
      commentId: e.commentId,
      content: e.content,
    );

    result.fold((err) => emit(CommentError(err)), (_) {
      final current = _commentsCache[e.postId] ?? [];
      final idx = current.indexWhere((c) => c.id == e.commentId);
      if (idx != -1) {
        current[idx] = current[idx].copyWith(content: e.content);
      }
      emit(CommentsLoaded(e.postId, List.from(current)));
    });
  }

  Future<void> _onDeleteComment(
    DeleteCommentEvent e,
    Emitter<CommentState> emit,
  ) async {
    final result = await deleteComment(
      postId: e.postId,
      commentId: e.commentId,
    );

    result.fold((err) => emit(CommentError(err)), (_) {
      final current = _commentsCache[e.postId] ?? [];
      current.removeWhere((c) => c.id == e.commentId);
      emit(CommentsLoaded(e.postId, List.from(current)));
    });
  }

  Future<void> _onToggleCommentLike(
    ToggleCommentLikeEvent e,
    Emitter<CommentState> emit,
  ) async {
    final result = await toggleCommentLike(
      postId: e.postId,
      commentId: e.commentId,
    );

    result.fold((err) => emit(CommentError(err)), (isLiked) {
      final current = _commentsCache[e.postId] ?? [];
      final idx = current.indexWhere((c) => c.id == e.commentId);
      if (idx != -1) {
        final c = current[idx];
        current[idx] = c.copyWith(
          isLikedByViewer: isLiked,
          likeCount: isLiked ? c.likeCount + 1 : c.likeCount - 1,
        );
      }
      emit(CommentsLoaded(e.postId, List.from(current)));
    });
  }
}
