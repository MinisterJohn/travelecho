part of "token_auth_bloc.dart";

abstract class TokenAuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class TokenAuthInitial extends TokenAuthState {}

class TokenAuthLoading extends TokenAuthState {}

class TokenAuthLoaded extends TokenAuthState {
  final String token;

  TokenAuthLoaded(this.token);

  @override
  List<Object> get props => [token];
}

class TokenAuthError extends TokenAuthState {
  final String message;

  TokenAuthError(this.message);

  @override
  List<Object> get props => [message];
}
