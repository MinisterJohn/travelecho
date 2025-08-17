import 'package:equatable/equatable.dart';

class CommunityPostModel extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String imageUrl;
  final String content; // text content
  final List<String> mediaUrls; // images/videos
  final List<String> tags; // e.g., ["Paris", "Tips"]
  final bool isPublic;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CommunityPostModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.imageUrl,
    required this.content,
    required this.mediaUrls,
    required this.tags,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommunityPostModel.fromJson(Map<String, dynamic> json) {
    return CommunityPostModel(
      id: json['id']?.toString() ?? '',
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      content: json['content'] ?? '',
      mediaUrls: List<String>.from(json['mediaUrls'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      isPublic: json['isPublic'] ?? true, // default true for community posts
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'imageUrl': imageUrl,
      'content': content,
      'mediaUrls': mediaUrls,
      'tags': tags,
      'isPublic': isPublic,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        imageUrl,
        content,
        mediaUrls,
        tags,
        isPublic,
        createdAt,
        updatedAt,
      ];
}
