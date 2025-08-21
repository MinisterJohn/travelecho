part of 'community_bloc.dart';

abstract class CommunityEvent extends Equatable {
  const CommunityEvent();

  @override
  List<Object?> get props => [];
}

// ----------------- Posts -----------------
class CreatePostEvent extends CommunityEvent {
  final FormData formData;
  const CreatePostEvent(this.formData);

  @override
  List<Object?> get props => [formData];
}

class GetPostsEvent extends CommunityEvent {
  final int skip;
  final int limit;
  const GetPostsEvent({this.skip = 0, this.limit = 10});

  @override
  List<Object?> get props => [skip, limit];
}

class ToggleLikeEvent extends CommunityEvent {
  final String postId;
  const ToggleLikeEvent(this.postId);

  @override
  List<Object?> get props => [postId];
}

// ----------------- Comments -----------------
class CreateCommentEvent extends CommunityEvent {
  final String postId;
  final String content;
  final String? parentComment;

  const CreateCommentEvent({
    required this.postId,
    required this.content,
    this.parentComment,
  });

  @override
  List<Object?> get props => [postId, content, parentComment];
}

class GetCommentsEvent extends CommunityEvent {
  final String postId;
  final int skip;
  final int limit;
  final String? sort;
  final String? select;
  final String? populate;

  const GetCommentsEvent({
    required this.postId,
    this.skip = 0,
    this.limit = 10,
    this.sort,
    this.select,
    this.populate,
  });

  @override
  List<Object?> get props => [postId, skip, limit, sort, select, populate];
}

class UpdateCommentEvent extends CommunityEvent {
  final String postId;
  final String commentId;
  final String content;

  const UpdateCommentEvent({
    required this.postId,
    required this.commentId,
    required this.content,
  });

  @override
  List<Object?> get props => [postId, commentId, content];
}

class DeleteCommentEvent extends CommunityEvent {
  final String postId;
  final String commentId;

  const DeleteCommentEvent({
    required this.postId,
    required this.commentId,
  });

  @override
  List<Object?> get props => [postId, commentId];
}

class ToggleCommentLikeEvent extends CommunityEvent {
  final String postId;
  final String commentId;

  const ToggleCommentLikeEvent({
    required this.postId,
    required this.commentId,
  });

  @override
  List<Object?> get props => [postId, commentId];
}

// ----------------- Replies -----------------
class GetRepliesEvent extends CommunityEvent {
  final String postId;
  final String commentId;
  final int skip;
  final int limit;

  const GetRepliesEvent({
    required this.postId,
    required this.commentId,
    this.skip = 0,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [postId, commentId, skip, limit];
}

class CreateReplyEvent extends CommunityEvent {
  final String postId;
  final String commentId;
  final String content;

  const CreateReplyEvent({
    required this.postId,
    required this.commentId,
    required this.content,
  });

  @override
  List<Object?> get props => [postId, commentId, content];
}
