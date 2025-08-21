import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../community_exports.dart';

part 'reply_event.dart';
part 'reply_state.dart';

class ReplyBloc extends Bloc<ReplyEvent, ReplyState> {
  final GetRepliesUseCase getReplies = sl();
  final CreateReplyUseCase createReply = sl();

  ReplyBloc() : super(ReplyInitial()) {
    on<GetRepliesEvent>(_onGetReplies);
    on<CreateReplyEvent>(_onCreateReply);
  }

  Future<void> _onGetReplies(
    GetRepliesEvent e,
    Emitter<ReplyState> emit,
  ) async {
    emit(ReplyLoading(e.commentId));
    final result = await getReplies(
      postId: e.postId,
      commentId: e.commentId,
      skip: e.skip,
      limit: e.limit,
    );
    result.fold(
      (err) => emit(ReplyError(err)),
      (comments) => emit(
        RepliesLoaded(
          e.commentId,
          comments,
        ),
      ),
    );
  }

  Future<void> _onCreateReply(
    CreateReplyEvent e,
    Emitter<ReplyState> emit,
  ) async {
    final result = await createReply(
      postId: e.postId,
      commentId: e.commentId,
      content: e.content,
    );
    result.fold(
      (err) => emit(ReplyError(err)),
      (comment) => emit(ReplyAdded(e.commentId, comment.replies.first)),
    );
  }
}
