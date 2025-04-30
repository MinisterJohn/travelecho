import 'package:equatable/equatable.dart';
import "../../memories_exports.dart";

class MemoryModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime date;
  final List<String> images;
  final List<String> tags;
  final String userId;
  final User user;
  final bool isPublic;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MemoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.images,
    required this.tags,
    required this.userId,
    required this.user,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MemoryModel.fromJson(Map<String, dynamic> json) {
    return MemoryModel(
      id: json['_id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      images: List<String>.from(json['images'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      userId: json['userId']?.toString() ?? '',
      user: User.fromJson(json['user'] ?? {}),
      isPublic: json['isPublic'] ?? false,
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
      'title': title,
      'description': description,
      'location': location,
      'date': date.toIso8601String(),
      'images': images,
      'tags': tags,
      'userId': userId,
      'user': user.toJson(),
      'isPublic': isPublic,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  MemoryModel copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    DateTime? date,
    List<String>? images,
    List<String>? tags,
    String? userId,
    User? user,
    bool? isPublic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MemoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      date: date ?? this.date,
      images: images ?? this.images,
      tags: tags ?? this.tags,
      userId: userId ?? this.userId,
      user: user ?? this.user,
      isPublic: isPublic ?? this.isPublic,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        location,
        date,
        images,
        tags,
        userId,
        user,
        isPublic,
        createdAt,
        updatedAt,
      ];
}

class CollectionModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String coverImageUrl;
  final String userId;
  final bool isPublic;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CollectionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.coverImageUrl,
    required this.userId,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      coverImageUrl: json['coverImageUrl'] ?? '',
      userId: json['userId']?.toString() ?? '',
      isPublic: json['isPublic'] ?? false,
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
      'name': name,
      'description': description,
      'coverImageUrl': coverImageUrl,
      'userId': userId,
      'isPublic': isPublic,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  CollectionModel copyWith({
    String? id,
    String? name,
    String? description,
    String? coverImageUrl,
    String? userId,
    bool? isPublic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CollectionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      userId: userId ?? this.userId,
      isPublic: isPublic ?? this.isPublic,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        coverImageUrl,
        userId,
        isPublic,
        createdAt,
        updatedAt,
      ];
}
