import "../../trip_exports.dart";

class GetFlightOfferPricingUseCase {
  final FlightOffersRepository repository = sl<FlightOffersRepository>();

  GetFlightOfferPricingUseCase();

  Future<dynamic> call(dynamic flightOffer) async {
    return await repository.getFlightOfferPricing(flightOffer);
  }
}

class GetSeatmapUseCase {
  final FlightOffersRepository repository = sl<FlightOffersRepository>();

  GetSeatmapUseCase();

  Future<dynamic> call(dynamic flightOffer) async {
    return await repository.getSeatmap(flightOffer);
  }
}
