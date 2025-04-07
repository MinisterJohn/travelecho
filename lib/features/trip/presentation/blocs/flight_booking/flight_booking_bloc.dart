import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../../trip_exports.dart";

part 'flight_booking_event.dart';
part 'flight_booking_state.dart';

class FlightBookingBloc extends Bloc<FlightBookingEvent, FlightBookingState> {
  FlightBookingModel flightBooking = FlightBookingModel(
    currencyCode: "USD",
    originDestinations: [],
    travelers: [],
    sources: ["GDS"],
    searchCriteria: SearchCriteria(
      maxFlightOffers: 1,
      flightFilters: FlightFilters(
        cabinRestrictions: [],
      ),
    ),
  );

  // Map to store traveler details
  final Map<String, TravelerDetails> travelerDetailsMap = {};

  FlightBookingBloc() : super(FlightBookingInitial()) {
    on<RequestFlightBooking>(_onRequestFlightBooking);
    on<UpdateFlightBooking>(_onUpdateFlightBooking);
    on<UpdateTravelerDetails>(_onUpdateTravelerDetails);
  }

  // Handling flight booking request
  Future<void> _onRequestFlightBooking(
      RequestFlightBooking event, Emitter<FlightBookingState> emit) async {
    emit(FlightBookingLoading());
    try {
      flightBooking = event.flightBooking;
      emit(FlightBookingSuccess(flightBooking: flightBooking));
    } catch (e) {
      emit(FlightBookingError(message: e.toString()));
    }
  }

  // Handling flight booking update
  Future<void> _onUpdateFlightBooking(
      UpdateFlightBooking event, Emitter<FlightBookingState> emit) async {
    try {
      // Create a new updated booking based on the update key and value
      FlightBookingModel updatedBooking = flightBooking;

      switch (event.updateKey) {
        case FlightBookingUpdateKey.originDestination:
          final originDestination = event.updateValue as OriginDestination;
          final updatedDestinations =
              List<OriginDestination>.from(flightBooking.originDestinations);

          // If there's an existing destination, update it instead of adding a new one
          if (updatedDestinations.isNotEmpty) {
            updatedDestinations[0] = originDestination;
      } else {
            updatedDestinations.add(originDestination);
          }

          updatedBooking =
              flightBooking.copyWith(originDestinations: updatedDestinations);
          break;

        case FlightBookingUpdateKey.traveler:
          final traveler = event.updateValue as Traveler;
          final updatedTravelers = List<Traveler>.from(flightBooking.travelers);
          updatedTravelers.add(traveler);
          updatedBooking = flightBooking.copyWith(travelers: updatedTravelers);
          break;

        case FlightBookingUpdateKey.cabinRestriction:
          final cabinRestriction = event.updateValue as CabinRestriction;
          final updatedRestrictions = List<CabinRestriction>.from(
            flightBooking.searchCriteria.flightFilters.cabinRestrictions,
          );
          updatedRestrictions.add(cabinRestriction);
          final updatedFilters =
              FlightFilters(cabinRestrictions: updatedRestrictions);
          final updatedSearchCriteria = SearchCriteria(
            maxFlightOffers: flightBooking.searchCriteria.maxFlightOffers,
            flightFilters: updatedFilters,
          );
          updatedBooking =
              flightBooking.copyWith(searchCriteria: updatedSearchCriteria);
          break;

        case FlightBookingUpdateKey.maxFlightOffers:
          final maxFlightOffers = event.updateValue as int;
          final updatedSearchCriteria = SearchCriteria(
            maxFlightOffers: maxFlightOffers,
            flightFilters: flightBooking.searchCriteria.flightFilters,
          );
          updatedBooking =
              flightBooking.copyWith(searchCriteria: updatedSearchCriteria);
          break;

        case FlightBookingUpdateKey.currencyCode:
          final currencyCode = event.updateValue as String;
          updatedBooking = flightBooking.copyWith(currencyCode: currencyCode);
          break;

        case FlightBookingUpdateKey.sources:
          final sources = event.updateValue as List<String>;
          updatedBooking = flightBooking.copyWith(sources: sources);
          break;

        case FlightBookingUpdateKey.travelerDetails:
          // This case is handled by the _onUpdateTravelerDetails method
          break;
      }

      flightBooking = updatedBooking;
      emit(FlightBookingSuccess(flightBooking: flightBooking));
    } catch (e) {
      emit(FlightBookingError(message: e.toString()));
    }
  }

