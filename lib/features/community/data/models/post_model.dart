import '../../community_exports.dart';

class PostModel extends PostEntity {
  final List<CommentModel> comments; // ✅ added

  const PostModel({
    required super.id,
    required super.isEdited,
    required super.content,
    required super.tags,
    required super.isPublic,
    required super.media,
    required super.author,
    required super.authorId,
    required super.likeCount,
    required super.commentCount,
    required super.isLikedByViewer,
    required super.isViewedByAuthor,
    required super.repostCount,
    super.authorImage,
    required super.authorProfileId,
    required super.createdAt,
    this.comments = const [], // ✅ default empty
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['_id'],
      media:
          (json['media'] as List<dynamic>?)
              ?.map((m) => m['url'] as String)
              .toList() ??
          [],
      content: json['content'],
      tags: List<String>.from(json['tags'] ?? []),
      isPublic: json['isPublic'] ?? false,
      likeCount: json['likeCount'] ?? 0,
      commentCount: json['commentCount'] ?? 0,
      repostCount: json['repostCount'] ?? 0,
      isEdited: json['isEdited'] ?? false,
      authorId: json['author']["_id"],
      author: json['author']["name"],
      authorImage: json['author']["image"],
      authorProfileId: json['author']["profileId"],
      isLikedByViewer: json['isLikedByViewer'] ?? false,
      isViewedByAuthor: json['isViewedByAuthor'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      comments: [],
    );
  }

  /// ✅ copyWith method
  PostModel copyWith({
    String? id,
    bool? isEdited,
    String? content,
    List<String>? tags,
    bool? isPublic,
    List<String>? media,
    String? author,
    String? authorId,
    int? likeCount,
    int? commentCount,
    bool? isLikedByViewer,
    bool? isViewedByAuthor,
    int? repostCount,
    String? authorImage,
    String? authorProfileId,
    DateTime? createdAt,
    List<CommentModel>? comments,
  }) {
    return PostModel(
      id: id ?? this.id,
      isEdited: isEdited ?? this.isEdited,
      content: content ?? this.content,
      tags: tags ?? this.tags,
      isPublic: isPublic ?? this.isPublic,
      media: media ?? this.media,
      author: author ?? this.author,
      authorId: authorId ?? this.authorId,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      repostCount: repostCount ?? this.repostCount,
      isLikedByViewer: isLikedByViewer ?? this.isLikedByViewer,
      isViewedByAuthor: isViewedByAuthor ?? this.isViewedByAuthor,
      authorImage: authorImage ?? this.authorImage,
      authorProfileId: authorProfileId ?? this.authorProfileId,
      createdAt: createdAt ?? this.createdAt,
      comments: comments ?? this.comments,
    );
  }
}
