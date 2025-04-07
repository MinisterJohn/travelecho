import "../../trip_exports.dart";
abstract class AirportRepository {
  Future<List<Airport>> searchCitiesAndAirports(String query);
}
