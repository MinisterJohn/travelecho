abstract class DataSearchEvent {}

class SchoolListRequested extends DataSearchEvent {
  final String schoolHint;
  SchoolListRequested({required this.schoolHint});
}

class OccupationsRequested extends DataSearchEvent {
  final String occupationHint;
  OccupationsRequested({required this.occupationHint});
}

class ClearSchoolList extends DataSearchEvent {}

class ClearOccupationList extends DataSearchEvent {}
