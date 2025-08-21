import '../../car_rentals_exports.dart';

class LocationSuggestionModel extends LocationSuggestion {
  LocationSuggestionModel({required String name, required String address})
      : super(name: name, address: address);

  factory LocationSuggestionModel.fromJson(Map<String, dynamic> json) {
    return LocationSuggestionModel(
      name: json['name'] ?? json['address_line1'] ?? '',
      address: json['formatted'] ?? '',
    );
  }
}