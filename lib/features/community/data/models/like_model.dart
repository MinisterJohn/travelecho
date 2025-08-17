import 'package:equatable/equatable.dart';


class LikeModel extends Equatable {
  final String id;
  final String targetId;
  final String targetType; // "memory" or "post"
  final String userId;

  const LikeModel({
    required this.id,
    required this.targetId,
    required this.targetType,
    required this.userId,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      id: json['id']?.toString() ?? '',
      targetId: json['targetId'] ?? '',
      targetType: json['targetType'] ?? 'post',
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'targetId': targetId,
      'targetType': targetType,
      'userId': userId,
    };
  }

  @override
  List<Object?> get props => [id, targetId, targetType, userId];
}
