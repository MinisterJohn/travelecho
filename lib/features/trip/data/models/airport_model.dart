import "../../trip_exports.dart";

class AirportModel extends Airport {
  const AirportModel({
    required super.name,
    required super.iataCode,
    required super.city,
    required super.country,
  });

  factory AirportModel.fromJson(Map<String, dynamic> json) {
    return AirportModel(
      name: json["name"] ?? "",
      iataCode: json["iataCode"] ?? "",
      city: json["address"]["cityName"] ?? "",
      country: json["address"]["countryName"] ?? "",
    );
  }

  static List<AirportModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => AirportModel.fromJson(json)).toList();
  }
}
