part of 'airport_bloc.dart';

abstract class AirportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchAirportEvent extends AirportEvent {
  final String query;

  SearchAirportEvent(this.query);

  @override
  List<Object> get props => [query];
}

class ClearAirportSearch extends AirportEvent {}
