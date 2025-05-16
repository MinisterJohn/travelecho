import 'package:equatable/equatable.dart';
import '../../auth_exports.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final bool verified;
  final String plan;
  final dynamic subscription;
  final Profile profile;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String role;
  final String? token;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.verified,
    required this.plan,
    this.subscription,
    required this.profile,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      verified: json['verified'] ?? false,
      plan: json['plan'] ?? 'FREE',
      subscription: json['subscription'],
      profile: Profile.fromJson(json['profile'] ?? {}),
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      role: json['role'] ?? 'USER',
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'verified': verified,
      'plan': plan,
      'subscription': subscription,
      'profile': profile.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'role': role,
      'token': token,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        verified,
        plan,
        subscription,
        profile,
        createdAt,
        updatedAt,
        role,
        token,
      ];
}
