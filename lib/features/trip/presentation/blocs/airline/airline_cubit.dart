import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../trip_exports.dart';

part 'airline_state.dart';

class AirlineCubit extends Cubit<AirlineState> {
  final FlightOffersRepository repository = sl<FlightOffersRepository>();

  // Cache for airline information
  final Map<String, dynamic> _airlineCache = {};

  AirlineCubit() : super(AirlineInitial());

  Future<void> searchAirline(String airlineCode) async {
    // Check if we already have the airline info in our cache
    if (_airlineCache.containsKey(airlineCode)) {
      emit(AirlineLoaded(_airlineCache[airlineCode]));
      return;
    }

    try {
      emit(AirlineLoading());

      // If not in cache, fetch from repository
      final results = await repository.searchAirline(airlineCode);

      // Store in cache for future use
      if (results.isNotEmpty) {
        _airlineCache[airlineCode] = results;
      }

      emit(AirlineLoaded(results));
    } catch (e) {
      emit(AirlineError(e.toString()));
    }
  }
}