  // Handling traveler details update
  Future<void> _onUpdateTravelerDetails(
      UpdateTravelerDetails event, Emitter<FlightBookingState> emit) async {
    try {
      // Store the traveler details in the map
      travelerDetailsMap[event.travelerId] = event.details;

      // Emit the current state to trigger a rebuild
      if (state is FlightBookingSuccess) {
        emit(FlightBookingSuccess(flightBooking: flightBooking));
      }
    } catch (e) {
      emit(FlightBookingError(message: e.toString()));
    }
  }

  // Helper methods for creating and updating booking data

  // Add origin destination
  void addOriginDestination({
    required String id,
    required String originLocationCode,
    required String originLocationName,
    required String destinationLocationCode,
    required String destinationLocationName,
    required String date,
    required String time,
  }) {
    final departureDateTimeRange = DepartureDateTimeRange(
      date: date,
      time: time,
    );

    final originDestination = OriginDestination(
      id: id,
      originLocationCode: originLocationCode,
      originLocationName: originLocationName,
      destinationLocationCode: destinationLocationCode,
      destinationLocationName: destinationLocationName,
      departureDateTimeRange: departureDateTimeRange,
    );

    add(UpdateFlightBooking(
      updateKey: FlightBookingUpdateKey.originDestination,
      updateValue: originDestination,
    ));
  }

  // Add traveler
  void addTraveler({
    required String id,
    required String travelerType,
  }) {
    final traveler = Traveler(
      id: id,
      travelerType: travelerType,
    );

    add(UpdateFlightBooking(
      updateKey: FlightBookingUpdateKey.traveler,
      updateValue: traveler,
    ));
  }

  // Add cabin restriction
  void addCabinRestriction({
    required String cabin,
    required String coverage,
    required List<String> originDestinationIds,
  }) {
    final cabinRestriction = CabinRestriction(
      cabin: cabin,
      coverage: coverage,
      originDestinationIds: originDestinationIds,
    );

    add(UpdateFlightBooking(
      updateKey: FlightBookingUpdateKey.cabinRestriction,
      updateValue: cabinRestriction,
    ));
  }

  // Update max flight offers
  void setMaxFlightOffers(int maxFlightOffers) {
    add(UpdateFlightBooking(
      updateKey: FlightBookingUpdateKey.maxFlightOffers,
      updateValue: maxFlightOffers,
    ));
  }

  // Update currency code
  void setCurrencyCode(String currencyCode) {
    add(UpdateFlightBooking(
      updateKey: FlightBookingUpdateKey.currencyCode,
      updateValue: currencyCode,
    ));
  }

  // Update sources
  void setSources(List<String> sources) {
    add(UpdateFlightBooking(
      updateKey: FlightBookingUpdateKey.sources,
      updateValue: sources,
    ));
  }

  // Update traveler details
  void updateTravelerDetails({
    required String travelerId,
    required TravelerDetails details,
  }) {
    add(UpdateTravelerDetails(
      travelerId: travelerId,
      details: details,
    ));
  }

  // Clear all booking data
  void clearBooking() {
    final emptyBooking = FlightBookingModel(
      currencyCode: "USD",
      originDestinations: [],
      travelers: [],
      sources: ["GDS"],
      searchCriteria: SearchCriteria(
        maxFlightOffers: 1,
        flightFilters: FlightFilters(
          cabinRestrictions: [],
        ),
      ),
    );

    add(RequestFlightBooking(flightBooking: emptyBooking));
    travelerDetailsMap.clear();
  }

  // Clear all travelers
  void clearTravelers() {
    final updatedBooking = flightBooking.copyWith(travelers: []);
    add(RequestFlightBooking(flightBooking: updatedBooking));
    travelerDetailsMap.clear();
  }
}
