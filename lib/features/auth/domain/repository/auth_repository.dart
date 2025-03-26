import 'package:dartz/dartz.dart';
import 'package:travelecho/features/auth/data/models/signup_req_params.dart';
import 'package:travelecho/features/auth/data/models/signin_req_params.dart';

abstract class AuthRepository {
  // Future<Either> login(String email, String password);
  Future<Either> signin(SigninReqParams params);
  Future<Either> signup(SignupReqParams params);
  Future<bool> isLoggedIn();
  Future<bool> isNotNewUser();
  // Future<Either> resetPassword(String email);
}
