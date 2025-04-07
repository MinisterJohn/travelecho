part of 'flight_booking_bloc.dart';

abstract class FlightBookingEvent extends Equatable {
  const FlightBookingEvent();

  @override
  List<Object?> get props => [];
}

class RequestFlightBooking extends FlightBookingEvent {
  final FlightBookingModel flightBooking;

  const RequestFlightBooking({required this.flightBooking});

  @override
  List<Object?> get props => [flightBooking];
}

enum FlightBookingUpdateKey {
  originDestination,
  traveler,
  cabinRestriction,
  maxFlightOffers,
  currencyCode,
  sources,
  travelerDetails,
}

class UpdateFlightBooking extends FlightBookingEvent {
  final FlightBookingUpdateKey updateKey;
  final dynamic updateValue;

  const UpdateFlightBooking({
    required this.updateKey,
    required this.updateValue,
  });

  @override
  List<Object?> get props => [updateKey, updateValue];
}

class UpdateTravelerDetails extends FlightBookingEvent {
  final String travelerId;
  final TravelerDetails details;

  const UpdateTravelerDetails({
    required this.travelerId,
    required this.details,
  });

  @override
  List<Object?> get props => [travelerId, details];
}
