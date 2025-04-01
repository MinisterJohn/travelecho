part of 'flight_booking_bloc.dart';


abstract class FlightBookingState extends Equatable {
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

  FlightBookingSuccess({required this.flightBooking});

  @override
  List<Object?> get props => [flightBooking];
}

// Error State
class FlightBookingError extends FlightBookingState {
  final String message;

  FlightBookingError({required this.message});

  @override
  List<Object?> get props => [message];
}

