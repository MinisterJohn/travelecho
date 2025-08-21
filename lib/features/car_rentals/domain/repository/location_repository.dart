import '../../car_rentals_exports.dart';

abstract class LocationSuggestionRepository {
  Future<List<LocationSuggestion>> getSuggestions(String query);
}
