part of 'user_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class SignupEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;

  SignupEvent({
    required this.email,
    required this.password,
    required this.name,
  });
}

class LogoutEvent extends AuthEvent {
  final String email;

  LogoutEvent({required this.email});
}

class VerifyOtpEvent extends AuthEvent {
  final String email;
  final String otp;

  VerifyOtpEvent({required this.email, required this.otp});
}

class RecoveryVerifyOtpEvent extends AuthEvent {
  final String email;
  final String otp;

  RecoveryVerifyOtpEvent({required this.email, required this.otp});
}

class CheckAuthStatus extends AuthEvent {}

class ResetPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  ResetPasswordEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class SendOtpEvent extends AuthEvent {
  final String email;

  SendOtpEvent({required this.email});
}

class RecoveryResendOtpEvent extends AuthEvent {
  final String email;

  RecoveryResendOtpEvent({required this.email});
}
