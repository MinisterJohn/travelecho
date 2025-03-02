import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String fullname;
  final String token;

  const User(
      {required this.id,
      required this.email,
      required this.fullname,
      required this.token});

  @override
  List<Object> get props => [id, email, fullname, token];
}
