part of 'comment_bloc.dart';

abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {
  final String postId;
  CommentLoading(this.postId);
}

class CommentsLoaded extends CommentState {
  final String postId;
  final List<CommentModel> comments;
  CommentsLoaded(this.postId, this.comments);
}

class CommentAdded extends CommentState {
  final CommentModel comment;
  CommentAdded(this.comment);
}

class CommentUpdated extends CommentState {
  final String commentId;
  final String content;
  CommentUpdated(this.commentId, this.content);
}

class CommentDeleted extends CommentState {
  final String commentId;
  CommentDeleted(this.commentId);
}

class CommentLikeToggled extends CommentState {
  final String commentId;
  final bool isLiked;
  CommentLikeToggled(this.commentId, this.isLiked);
}

class CommentError extends CommentState {
  final String message;
  CommentError(this.message);
}
