part of 'reply_bloc.dart';

abstract class ReplyState {}

class ReplyInitial extends ReplyState {}

class ReplyLoading extends ReplyState {
  final String commentId;
  ReplyLoading(this.commentId);
}

class RepliesLoaded extends ReplyState {
  final String commentId;
  final List<CommentModel> replies;
  RepliesLoaded(this.commentId, this.replies);
}

class ReplyAdded extends ReplyState {
  final String commentId;
  final ReplyModel reply;
  ReplyAdded(this.commentId, this.reply);
}

class ReplyError extends ReplyState {
  final String message;
  ReplyError(this.message);
}
