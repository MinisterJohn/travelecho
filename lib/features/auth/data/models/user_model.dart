import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? email;
  final String? fullname;
  final String? token;
  final String? profileId;

  const User({
    required this.id,
    this.email,
    this.fullname,
    this.token,
    this.profileId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      fullname: json['name'] ?? '',
      token: json['token'] ?? '',
      profileId: json['profileId']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullname': fullname,
      'token': token,
      'profileId': profileId,
    };
  }

  @override
  List<Object?> get props => [id, email, fullname, token, profileId];
}
