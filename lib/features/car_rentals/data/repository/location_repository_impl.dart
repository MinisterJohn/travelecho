import '../../car_rentals_exports.dart';

class LocationSuggestionRepositoryImpl implements LocationSuggestionRepository {
  final LocationRemoteDataSource remoteDataSource;

  LocationSuggestionRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<LocationSuggestion>> getSuggestions(String query) {
    return remoteDataSource.getSuggestions(query);
  }
}