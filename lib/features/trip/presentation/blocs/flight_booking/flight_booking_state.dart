part of 'flight_booking_bloc.dart';

abstract class FlightBookingState extends Equatable {
  const FlightBookingState();

  @override
  List<Object?> get props => [];
}

// Initial State
class FlightBookingInitial extends FlightBookingState {}

// Loading State
class FlightBookingLoading extends FlightBookingState {}

// Success State
class FlightBookingSuccess extends FlightBookingState {
  final FlightBookingModel flightBooking;

  const FlightBookingSuccess({required this.flightBooking});

  @override
  List<Object?> get props => [flightBooking];
}

// Error State
class FlightBookingError extends FlightBookingState {
  final String message;

  const FlightBookingError({required this.message});

  @override
  List<Object?> get props => [message];
}
