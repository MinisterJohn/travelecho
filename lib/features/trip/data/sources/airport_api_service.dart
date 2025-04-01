import "package:dio/dio.dart";

import "../../trip_exports.dart";

class AirportApiService {
  final Dio _dio = Dio();

  final String _apiKey =
      "MTkq8Iia+0OTFmrqxyS7gA==pq1eIO2mNhwey3WF"; // Replace with your actual API key

  Future<List<Airport>> fetchAirports(
      {String country = "", String keyword = ""}) async {
    try {
      print("Fetching airports with country: $country, keyword: $keyword");
      final response = await _dio.get(
        'https://api.api-ninjas.com/v1/airports',
        queryParameters: {
          if (country.isNotEmpty) "country": country,
          if (keyword.isNotEmpty) "name": keyword,
        },
        options: Options(
          headers: {"X-Api-Key": _apiKey},
        ),
      );

      print("API Response status: ${response.statusCode}");
      print("API Response data: ${response.data}");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        final airports = data.map((json) => Airport.fromJson(json)).toList();
        print("Parsed ${airports.length} airports");
        return airports;
      } else {
        throw Exception("Failed to load airports: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching airports: $e");
      throw Exception("Error fetching airports: $e");
    }
  }
}
