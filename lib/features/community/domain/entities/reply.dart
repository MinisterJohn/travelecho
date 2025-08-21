import 'package:equatable/equatable.dart';

class ReplyEntity extends Equatable {
  final String id;
  final String postId;
  final String commentId;
  final String authorId;
  final String authorName;
  final String? authorImage;
  final String content;
  final DateTime createdAt;
  final bool isLikedByViewer;
  final int likeCount;

  const ReplyEntity({
    required this.id,
    required this.postId,
    required this.commentId,
    required this.authorId,
    required this.authorName,
    this.authorImage,
    required this.content,
    required this.createdAt,
    required this.isLikedByViewer,
    required this.likeCount,
  });

  @override
  List<Object?> get props => [
        id,
        postId,
        commentId,
        authorId,
        authorName,
        authorImage,
        content,
        createdAt,
        isLikedByViewer,
        likeCount,
      ];
}
