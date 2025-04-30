import 'package:dartz/dartz.dart';
import '../../auth_exports.dart';

abstract class AuthRepository {
  // Future<Either> login(String email, String password);
  Future<Either> signin(SigninReqParams params);
  Future<Either> signup(SignupReqParams params);
  Future<bool> isLoggedIn();
  Future<bool> isNotNewUser();
  // Future<Either> resetPassword(String email);

  // OTP Verification
  Future<Either<String, bool>> sendOtp(String email);
  Future<Either<String, bool>> verifyOtp(String email, String otp);
  Future<Either> resetPassword(
      String email, String password, String confirmPassword);
}
