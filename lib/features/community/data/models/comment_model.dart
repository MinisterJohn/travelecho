import 'package:equatable/equatable.dart';


// targetType: "memory" or "post"
class CommentModel extends Equatable {
  final String id;
  final String targetId; 
  final String targetType; 
  final String userId;
  final String name;
  final String imageUrl;
  final String text;
  final DateTime createdAt;

  const CommentModel({
    required this.id,
    required this.targetId,
    required this.targetType,
    required this.userId,
    required this.name,
    required this.imageUrl,
    required this.text,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id']?.toString() ?? '',
      targetId: json['targetId'] ?? '',
      targetType: json['targetType'] ?? 'post',
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      text: json['text'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'targetId': targetId,
      'targetType': targetType,
      'userId': userId,
      'name': name,
      'imageUrl': imageUrl,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        targetId,
        targetType,
        userId,
        name,
        imageUrl,
        text,
        createdAt,
      ];
}
