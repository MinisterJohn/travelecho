import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../../trip_exports.dart";

part 'token_auth_event.dart';
part 'token_auth_state.dart';

class TokenAuthBloc extends Bloc<TokenAuthEvent, TokenAuthState> {
  final TokenAuthRepository _authRepository;

  TokenAuthBloc(this._authRepository) : super(TokenAuthInitial()) {
    on<FetchTokenAuthToken>(_onFetchTokenAuthToken);
  }

  Future<void> _onFetchTokenAuthToken(
      FetchTokenAuthToken event, Emitter<TokenAuthState> emit) async {
    emit(TokenAuthLoading());
    try {
      final token = await _authRepository.fetchAccessToken();
      print("token: $token");
      if (token != null) {
        emit(TokenAuthLoaded(token));
      } else {
        emit(TokenAuthError("Failed to fetch token"));
      }
    } catch (e) {
      emit(TokenAuthError("An error occurred: $e"));
    }
  }
}
