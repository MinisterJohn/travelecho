part of "hotel_booking_bloc.dart";

// Events
abstract class HotelBookingEvent extends Equatable {
  const HotelBookingEvent();

  @override
  List<Object?> get props => [];
}

class SearchHotels extends HotelBookingEvent {
  final String query;

  const SearchHotels({
    required this.query
  });

  @override
  List<Object?> get props =>
      [query];
}

class BookHotel extends HotelBookingEvent {
  final String hotelId;
  final String checkInDate;
  final String checkOutDate;
  final int adults;
  final int rooms;
  final List<GuestModel> guests;

  const BookHotel({
    required this.hotelId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.rooms,
    required this.guests,
  });

  @override
  List<Object?> get props => [
        hotelId,
        checkInDate,
        checkOutDate,
        adults,
        rooms,
        guests,
      ];
}

class GetBookingDetails extends HotelBookingEvent {
  final String bookingId;

  const GetBookingDetails(this.bookingId);

  @override
  List<Object?> get props => [bookingId];
}

class CancelBooking extends HotelBookingEvent {
  final String bookingId;

  const CancelBooking(this.bookingId);

  @override
  List<Object?> get props => [bookingId];
}
