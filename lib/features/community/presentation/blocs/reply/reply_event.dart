part of 'reply_bloc.dart';

abstract class ReplyEvent {}

class GetRepliesEvent extends ReplyEvent {
  final String postId;
  final String commentId;
  final int skip;
  final int limit;
  GetRepliesEvent(this.postId, this.commentId, {this.skip = 0, this.limit = 10});
}

class CreateReplyEvent extends ReplyEvent {
  final String postId;
  final String commentId;
  final String content;
  CreateReplyEvent(this.postId, this.commentId, this.content);
}
