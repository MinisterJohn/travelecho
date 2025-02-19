// part of "currency_bloc.dart";

import 'package:travelecho/features/profile/data/models/occupations_model.dart';
import 'package:travelecho/features/profile/data/models/schools_list_model.dart';

abstract class DataSearchState {}

class DataSearchInitial extends DataSearchState {}

class DataSearchLoading extends DataSearchState {}

class SchoolListLoaded extends DataSearchState {
  final List<SchoolModel> schools;
  SchoolListLoaded(this.schools);
}

class OccupationsLoaded extends DataSearchState {
  final OccupationsModel occupations;
  OccupationsLoaded(this.occupations);
}

class DataSearchError extends DataSearchState {
  final String message;
  DataSearchError(this.message);
}
