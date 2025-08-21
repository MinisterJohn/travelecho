import 'package:equatable/equatable.dart';

class AuthorEntity extends Equatable {
  final String id;
  final String name;
  final String? image;
  final String profileId;

  const AuthorEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.profileId,
  });

  @override
  List<Object?> get props => [id, name, image, profileId];
}

class CommentEntity extends Equatable {
  final String id;
  final AuthorEntity author;
  final String postId;
  final String content;
  final int likeCount;
  final int replyCount;
  final int reportedCount;
  final bool isEdited;
  final bool isReplying;
  final bool isLikedByViewer;
  final bool isViewedByAuthor;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CommentEntity({
    required this.id,
    required this.author,
    required this.postId,
    required this.content,
    required this.likeCount,
    required this.replyCount,
    required this.reportedCount,
    required this.isEdited,
    required this.isReplying,
    required this.isLikedByViewer,
    required this.isViewedByAuthor,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        author,
        postId,
        content,
        likeCount,
        replyCount,
        reportedCount,
        isEdited,
        isReplying,
        isLikedByViewer,
        isViewedByAuthor,
        createdAt,
        updatedAt,
      ];
}
