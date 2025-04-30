part of "data_search_bloc.dart";

abstract class DataSearchEvent extends Equatable {
  const DataSearchEvent();

  @override
  List<Object?> get props => [];
}

// 🔹 Request Events
class SchoolListRequested extends DataSearchEvent {
  final String schoolHint;
  const SchoolListRequested({required this.schoolHint});

  @override
  List<Object?> get props => [schoolHint];
}

class OccupationsRequested extends DataSearchEvent {
  final String occupationHint;
  const OccupationsRequested({required this.occupationHint});

  @override
  List<Object?> get props => [occupationHint];
}

class LanguagesRequested extends DataSearchEvent {
  final String languageHint;
  const LanguagesRequested({required this.languageHint});

  @override
  List<Object?> get props => [languageHint];
}

class InterestsRequested extends DataSearchEvent {
  final String interestHint;
  const InterestsRequested({required this.interestHint});

  @override
  List<Object?> get props => [interestHint];
}

class LocationListRequested extends DataSearchEvent {
  final String locationHint;
  const LocationListRequested({required this.locationHint});

  @override
  List<Object?> get props => [locationHint];
}

// 🔹 Generalized Clear Event
enum SearchType { school, occupation, language, interest, location }

class ClearSearchResults extends DataSearchEvent {
  final SearchType type;
  const ClearSearchResults({required this.type});

  @override
  List<Object?> get props => [type];
}
