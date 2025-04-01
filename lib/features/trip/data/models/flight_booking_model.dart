class FlightBookingModel {
  final String currencyCode;
  final List<OriginDestination> originDestinations;
  final List<Traveler> travelers;
  final List<String> sources;
  final SearchCriteria searchCriteria;

  FlightBookingModel({
    required this.currencyCode,
    required this.originDestinations,
    required this.travelers,
    required this.sources,
    required this.searchCriteria,
  });

  FlightBookingModel copyWith({
    String? currencyCode,
    List<OriginDestination>? originDestinations,
    List<Traveler>? travelers,
    List<String>? sources,
    SearchCriteria? searchCriteria,
  }) {
    return FlightBookingModel(
      currencyCode: currencyCode ?? this.currencyCode,
      originDestinations: originDestinations ?? this.originDestinations,
      travelers: travelers ?? this.travelers,
      sources: sources ?? this.sources,
      searchCriteria: searchCriteria ?? this.searchCriteria,
    );
  }

  factory FlightBookingModel.fromJson(Map<String, dynamic> json) {
    return FlightBookingModel(
      currencyCode: json["currencyCode"],
      originDestinations: (json["originDestinations"] as List)
          .map((e) => OriginDestination.fromJson(e))
          .toList(),
      travelers:
          (json["travelers"] as List).map((e) => Traveler.fromJson(e)).toList(),
      sources: List<String>.from(json["sources"]),
      searchCriteria: SearchCriteria.fromJson(json["searchCriteria"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "currencyCode": currencyCode,
      "originDestinations": originDestinations.map((e) => e.toJson()).toList(),
      "travelers": travelers.map((e) => e.toJson()).toList(),
      "sources": sources,
      "searchCriteria": searchCriteria.toJson(),
    };
  }
}

class OriginDestination {
  final String id;
  final String originLocationCode;
  final String originLocationName;
  final String destinationLocationCode;
  final String destinationLocationName;
  final DepartureDateTimeRange departureDateTimeRange;

  OriginDestination({
    required this.id,
    required this.originLocationCode,
    required this.originLocationName,
    required this.destinationLocationCode,
    required this.destinationLocationName,
    required this.departureDateTimeRange,
  });

  factory OriginDestination.fromJson(Map<String, dynamic> json) {
    return OriginDestination(
      id: json["id"],
      originLocationCode: json["originLocationCode"],
      originLocationName: json["originLocationName"],
      destinationLocationCode: json["destinationLocationCode"],
      destinationLocationName: json["destinationLocationName"],
      departureDateTimeRange:
          DepartureDateTimeRange.fromJson(json["departureDateTimeRange"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "originLocationCode": originLocationCode,
      "destinationLocationCode": destinationLocationCode,
      "departureDateTimeRange": departureDateTimeRange.toJson(),
    };
  }
}

class DepartureDateTimeRange {
  final String date;
  final String time;

  DepartureDateTimeRange({required this.date, required this.time});

  factory DepartureDateTimeRange.fromJson(Map<String, dynamic> json) {
    return DepartureDateTimeRange(
      date: json["date"],
      time: json["time"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "time": time,
    };
  }
}

class Traveler {
  final String id;
  final String travelerType;

  Traveler({required this.id, required this.travelerType});

  factory Traveler.fromJson(Map<String, dynamic> json) {
    return Traveler(
      id: json["id"],
      travelerType: json["travelerType"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "travelerType": travelerType,
    };
  }
}

class SearchCriteria {
  final int maxFlightOffers;
  final FlightFilters flightFilters;

  SearchCriteria({required this.maxFlightOffers, required this.flightFilters});

  factory SearchCriteria.fromJson(Map<String, dynamic> json) {
    return SearchCriteria(
      maxFlightOffers: json["maxFlightOffers"],
      flightFilters: FlightFilters.fromJson(json["flightFilters"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "maxFlightOffers": maxFlightOffers,
      "flightFilters": flightFilters.toJson(),
    };
  }
}

class FlightFilters {
  final List<CabinRestriction> cabinRestrictions;

  FlightFilters({required this.cabinRestrictions});

  factory FlightFilters.fromJson(Map<String, dynamic> json) {
    return FlightFilters(
      cabinRestrictions: (json["cabinRestrictions"] as List)
          .map((e) => CabinRestriction.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cabinRestrictions": cabinRestrictions.map((e) => e.toJson()).toList(),
    };
  }
}

class CabinRestriction {
  final String cabin;
  final String coverage;
  final List<String> originDestinationIds;

  CabinRestriction({
    required this.cabin,
    required this.coverage,
    required this.originDestinationIds,
  });

  factory CabinRestriction.fromJson(Map<String, dynamic> json) {
    return CabinRestriction(
      cabin: json["cabin"],
      coverage: json["coverage"],
      originDestinationIds: List<String>.from(json["originDestinationIds"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cabin": cabin,
      "coverage": coverage,
      "originDestinationIds": originDestinationIds,
    };
  }
}
