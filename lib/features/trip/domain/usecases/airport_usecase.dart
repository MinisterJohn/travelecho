import "../../trip_exports.dart";

class SearchAirport {
  final AirportRepository repository = sl<AirportRepository>();

  SearchAirport();

  Future<List<Airport>> call(String query) async {
    return await repository.searchCitiesAndAirports(query);
  }
}
