import 'package:dartz/dartz.dart';
import 'package:travelecho/core/usecases/usecases.dart';
import 'package:travelecho/features/auth/data/models/signup_req_params.dart';
import 'package:travelecho/features/auth/domain/repository/auth_repository.dart';
import 'package:travelecho/service_locator.dart';
import 'package:travelecho/features/auth/data/models/signin_req_params.dart';
import 'package:travelecho/features/auth/data/models/otp_verification_model.dart';

// class Login {
//   final AuthRepository repository;
//   Login(this.repository);

//   Future<void> call(String email, String password) {
//     return repository.login(email, password);
//   }
// }

class SigninUseCase extends UseCases<Either, SigninReqParams> {
  @override
  Future<Either> call({SigninReqParams? params}) async {
    return await sl<AuthRepository>().signin(params!);
  }
}

class SignupUseCase extends UseCases<Either, SignupReqParams> {
  @override
  Future<Either> call({SignupReqParams? params}) async {
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

// class ResetPassword {
//   final AuthRepository repository;
//   ResetPassword(this.repository);

//   Future<void> call(String email) {
//     return repository.resetPassword(email);
//   }
// }

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

class ResetPasswordUseCase extends UseCases<Either, Map<String, String>> {
  @override
  Future<Either> call({Map<String, String>? params}) async {
    return await sl<AuthRepository>().resetPassword(
      params!['email']!,
      params['password']!,
      params['confirmPassword']!,
    );
  }
}
