import "../../trip_exports.dart";
import 'package:dio/dio.dart';

class AirportRepositoryImpl implements AirportRepository {
  final AmadeusApiService apiClient = sl<AmadeusApiService>();

  AirportRepositoryImpl();

  @override
  Future<List<Airport>> searchCitiesAndAirports(String query) async {
    try {
      if (query.isEmpty) {
        return [];
      }

      final response =
          await apiClient.get("v1/reference-data/locations", params: {
        "subType": "AIRPORT",
        "keyword": query,
        "page[limit]": 10,
        "view": "LIGHT" // Add light view for faster response
      });

      if (response.statusCode != 200) {
        print("API Error: Status ${response.statusCode}");
        throw Exception(
            "Failed to fetch airports: Status ${response.statusCode}");
      }

      if (!response.data.containsKey("data")) {
        print("API Error: No data in response");
        return [];
      }

      final List<dynamic> results = response.data["data"];
      if (results.isEmpty) {
        return [];
      }

      return AirportModel.fromJsonList(results);
    } on DioException catch (e) {
      print("Dio Error: ${e.message}");
      if (e.response != null) {
        print("Error Response: ${e.response?.data}");
      }
      throw Exception("Network error while fetching airports");
    } catch (e) {
      print("General Error: $e");
      throw Exception("Failed to fetch airports: $e");
    }
  }
}
