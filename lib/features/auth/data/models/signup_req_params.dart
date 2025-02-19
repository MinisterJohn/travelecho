// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:travelecho/features/auth/domain/entities/user_entity.dart';

class UserModel extends User {
  UserModel(
      {required String id, required String email, required String fullname})
      : super(id: id, email: email, fullname: fullname);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'], email: json['email'], fullname: json['fullname']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email};
  }
}

class SignupReqParams {
  final String email;
  final String password;
  final String name;

  SignupReqParams({
    required this.email,
    required this.password,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'fullname': name,
    };
  }



  @override
  String toString() => 'SignupReqParams(email: $email, password: $password, fullname: $name)';

}
