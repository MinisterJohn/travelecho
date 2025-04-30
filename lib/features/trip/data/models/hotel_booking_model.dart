import 'package:equatable/equatable.dart';

class HotelBookingModel extends Equatable {
  final String id;
  final String hotelId;
  final String hotelName;
  final String cityCode;
  final String checkInDate;
  final String checkOutDate;
  final int adults;
  final int rooms;
  final List<GuestModel> guests;
  final double totalPrice;
  final String currency;
  final String status;

  const HotelBookingModel({
    required this.id,
    required this.hotelId,
    required this.hotelName,
    required this.cityCode,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.rooms,
    required this.guests,
    required this.totalPrice,
    required this.currency,
    required this.status,
  });

  factory HotelBookingModel.fromJson(Map<String, dynamic> json) {
    // For search results
    if (json.containsKey('iataCode')) {
      return HotelBookingModel(
        id: json['id']?.toString() ?? '',
        hotelId: json['id']?.toString() ?? '',
        hotelName: json['name'] ?? '',
        cityCode: json['iataCode'] ?? '',
        checkInDate: '',
        checkOutDate: '',
        adults: 1,
        rooms: 1,
        guests: const [],
        totalPrice: 0.0,
        currency: 'USD',
        status: 'AVAILABLE',
      );
    }

    // For booking details
    return HotelBookingModel(
      id: json['id']?.toString() ?? '',
      hotelId: json['hotelId']?.toString() ?? '',
      hotelName: json['name'] ?? '',
      cityCode: json['cityCode'] ?? '',
      checkInDate: json['checkInDate'] ?? '',
      checkOutDate: json['checkOutDate'] ?? '',
      adults: json['adults'] ?? 1,
      rooms: json['rooms'] ?? 1,
      guests: const [],
      totalPrice: (json['price']?['total'] ?? 0.0).toDouble(),
      currency: json['price']?['currency'] ?? 'USD',
      status: json['status'] ?? 'PENDING',
    );
  }

  static List<HotelBookingModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => HotelBookingModel.fromJson(json)).toList();
  }

  @override
  List<Object?> get props => [
        id,
        hotelId,
        hotelName,
        cityCode,
        checkInDate,
        checkOutDate,
        adults,
        rooms,
        guests,
        totalPrice,
        currency,
        status,
      ];
}

class GuestModel extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String type; // ADULT, CHILD

  const GuestModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.type,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, email, phone, type];
}
