import "../../trip_exports.dart";

class FlightOffersRepositoryImpl implements FlightOffersRepository {
  final AmadeusApiService apiClient = sl<AmadeusApiService>();
  final AirlineApiService airlineApiService = sl<AirlineApiService>();

  FlightOffersRepositoryImpl();

  @override
  Future<List<dynamic>> searchFlightOffers({
    required String origin,
    required String destination,
    required String departureDate,
    required int adults,
    required int children,
    required int infants,
  }) async {
    try {
      final response =
          await apiClient.get("v2/shopping/flight-offers", params: {
        "originLocationCode": origin,
        "destinationLocationCode": destination,
        "departureDate": departureDate,
        if (adults > 0) "adults": adults,
        if (children > 0) "children": children,
        if (infants > 0) "infants": infants,
        "nonStop": false,
        "currencyCode": "USD",
        "max": 250,
      });

      if (response.statusCode != 200) {
        throw Exception(
            "Failed to fetch flight offers: ${response.statusCode}");
      }
      print(response.data["data"]);
      return response.data["data"] ?? [];
    } catch (e) {
      print("Error searching flight offers: $e");
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> searchAirline(String airlineCode) async {
    try {
      return await airlineApiService.getAirlineInfo(airlineCode);
    } catch (e) {
      print("Error searching airline: $e");
      rethrow;
    }
  }

  @override
  Future<dynamic> getFlightOfferPricing(dynamic flightOffer) async {
    try {
      // Create a copy of the flight offer to avoid modifying the original
      final flightOfferCopy = Map<String, dynamic>.from(flightOffer);

      final response = await apiClient.post(
        "v1/shopping/flight-offers/pricing",
        data: {
          "data": {
            "type": "flight-offers-pricing",
            "flightOffers": [flightOfferCopy]
          }
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            "Failed to get flight offer pricing: ${response.statusCode}");
      }

      // Return the first flight offer from the response
      final data = response.data["data"];
      if (data == null ||
          data["flightOffers"] == null ||
          data["flightOffers"].isEmpty) {
        throw Exception("No flight offer pricing data returned");
      }
      print(data["flightOffers"][0]);
      return data["flightOffers"][0];
    } catch (e) {
      print("Error getting flight offer pricing: $e");
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getSeatmap(
      dynamic flightOffer) async {
      final flightOfferCopy = Map<String, dynamic>.from(flightOffer);

    try {
      final response = await apiClient.post(
        'v1/shopping/seatmaps',
        data: {
          'data': [
            flightOfferCopy
          ],
        },
      );
      print(response.data);
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch seatmap: $e');
    }
  }
}
