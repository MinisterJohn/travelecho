// import "../../trip_exports.dart";

abstract class FlightOffersRepository {
  Future<List<dynamic>> searchFlightOffers({
    required String origin,
    required String destination,
    required String departureDate,
    required int adults,
    required int children,
    required int infants,
  });

  Future<List<dynamic>> searchAirline(String airlineCode);

  /// Get pricing for a specific flight offer
  ///
  /// [flightOffer] - The flight offer to get pricing for
  /// Returns the updated flight offer with pricing information
  Future<dynamic> getFlightOfferPricing(dynamic flightOffer);
  Future<Map<String, dynamic>> getSeatmap(dynamic flightOffer);
}
