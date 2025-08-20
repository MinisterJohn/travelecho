import '../../car_rentals_exports.dart';


class GetLocationSuggestionsUseCase {
  final LocationSuggestionRepository repository;

  GetLocationSuggestionsUseCase(this.repository);

  Future<List<LocationSuggestion>> call(String query) {
    return repository.getSuggestions(query);
  }
}

