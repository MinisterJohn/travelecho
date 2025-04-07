part of 'flight_pricing_cubit.dart';

abstract class FlightPricingState extends Equatable {
  const FlightPricingState();

  @override
  List<Object> get props => [];
}

class FlightPricingInitial extends FlightPricingState {}

class FlightPricingLoading extends FlightPricingState {}

class FlightPricingLoaded extends FlightPricingState {
  final dynamic pricingData;

  const FlightPricingLoaded(this.pricingData);

  @override
  List<Object> get props => [pricingData];
}

class FlightPricingError extends FlightPricingState {
  final String message;

  const FlightPricingError(this.message);

  @override
  List<Object> get props => [message];
}
