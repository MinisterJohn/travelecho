import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final String location;

  const LocationModel({required this.location});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      location: json['properties']['formatted'] as String,
    );
  }
  
  @override
  List<Object?> get props => [location];
}

class LocationListModel extends Equatable {
  final List<LocationModel> locations;

  const LocationListModel({required this.locations});

  factory LocationListModel.fromJson(List<dynamic> json) {
    return LocationListModel(
      locations: json.map((location) => LocationModel.fromJson(location)).toList(),
    );
  }

  List<LocationModel> toList() {
    return locations;
  }
  
  @override
  List<Object?> get props =>[locations];
}
