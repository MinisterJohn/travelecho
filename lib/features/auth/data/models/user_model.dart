import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String fullname;
  final String token;
  final String profileId;

  const User(
      {required this.id,
      required this.email,
      required this.fullname,
      required this.token, required this.profileId});

  @override
  List<Object> get props => [id, email, fullname, token, profileId];
}
