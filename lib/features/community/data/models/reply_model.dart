import '../../community_exports.dart';

class ReplyModel extends ReplyEntity {
  const ReplyModel({
    required super.id,
    required super.postId,
    required super.commentId,
    required super.authorId,
    required super.authorName,
    super.authorImage,
    required super.content,
    required super.createdAt,
    required super.isLikedByViewer,
    required super.likeCount,
  });

  factory ReplyModel.fromJson(Map<String, dynamic> json) {
    return ReplyModel(
      id: json['_id'] as String,
      postId: json['postId'] as String,
      commentId: json['commentId'] as String,
      authorId: json['author']['id'] as String,
      authorName: json['author']['name'] as String,
      authorImage: json['author']['image'],
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isLikedByViewer: json['isLikedByViewer'] ?? false,
      likeCount: json['likeCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "postId": postId,
      "commentId": commentId,
      "author": {
        "id": authorId,
        "name": authorName,
        "image": authorImage,
      },
      "content": content,
      "createdAt": createdAt.toIso8601String(),
      "isLikedByViewer": isLikedByViewer,
      "likeCount": likeCount,
    };
  }
}
