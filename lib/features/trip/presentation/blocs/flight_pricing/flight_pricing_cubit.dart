import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../trip_exports.dart';

part 'flight_pricing_state.dart';
// part 'flight_pricing_event.dart';

class FlightPricingCubit extends Cubit<FlightPricingState> {
  final GetFlightOfferPricingUseCase getFlightOfferPricingUseCase =
      sl<GetFlightOfferPricingUseCase>();

  FlightPricingCubit() : super(FlightPricingInitial());

  Future<void> getFlightOfferPricing(dynamic flightOffer) async {
    try {
      emit(FlightPricingLoading());
      final pricingData = await getFlightOfferPricingUseCase(flightOffer);
      emit(FlightPricingLoaded(pricingData));
    } catch (e) {
      emit(FlightPricingError(e.toString()));
    }
  }
}
