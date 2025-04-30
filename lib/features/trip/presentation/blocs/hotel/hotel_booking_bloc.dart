import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import "../../../trip_exports.dart";

part "hotel_booking_event.dart";
part "hotel_booking_state.dart";

// Bloc
class HotelBookingBloc extends Bloc<HotelBookingEvent, HotelBookingState> {
  final HotelBookingRepository _repository = sl<HotelBookingRepository>();

  HotelBookingBloc() : super(HotelBookingInitial()) {
    on<SearchHotels>(_onSearchHotels);
    on<BookHotel>(_onBookHotel);
    on<GetBookingDetails>(_onGetBookingDetails);
    // on<CancelBooking>(_onCancelBooking);
  }

  Future<void> _onSearchHotels(
    SearchHotels event,
    Emitter<HotelBookingState> emit,
  ) async {
    try {
      emit(HotelBookingLoading());
      final hotels = await _repository.searchHotels(query: event.query);
      emit(HotelBookingSuccess(hotels: hotels));
    } catch (e) {
      emit(HotelBookingError(e.toString()));
    }
  }

  Future<void> _onBookHotel(
    BookHotel event,
    Emitter<HotelBookingState> emit,
  ) async {
    try {
      emit(HotelBookingLoading());
      final booking = await _repository.bookHotel(
        hotelId: event.hotelId,
        checkInDate: event.checkInDate,
        checkOutDate: event.checkOutDate,
        adults: event.adults,
        rooms: event.rooms,
        guests: event.guests,
      );
      emit(HotelBookingSuccess(currentBooking: booking));
    } catch (e) {
      emit(HotelBookingError(e.toString()));
    }
  }

  Future<void> _onGetBookingDetails(
    GetBookingDetails event,
    Emitter<HotelBookingState> emit,
  ) async {
    try {
      emit(HotelBookingLoading());
      final booking = await _repository.getBookingDetails(event.bookingId);
      emit(HotelBookingSuccess(currentBooking: booking));
    } catch (e) {
      emit(HotelBookingError(e.toString()));
    }
  }

  // Future<void> _onCancelBooking(
  //   CancelBooking event,
  //   Emitter<HotelBookingState> emit,
  // ) async {
  //   try {
  //     emit(HotelBookingLoading());
  //     await _repository.cancelBooking(event.bookingId);
  //     emit(HotelBookingInitial());
  //   } catch (e) {
  //     emit(HotelBookingError(e.toString()));
  //   }
  // }
}
