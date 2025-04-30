import '../../data/models/hotel_booking_model.dart';

abstract class HotelBookingRepository {
  Future<List<HotelBookingModel>> searchHotels({
    required String query,
    // required String checkInDate,
    // required String checkOutDate,
    // required int adults,
    // required int rooms,
  });

  Future<HotelBookingModel> bookHotel({
    required String hotelId,
    required String checkInDate,
    required String checkOutDate,
    required int adults,
    required int rooms,
    required List<GuestModel> guests,
  });

  Future<HotelBookingModel> getBookingDetails(String bookingId);
  // Future<void> cancelBooking(String bookingId);
}
