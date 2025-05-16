part of 'user_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final User? user;
  AuthLoginSuccess(this.user);
}

class AuthSignupSuccess extends AuthState {
  final String email;
  AuthSignupSuccess({required this.email});
}
class AuthSuccess extends AuthState {

}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}
