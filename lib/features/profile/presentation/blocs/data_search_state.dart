part of "data_search_bloc.dart";

abstract class DataSearchState extends Equatable {}

class DataSearchInitial extends DataSearchState {
  @override
  List<Object?> get props => [];
}

class DataSearchLoading extends DataSearchState {
  @override
  List<Object?> get props => [];
}

class SchoolListLoaded extends DataSearchState {
  final List<SchoolModel> schools;
  SchoolListLoaded(this.schools);
  @override
  List<Object?> get props => [schools];
}

class OccupationsLoaded extends DataSearchState {
  final OccupationsModel occupations;
  OccupationsLoaded(this.occupations);
  @override
  List<Object?> get props => [occupations];
}

class LanguagesLoaded extends DataSearchState {
  final List<LanguageModel> languages;
  LanguagesLoaded(this.languages);
  @override
  List<Object?> get props => [languages];
}

class InterestsLoaded extends DataSearchState {
  final List<InterestModel> interests;
  InterestsLoaded(this.interests);
  @override
  List<Object?> get props => [interests];
}

class DataSearchError extends DataSearchState {
  final String message;
  DataSearchError(this.message);
  @override
  List<Object?> get props => [message];
}
