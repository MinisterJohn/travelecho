import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import "../../../trip_exports.dart";

part 'airport_event.dart';
part 'airport_state.dart';

class AirportBloc extends Bloc<AirportEvent, AirportState> {
  final AirportApiService _apiService;

  AirportBloc(this._apiService) : super(AirportInitial()) {
    on<FetchAirports>(_onFetchAirports);
    on<ClearAirportSearch>(_onClearAirportSearch);
  }

  Future<void> _onFetchAirports(
      FetchAirports event, Emitter<AirportState> emit) async {
    emit(AirportLoading());
    try {
      final List<Airport> airports = await _apiService.fetchAirports(
          country: event.country, keyword: event.keyword);
      emit(AirportLoaded(airports));
    } catch (e) {
      emit(AirportError("Error fetching airports: $e"));
    }
  }

  void _onClearAirportSearch(
      ClearAirportSearch event, Emitter<AirportState> emit) {
    emit(AirportInitial());
  }
}
