

part of 'airport_bloc.dart';



abstract class AirportState extends Equatable {
  @override
  List<Object> get props => [];
}

class AirportInitial extends AirportState {}

class AirportLoading extends AirportState {}

class AirportLoaded extends AirportState {
  final List<Airport> citiesAndAirports;

  AirportLoaded(this.citiesAndAirports);

  @override
  List<Object> get props => [citiesAndAirports];
}

class AirportError extends AirportState {
  final String message;

  AirportError(this.message);

  @override
  List<Object> get props => [message];
}
