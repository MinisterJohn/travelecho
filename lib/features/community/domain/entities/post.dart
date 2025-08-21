import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String id;
  final String content;
  final List<String> tags;
  final bool isPublic;
  final List<String> media;
  final String author;
  final String authorId;
  final int likeCount;
  final int commentCount;
  final bool isLikedByViewer;
  final bool isViewedByAuthor;
  final int repostCount;
  final String? authorImage;
  final String authorProfileId;
  final bool isEdited;
  final DateTime createdAt;

  const PostEntity({
    required this.id,
    required this.isEdited,
    required this.content,
    required this.tags,
    required this.isPublic,
    required this.media,
    required this.createdAt,
    required this.author,
    required this.authorId,
    required this.likeCount,
    required this.commentCount,
    required this.isLikedByViewer,
    required this.isViewedByAuthor,
    required this.repostCount,
    this.authorImage,
    required this.authorProfileId,
  });

  @override
  List<Object?> get props => [
    id,
    content,
    tags,
    isPublic,
    media,
    author,
    authorId,
    likeCount,
    commentCount,
    isLikedByViewer,
    isViewedByAuthor,
    repostCount,
    authorImage,
    authorProfileId,
  ];
}
