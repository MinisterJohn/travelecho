part of "hotel_booking_bloc.dart";

// States
abstract class HotelBookingState extends Equatable {
  const HotelBookingState();

  @override
  List<Object?> get props => [];
}

class HotelBookingInitial extends HotelBookingState {}

class HotelBookingLoading extends HotelBookingState {}

class HotelBookingSuccess extends HotelBookingState {
  final List<HotelBookingModel> hotels;
  final HotelBookingModel? currentBooking;

  const HotelBookingSuccess({
    this.hotels = const [],
    this.currentBooking,
  });

  @override
  List<Object?> get props => [hotels, currentBooking];
}

class HotelBookingError extends HotelBookingState {
  final String message;

  const HotelBookingError(this.message);

  @override
  List<Object?> get props => [message];
}