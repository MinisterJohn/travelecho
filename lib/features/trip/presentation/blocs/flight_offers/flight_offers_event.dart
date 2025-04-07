part of 'flight_offers_bloc.dart';

// abstract class FlightOffersEvent(){}

abstract class FlightOffersEvent extends Equatable {
  const FlightOffersEvent();

  @override
  List<Object> get props => [];
}

class SearchFlightOffers extends FlightOffersEvent {
  final String origin;
  final String destination;
  final String departureDate;
  final int adults;
  final int children;
  final int infants;

  const SearchFlightOffers({
    required this.origin,
    required this.destination,
    required this.departureDate,
    required this.adults,
    required this.children,
    required this.infants,
  });

  @override
  List<Object> get props =>
      [origin, destination, departureDate, adults, children, infants];
}

class SearchAirline extends FlightOffersEvent {
  final String airlineCode;

  const SearchAirline({required this.airlineCode});

  @override
  List<Object> get props => [airlineCode];
}
