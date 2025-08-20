import 'package:flutter_bloc/flutter_bloc.dart';
import '../../car_rentals_exports.dart';

abstract class LocationSuggestionState {}

class LocationInitial extends LocationSuggestionState {}

class LocationLoading extends LocationSuggestionState {}

class LocationLoaded extends LocationSuggestionState {
  final List<LocationSuggestion> suggestions;
  LocationLoaded(this.suggestions);
}

class LocationError extends LocationSuggestionState {
  final String message;
  LocationError(this.message);
}

class LocationSuggestionCubit extends Cubit<LocationSuggestionState> {
  final GetLocationSuggestionsUseCase useCase;

  LocationSuggestionCubit(this.useCase) : super(LocationInitial());

  Future<void> fetchSuggestions(String query) async {
    if (query.isEmpty) {
      emit(LocationInitial());
      return;
    }
    emit(LocationLoading());
    try {
      final suggestions = await useCase(query);
      emit(LocationLoaded(suggestions));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }
}
