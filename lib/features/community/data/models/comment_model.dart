import '../../community_exports.dart';

class AuthorModel extends AuthorEntity {
  const AuthorModel({
    required super.id,
    required super.name,
    required super.image,
    required super.profileId,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      profileId: json['profileId'],
    );
  }
}

class CommentModel extends CommentEntity {
  final List<ReplyModel> replies;

  const CommentModel({
    required super.id,
    required super.author,
    required super.postId,
    required super.content,
    required super.likeCount,
    required super.replyCount,
    required super.reportedCount,
    required super.isEdited,
    required super.isReplying,
    required super.isLikedByViewer,
    required super.isViewedByAuthor,
    required super.createdAt,
    required super.updatedAt,
    required this.replies,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'],
      author: AuthorModel.fromJson(json['author']),
      postId: json['post'],
      content: json['content'],
      likeCount: json['likeCount'] ?? 0,
      replyCount: json['replyCount'] ?? 0,
      reportedCount: json['reportedCount'] ?? 0,
      isEdited: json['isEdited'] ?? false,
      isReplying: json['isReplying'] ?? false,
      isLikedByViewer: json['isLikedByViewer'] ?? false,
      isViewedByAuthor: json['isViewedByAuthor'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      replies: [],
    );
  }

  /// ✅ copyWith
  CommentModel copyWith({
    String? id,
    AuthorEntity? author,
    String? postId,
    String? content,
    int? likeCount,
    int? replyCount,
    List<ReplyModel>? replies,
    int? reportedCount,
    bool? isEdited,
    bool? isReplying,
    bool? isLikedByViewer,
    bool? isViewedByAuthor,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CommentModel(
      id: id ?? this.id,
      author: author ?? this.author,
      postId: postId ?? this.postId,
      content: content ?? this.content,
      likeCount: likeCount ?? this.likeCount,
      replyCount: replyCount ?? this.replyCount,
      replies: replies ?? this.replies,
      reportedCount: reportedCount ?? this.reportedCount,
      isEdited: isEdited ?? this.isEdited,
      isReplying: isReplying ?? this.isReplying,
      isLikedByViewer: isLikedByViewer ?? this.isLikedByViewer,
      isViewedByAuthor: isViewedByAuthor ?? this.isViewedByAuthor,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
