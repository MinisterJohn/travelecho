part of "flight_offers_bloc.dart";

abstract class FlightOffersState extends Equatable {
  const FlightOffersState();

  @override
  List<Object> get props => [];
}

class FlightOffersInitial extends FlightOffersState {}

class FlightOffersLoading extends FlightOffersState {}

class FlightOffersLoaded extends FlightOffersState {
  final List<dynamic> flightOffers;

  const FlightOffersLoaded(this.flightOffers);

  @override
  List<Object> get props => [flightOffers];
}

class FlightOffersAirlineLoaded extends FlightOffersState {
  final List<dynamic> airlines;

  const FlightOffersAirlineLoaded(this.airlines);

  @override
  List<Object> get props => [airlines];
}

class FlightOffersError extends FlightOffersState {
  final String message;

  const FlightOffersError(this.message);

  @override
  List<Object> get props => [message];
}
