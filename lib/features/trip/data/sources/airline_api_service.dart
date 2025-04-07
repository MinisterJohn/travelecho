import '../../trip_exports.dart';

class AirlineApiService {
  final AmadeusApiService apiClient = sl<AmadeusApiService>();
  final Map<String, dynamic> _airlineCache = {};
  final Duration _cacheExpiry = const Duration(hours: 24);
  final Map<String, DateTime> _cacheTimestamps = {};

  Future<List<dynamic>> getAirlineInfo(String airlineCode) async {
    // Check cache first
    if (_airlineCache.containsKey(airlineCode)) {
      final timestamp = _cacheTimestamps[airlineCode];
      if (timestamp != null &&
          DateTime.now().difference(timestamp) < _cacheExpiry) {
        print("Returning cached airline info for $airlineCode");
        return _airlineCache[airlineCode];
      }
    }

    // If not in cache or expired, fetch from API
    try {
      final response =
          await apiClient.get("v1/reference-data/airlines", params: {
        "airlineCodes": airlineCode,
      });

      if (response.statusCode == 200) {
        final data = response.data["data"] ?? [];
        // Cache the result
        _airlineCache[airlineCode] = data;
        _cacheTimestamps[airlineCode] = DateTime.now();
        return data;
      }
      throw Exception("Failed to fetch airline: ${response.statusCode}");
    } catch (e) {
      print("Error fetching airline info: $e");
      rethrow;
    }
  }
}
