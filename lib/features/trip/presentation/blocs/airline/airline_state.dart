part of 'airline_cubit.dart';

abstract class AirlineState extends Equatable {
  const AirlineState();

  @override
  List<Object> get props => [];
}

class AirlineInitial extends AirlineState {}

class AirlineLoading extends AirlineState {}

class AirlineLoaded extends AirlineState {
  final List<dynamic> airlines;

  const AirlineLoaded(this.airlines);

  @override
  List<Object> get props => [airlines];
}

class AirlineError extends AirlineState {
  final String message;

  const AirlineError(this.message);

  @override
  List<Object> get props => [message];
}
