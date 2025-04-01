part of 'airport_bloc.dart';

abstract class AirportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAirports extends AirportEvent {
  final String keyword;
  final String country;

  FetchAirports(this.keyword, this.country);

  @override
  List<Object> get props => [keyword, country];
}

class ClearAirportSearch extends AirportEvent {}
