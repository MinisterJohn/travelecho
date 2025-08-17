import 'package:equatable/equatable.dart';
import '../../memories_exports.dart'; // import your badge model here

class MemoryModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime date;
  final List<dynamic> images;
  final List<String> tags;
  final String userId;
  final String name;
  final String email;
  final bool isPublic;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// 🔥 New fields
  final bool hasEarnedNewBadge;
  final BadgeModel? badge;

  const MemoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.images,
    required this.tags,
    required this.userId,
    required this.name,
    required this.email,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
    this.hasEarnedNewBadge = false,
    this.badge,
  });

  factory MemoryModel.fromJson(Map<String, dynamic> json) {
    // Support both top-level and nested memory object
    final memoryJson =
        json.containsKey('memory') && json['memory'] is Map<String, dynamic>
            ? json['memory'] as Map<String, dynamic>
            : json;
    return MemoryModel(
      id: memoryJson['_id']?.toString() ?? '',
      title: memoryJson['title'] ?? '',
      description: memoryJson['description'] ?? '',
      location: memoryJson['location'] ?? '',
      date:
          memoryJson['date'] != null
              ? DateTime.parse(memoryJson['date'])
              : (memoryJson['createdAt'] != null
                  ? DateTime.parse(memoryJson['createdAt'])
                  : DateTime.now()),
      images: List<dynamic>.from(memoryJson['images'] ?? []),
      tags: List<String>.from(memoryJson['tags'] ?? []),
      userId: memoryJson['userId']?.toString() ?? '',
      name: memoryJson['name'] ?? '',
      email: memoryJson['email'] ?? '',
      isPublic: memoryJson['isPublic'] ?? false,
      createdAt:
          memoryJson['createdAt'] != null
              ? DateTime.parse(memoryJson['createdAt'])
              : DateTime.now(),
      updatedAt:
          memoryJson['updatedAt'] != null
              ? DateTime.parse(memoryJson['updatedAt'])
              : DateTime.now(),
      hasEarnedNewBadge:
          json['hasEarnedNewBadge'] == true ||
          json['hasEarnedNewBadge'] == 'true',
      badge: json['badge'] != null ? BadgeModel.fromJson(json['badge']) : null,
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
      'name': name,
      'email': email,
      'isPublic': isPublic,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'hasEarnedNewBadge': hasEarnedNewBadge,
      'badge': badge,
    };
  }

  MemoryModel copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    DateTime? date,
    List<dynamic>? images,
    List<String>? tags,
    String? userId,
    String? name,
    String? email,
    bool? isPublic,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? hasEarnedNewBadge,
    BadgeModel? badge,
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
      name: name ?? this.name,
      email: email ?? this.email,
      isPublic: isPublic ?? this.isPublic,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      hasEarnedNewBadge: hasEarnedNewBadge ?? this.hasEarnedNewBadge,
      badge: badge ?? this.badge,
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
    name,
    email,
    isPublic,
    createdAt,
    updatedAt,
    hasEarnedNewBadge,
    badge,
  ];
}

/// Collection model stays the same
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
      createdAt:
          json['createdAt'] != null
              ? DateTime.parse(json['createdAt'])
              : DateTime.now(),
      updatedAt:
          json['updatedAt'] != null
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
