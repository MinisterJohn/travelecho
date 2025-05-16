import 'package:dartz/dartz.dart';
import "../../auth_exports.dart";

class SigninUseCase
    extends UseCases<Either<String, Map<String, dynamic>>, SigninReqParams> {
  @override
  Future<Either<String, Map<String, dynamic>>> call(
      {SigninReqParams? params}) async {
    return await sl<AuthRepository>().signin(params!);
  }
}

class SignupUseCase
    extends UseCases<Either<String, Map<String, dynamic>>, SignupReqParams> {
  @override
  Future<Either<String, Map<String, dynamic>>> call(
      {SignupReqParams? params}) async {
    return await sl<AuthRepository>().signup(params!);
  }
}

class IsLoggedInUseCase extends UseCases<bool, dynamic> {
  @override
  Future<bool> call({params}) async {
    return await sl<AuthRepository>().isLoggedIn();
  }
}

class IsNotNewUserUseCase extends UseCases<bool, dynamic> {
  @override
  Future<bool> call({params}) async {
    return await sl<AuthRepository>().isNotNewUser();
  }
}

class SendOtpUseCase extends UseCases<Either<String, bool>, String> {
  final AuthRepository repository = sl<AuthRepository>();

  @override
  Future<Either<String, bool>> call({String? params}) async {
    return await repository.sendOtp(params!);
  }
}

class VerifyOtpUseCase
    extends UseCases<Either<String, bool>, Map<String, String>> {
  final AuthRepository repository = sl<AuthRepository>();

  @override
  Future<Either<String, bool>> call({Map<String, String>? params}) async {
    return await repository.verifyOtp(params!['email']!, params['otp']!);
  }
}

class ResetPasswordUseCase extends UseCases<
    Either<String, Map<String, dynamic>>, Map<String, String>> {
  @override
  Future<Either<String, Map<String, dynamic>>> call(
      {Map<String, String>? params}) async {
    return await sl<AuthRepository>().resetPassword(
      params!['email']!,
      params['password']!,
      params['confirmPassword']!,
    );
  }
}
