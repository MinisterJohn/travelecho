import 'package:dio/dio.dart';
// import "../../trip_exports.dart";

class TokenApiService {
  final Dio _dio = Dio();

  final String _baseUrl =
      "https://test.api.amadeus.com/v1/security/oauth2/token";
  final String _clientId = "I3w76NykBMzRKV55AHRBWVhDS8KB8fKZ";
  final String _clientSecret = "PkTAtKAb1UZGbk6m";

  Future<String?> getAccessToken() async {
    try {
      final response = await _dio.post(
        _baseUrl,
        options: Options(headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        }),
        data: {
          "grant_type": "client_credentials",
          "client_id": _clientId,
          "client_secret": _clientSecret,
        },
      );

      if (response.statusCode == 200) {
        return response.data["access_token"];
      }
      return null;
    } catch (e) {
      print("Error fetching token: $e");
      return null;
    }
  }
}
