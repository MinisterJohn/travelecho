part of 'flight_booking_bloc.dart';

enum FlightBookingUpdateKey {
  originDestination,
  traveler,
  cabinRestriction,
  maxFlightOffers,
  currencyCode,
  sources,
}

abstract class FlightBookingEvent extends Equatable {
  const FlightBookingEvent();

  @override
  List<Object?> get props => [];
}

// Event to request flight bookings
class RequestFlightBooking extends FlightBookingEvent {
  final FlightBookingModel flightBooking;

  const RequestFlightBooking({required this.flightBooking});

  @override
  List<Object?> get props => [flightBooking];
}

// Event to update a flight booking
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
