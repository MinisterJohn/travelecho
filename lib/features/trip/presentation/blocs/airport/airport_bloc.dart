import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import "../../../trip_exports.dart";

part 'airport_event.dart';
part 'airport_state.dart';

class AirportBloc extends Bloc<AirportEvent, AirportState> {
  final SearchAirport searchAirport = sl<SearchAirport>();

  AirportBloc() : super(AirportInitial()) {
    on<SearchAirportEvent>((event, emit) async {
      emit(AirportLoading());
      try {
        final results = await searchAirport(event.query);
        emit(AirportLoaded(results));
      } catch (e) {
        emit(AirportError("Failed to load results"));
      }
    });
    on<ClearAirportSearch>(_onClearAirportSearch);
  }

  void _onClearAirportSearch(
      ClearAirportSearch event, Emitter<AirportState> emit) {
    emit(AirportInitial());
  }
}
