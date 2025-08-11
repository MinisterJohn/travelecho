import 'package:dartz/dartz.dart';
import '../../auth_exports.dart';


abstract class AuthApiService {
  Future<Either<String, Map<String, dynamic>>> signin(SigninReqParams params);
  Future<Either<String, Map<String, dynamic>>> signup(SignupReqParams params);
  Future<Either<String, bool>> sendOtp(String email);
  Future<Either<String, bool>> recoveryResendOtp(String email);
  Future<Either<String, bool>> verifyOtp(String email, String otp);
  Future<Either<String, bool>> recoveryVerifyOtp(String email, String otp);
  Future<Either<String, Map<String, dynamic>>> resetPassword(
      String email, String password, String confirmPassword);
  Future<Either<String, Map<String, dynamic>>> getUserProfile();
}