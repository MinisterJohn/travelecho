part of 'comment_bloc.dart';

abstract class CommentEvent {}

class CreateCommentEvent extends CommentEvent {
  final String postId;
  final String content;
  final String? parentComment;
  CreateCommentEvent(this.postId, this.content, {this.parentComment});
}

class GetCommentsEvent extends CommentEvent {
  final String postId;
  final int skip;
  final int limit;
  GetCommentsEvent(this.postId, {this.skip = 0, this.limit = 20});
}

class UpdateCommentEvent extends CommentEvent {
  final String postId;
  final String commentId;
  final String content;
  UpdateCommentEvent(this.postId, this.commentId, this.content);
}

class DeleteCommentEvent extends CommentEvent {
  final String postId;
  final String commentId;
  DeleteCommentEvent(this.postId, this.commentId);
}

class ToggleCommentLikeEvent extends CommentEvent {
  final String postId;
  final String commentId;
  ToggleCommentLikeEvent(this.postId, this.commentId);
}
