import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../../trip_exports.dart";
part 'flight_offers_event.dart';
part 'flight_offers_state.dart';

class FlightOffersBloc extends Bloc<FlightOffersEvent, FlightOffersState> {
  final FlightOffersRepository repository = sl<FlightOffersRepository>();

  FlightOffersBloc() : super(FlightOffersInitial()) {
    on<SearchFlightOffers>(_onSearchFlightOffers);
    on<SearchAirline>(_onSearchAirline);
  }

  Future<void> _onSearchFlightOffers(
    SearchFlightOffers event,
    Emitter<FlightOffersState> emit,
  ) async {
    try {
      emit(FlightOffersLoading());
      final results = await repository.searchFlightOffers(
        origin: event.origin,
        destination: event.destination,
        departureDate: event.departureDate,
        adults: event.adults,
        children: event.children,
        infants: event.infants,
      );
      emit(FlightOffersLoaded(results));
    } catch (e) {
      emit(FlightOffersError(e.toString()));
    }
  }

  Future<void> _onSearchAirline(
    SearchAirline event,
    Emitter<FlightOffersState> emit,
  ) async {
    try {
      final results = await repository.searchAirline(event.airlineCode);
      emit(FlightOffersAirlineLoaded(results));
    } catch (e) {
      emit(FlightOffersError(e.toString()));
    }
  }
}
