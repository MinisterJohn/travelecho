import "package:dio/dio.dart";

import "../../trip_exports.dart";

class HotelBookingRepositoryImpl implements HotelBookingRepository {
  final AmadeusApiService _amadeusService = sl<AmadeusApiService>();

  HotelBookingRepositoryImpl();

  @override
  Future<List<HotelBookingModel>> searchHotels({required String query}) async {
    try {
      final response = await _amadeusService.get(
        "v1/reference-data/locations/hotel",
        params: {
          "keyword": query,
        "subType": "HOTEL_LEISURE",
        "lang": "EN",
        "max": 20,
      },
    );
    if (response.statusCode != 200) {
        print("API Error: Status ${response.statusCode}");
        throw Exception(
            "Failed to fetch hotels: Status ${response.statusCode}");
      }

      if (!response.data.containsKey("data")) {
        print("API Error: No data in response");
        return [];
      }

      final List<dynamic> results = response.data["data"];
      if (results.isEmpty) {
        return [];
      }

      return HotelBookingModel.fromJsonList(results);
    } on DioException catch (e) { 
      print("Dio Error: ${e.message}");
      if (e.response != null) {
        print("Error Response: ${e.response?.data}");
      }
      throw Exception("Network error while fetching hotels");
    } catch (e) {
      print("General Error: $e");
      throw Exception("Failed to fetch hotels: $e");
    }
  }

  @override
  Future<HotelBookingModel> bookHotel({
    required String hotelId,
    required String checkInDate,
    required String checkOutDate,
    required int adults,
    required int rooms,
    required List<GuestModel> guests,
  }) async {
    try {
      // First get the hotel offer
      final offerResponse = await _amadeusService.get(
        "v3/shopping/hotel-offers",
        params: {
        "hotelIds": hotelId,
        "adults": adults,
        "checkInDate": checkInDate,
        "roomQuantity": rooms,
        "paymentPolicy": "NONE",
        "bestRateOnly": true,
      },
      );

      if (offerResponse.statusCode != 200) {
        throw Exception(
            "Failed to get hotel offer: ${offerResponse.statusCode}");
      }

      // Extract the offer ID from the response
      final String offerId = offerResponse.data["data"][0]["id"];

      // Now book the hotel with the offer ID
      final bookingResponse =
          await _amadeusService.post("v2/booking/hotel-orders", data: {
        "data": {
          "type": "hotel-order",
          "guests": guests
              .map((guest) => {
                    "tid": 1,
                    "title": "MR",
                    "firstName": guest.firstName,
                    "lastName": guest.lastName,
                    "phone": guest.phone,
                    "email": guest.email
                  })
              .toList(),
          "travelAgent": {
            "contact": {"email": guests.isNotEmpty ? guests.first.email : ""}
          },
          "roomAssociations": [
            {
              "guestReferences": [
                {"guestReference": "1"}
              ],
              "hotelOfferId": offerId
            }
          ],
          "payment": {
            "method": "CREDIT_CARD",
            "paymentCard": {
              "paymentCardInfo": {
                "vendorCode": "VI",
                "cardNumber": "4151289722471370",
                "expiryDate": "2026-08",
                "holderName": guests.isNotEmpty
                    ? "${guests.first.firstName} ${guests.first.lastName}"
                    : "GUEST"
              }
            }
          }
        }
      });

      if (bookingResponse.statusCode != 201) {
        throw Exception("Failed to book hotel: ${bookingResponse.statusCode}");
      }

      return HotelBookingModel.fromJson(bookingResponse.data["data"]);
    } on DioException catch (e) {   
      print("Dio Error: ${e.message}");
      if (e.response != null) {
        print("Error Response: ${e.response?.data}");
      }
      throw Exception("Network error while booking hotel");
    } catch (e) {
      print("General Error: $e");
      throw Exception("Failed to book hotel: $e");
    }
  }

  @override
  Future<HotelBookingModel> getBookingDetails(String bookingId) async {
    try {
      final response =
          await _amadeusService.get("v2/booking/hotel-orders/$bookingId");

      if (response.statusCode != 200) {
        throw Exception(
            "Failed to get booking details: ${response.statusCode}");
      }

      return HotelBookingModel.fromJson(response.data["data"]);
    } on DioException catch (e) {
      print("Dio Error: ${e.message}");
      if (e.response != null) {
        print("Error Response: ${e.response?.data}");
      }
      throw Exception("Network error while getting booking details");
    } catch (e) {
      print("General Error: $e");
      throw Exception("Failed to get booking details: $e");
    }
  }

  // @override
  // Future<void> cancelBooking(String bookingId) {
  //   return _amadeusService.cancelBooking(bookingId);
  // }
}
