import 'package:equatable/equatable.dart';

class Airport extends Equatable {
  final String name;
  final String iataCode;
  final String city;
  final String country;

  const Airport({
    required this.name,
    required this.iataCode,
    required this.city,
    required this.country,
  });

  @override
  List<Object> get props => [name, iataCode, city, country];
}
