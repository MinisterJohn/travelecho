import "../../trip_exports.dart";

class TokenAuthRepository {
  final TokenApiService _tokenApiService;

  TokenAuthRepository(this._tokenApiService);

  Future<String?> fetchAccessToken() async {
    return await _tokenApiService.getAccessToken();
  }
}
