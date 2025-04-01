class Airport {
  final String name;
  final String iata;
  final String icao;
  final double latitude;
  final double longitude;
  final String country;
  final String region;

  Airport({
    required this.name,
    required this.iata,
    required this.icao,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.region,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      name: json['name'] ?? '',
      iata: json['iata'] ?? '',
      icao: json['icao'] ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      country: json['country'] ?? '',
      region: json['region'] ?? '',
    );
  }
}
