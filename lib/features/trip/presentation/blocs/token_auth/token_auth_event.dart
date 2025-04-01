part of "token_auth_bloc.dart";

abstract class TokenAuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchTokenAuthToken extends TokenAuthEvent {}
