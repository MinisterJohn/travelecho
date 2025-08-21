import '../models/location_suggestion_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationRemoteDataSource {
  final String apiKey;

  LocationRemoteDataSource(this.apiKey);

  Future<List<LocationSuggestionModel>> getSuggestions(String query) async {
    final url =
        'https://api.geoapify.com/v1/geocode/autocomplete?text=$query&apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final features = data['features'] as List<dynamic>;
      return features
          .map((f) => LocationSuggestionModel.fromJson(f['properties']))
          .toList();
    } else {
      throw Exception('Failed to fetch suggestions');
    }
  }
}